require 'formula'

class PhononVlc <Formula
  head 'git://anongit.kde.org/phonon-vlc'

  depends_on 'cmake' => :build
  depends_on 'phonon'

  def install
    system "cmake . #{std_cmake_parameters}"
    system "make install"
  end

  def patches
    DATA
  end

end

__END__
diff --git a/vlc/backend.cpp b/vlc/backend.cpp
index b5967b7..a95c859 100644
--- a/vlc/backend.cpp
+++ b/vlc/backend.cpp
@@ -280,12 +280,14 @@ QList<int> Backend::objectDescriptionIndexes(ObjectDescriptionType type) const
             list.append(deviceList[dev].id);
     }
     break;
+    /*
     case Phonon::VideoCaptureDeviceType: {
         deviceList = deviceManager()->videoCaptureDevices();
         for (dev = 0 ; dev < deviceList.size() ; ++dev)
             list.append(deviceList[dev].id);
     }
     break;
+    */
     case Phonon::EffectType: {
         QList<EffectInfo *> effectList = effectManager()->effects();
         for (int eff = 0; eff < effectList.size(); ++eff) {
@@ -314,6 +316,7 @@ QHash<QByteArray, QVariant> Backend::objectDescriptionProperties(ObjectDescripti
         }
     }
     break;
+    /*
     case Phonon::AudioCaptureDeviceType: {
         deviceList = deviceManager()->audioCaptureDevices();
         if (index >= 0 && index < deviceList.size()) {
@@ -321,12 +324,14 @@ QHash<QByteArray, QVariant> Backend::objectDescriptionProperties(ObjectDescripti
             ret.insert("description", deviceList[index].description);
             ret.insert("icon", QLatin1String("audio-input-microphone"));
             ret.insert("isAdvanced", deviceList[index].isAdvanced);
-            ret.insert("deviceAccessList", QVariant::fromValue<Phonon::DeviceAccessList>(deviceList[index].accessList));
+            ret.insert("deviceAccessList1", QVariant::fromValue<Phonon::VLC::DeviceAccessList1>(deviceList[index].accessList));
             if (deviceList[index].capabilities & DeviceInfo::VideoCapture)
                 ret.insert("hasvideo", true);
         }
     }
     break;
+    */
+    /*
     case Phonon::VideoCaptureDeviceType: {
         deviceList = deviceManager()->videoCaptureDevices();
         if (index >= 0 && index < deviceList.size()) {
@@ -340,6 +345,7 @@ QHash<QByteArray, QVariant> Backend::objectDescriptionProperties(ObjectDescripti
         }
     }
     break;
+    */
     case Phonon::EffectType: {
         QList<EffectInfo *> effectList = effectManager()->effects();
         if (index >= 0 && index <= effectList.size()) {
diff --git a/vlc/devicemanager.cpp b/vlc/devicemanager.cpp
index cb060d6..576f3cc 100644
--- a/vlc/devicemanager.cpp
+++ b/vlc/devicemanager.cpp
@@ -200,13 +200,13 @@ void DeviceManager::updateDeviceList()
     while (p_ao_list) {
         if (checkpulse && strcmp(p_ao_list->psz_name, "pulse") == 0) {
             aos.last().isAdvanced = false;
-            aos.last().accessList.append(DeviceAccess("pulse", "default"));
+            aos.last().accessList.append(DeviceAccess1("pulse", "default"));
             haspulse = true;
             break;
         }
 
         aos.append(DeviceInfo(p_ao_list->psz_name, p_ao_list->psz_description, true));
-        aos.last().accessList.append(DeviceAccess(p_ao_list->psz_name, QString()));
+        aos.last().accessList.append(DeviceAccess1(p_ao_list->psz_name, QString()));
         aos.last().capabilities = DeviceInfo::AudioOutput;
 
         p_ao_list = p_ao_list->p_next;
diff --git a/vlc/devicemanager.h b/vlc/devicemanager.h
index 10c0f3c..267601e 100644
--- a/vlc/devicemanager.h
+++ b/vlc/devicemanager.h
@@ -31,6 +31,8 @@ namespace Phonon
 {
 namespace VLC
 {
+  typedef QPair<QByteArray, QString> DeviceAccess1;
+  typedef QList<DeviceAccess1> DeviceAccessList1;
 
 class Backend;
 
@@ -60,7 +62,7 @@ public:
     QByteArray name;
     QString description;
     bool isAdvanced;
-    DeviceAccessList accessList;
+    DeviceAccessList1 accessList;
     quint16 capabilities;
 };
 
@@ -161,4 +163,7 @@ private:
 
 QT_END_NAMESPACE
 
+//Q_DECLARE_METATYPE(Phonon::VLC::DeviceAccess1)
+//Q_DECLARE_METATYPE(Phonon::VLC::DeviceAccessList1)
+
 #endif // Phonon_VLC_DEVICEMANAGER_H
diff --git a/vlc/mediaobject.cpp b/vlc/mediaobject.cpp
index 0c51013..d27036a 100644
--- a/vlc/mediaobject.cpp
+++ b/vlc/mediaobject.cpp
@@ -318,15 +318,17 @@ void MediaObject::setSource(const MediaSource &source)
             break;
         }
         break;
+	/*
     case MediaSource::CaptureDevice:
         if (source.deviceAccessList().isEmpty()) {
             error() << Q_FUNC_INFO << "No device access list for this capture device";
             break;
         }
-
+	*/
         // TODO try every device in the access list until it works, not just the first one
-        driverName = source.deviceAccessList().first().first;
-        deviceName = source.deviceAccessList().first().second;
+	//        driverName = source.deviceAccessList().first().first;
+	//        deviceName = source.deviceAccessList().first().second;
+	driverName = "foobar";
 
         if (driverName == "v4l2") {
             loadMedia("v4l2://" + deviceName);
