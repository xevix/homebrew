require 'formula'

class Vlc < Formula
  url 'http://download.videolan.org/pub/videolan/vlc/1.1.8/vlc-1.1.8.tar.bz2'
  homepage 'http://www.videolan.org/vlc'
  md5 'c0065ec11b6fd12167cd440cbe0ef0d9'

  # depends_on 'cmake'

  def install
    # Compiler
    cc =   "export CC=/Developer/usr/bin/llvm-gcc-4.2"
    cxx =  "export CXX=/Developer/usr/bin/llvm-g++-4.2"
    objc = "export OBJC=/Developer/usr/bin/llvm-gcc-4.2"
    exp = "#{cc}; #{cxx}; #{objc}"
    
    # Additional Libs
    system "#{exp}; cd extras/contrib; ./bootstrap x86_64-apple-darwin10"
    system "#{exp}; cd extras/contrib; make"

    # VLC
    system "#{exp} ./bootstrap"
    system "#{exp} ./configure --enable-debug  --build=x86_64-apple-darwin10 --prefix=#{prefix}"
    # system "cmake . #{std_cmake_parameters}"
    system "#{exp} make install"
  end
end
