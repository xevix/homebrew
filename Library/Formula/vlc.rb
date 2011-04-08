require 'formula'

class Vlc < Formula
  url 'http://download.videolan.org/pub/videolan/vlc/1.1.8/vlc-1.1.8.tar.bz2'
  homepage 'http://www.videolan.org/vlc'
  md5 'c0065ec11b6fd12167cd440cbe0ef0d9'

  # depends_on 'cmake'

  def install
    # Compiler
    system "export CC=/Developer/usr/bin/llvm-gcc-4.2"
    system "export CXX=/Developer/usr/bin/llvm-g++-4.2"
    system "export OBJC=/Developer/usr/bin/llvm-gcc-4.2"
    
    # Additional Libs
    system "cd vlc/extras/contrib"
    system "./bootstrap x86_64-apple-darwin10"
    system "make"

    # VLC
    system "cd ../.."
    system "./bootstrap"
    system "./configure --enable-debug  --build=x86_64-apple-darwin10 --prefix=#{prefix}"
    # system "cmake . #{std_cmake_parameters}"
    system "make install"
  end
end
