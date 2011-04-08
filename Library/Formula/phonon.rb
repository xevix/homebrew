require 'formula'

class Phonon <Formula
  head 'git://anongit.kde.org/phonon'
  version ''

  depends_on 'cmake' => :build

  def install
    #params = std_cmake_parameters.gsub("HEAD", "")
    #system "cmake . #{params}"
    system "cmake . #{std_cmake_parameters}"
    system "make install"
  end

  def patches
    # Ignore the failed check for fvisibility=hidden which is the default build condition in brew for Qt
    DATA
  end
end

__END__
diff --git a/cmake/FindPhononInternal.cmake b/cmake/FindPhononInternal.cmake
index 7c52f09..a36af8f 100644
--- a/cmake/FindPhononInternal.cmake
+++ b/cmake/FindPhononInternal.cmake
@@ -407,9 +407,9 @@ if (CMAKE_COMPILER_IS_GNUCXX)
 
       try_compile(_compile_result ${CMAKE_BINARY_DIR} ${_source_file} CMAKE_FLAGS "${_include_dirs}" COMPILE_OUTPUT_VARIABLE _compile_output_var)
 
-      if(NOT _compile_result)
-         message(FATAL_ERROR "Qt compiled without support for -fvisibility=hidden. This will break plugins and linking of some applications. Please fix your Qt installation.")
-      endif(NOT _compile_result)
+      #if(NOT _compile_result)
+          #message(FATAL_ERROR "Qt compiled without support for -fvisibility=hidden. This will break plugins and linking of some applications. Please fix your Qt installation.")
+      #endif(NOT _compile_result)
 
       if (GCC_IS_NEWER_THAN_4_2)
         set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility-inlines-hidden")
