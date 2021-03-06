require 'formula'

class Vlc < Formula
  url 'http://download.videolan.org/pub/videolan/vlc/1.1.8/vlc-1.1.8.tar.bz2'
  homepage 'http://www.videolan.org/vlc'
  md5 'c0065ec11b6fd12167cd440cbe0ef0d9'

  # depends_on 'cmake'

  def install
    # Compiler
    cc =   "CC=/Developer/usr/bin/llvm-gcc-4.2"
    cxx =  "CXX=/Developer/usr/bin/llvm-g++-4.2"
    objc = "OBJC=/Developer/usr/bin/llvm-gcc-4.2"
    exp = "export #{cc}; export #{cxx}; export #{objc}"
    
    # Additional Libs
    if MACOS_VERSION == 10.5
      system "#{exp}; cd extras/contrib; ./bootstrap"
    else
      # Yes, I realize this is ugly, but hardcoding SDKs is ugly too
      ['configure','configure.ac','extras/contrib/bootstrap'].each do |file|
        inreplace file do |s|
          s.gsub! /10.5/, '10.6'
        end
      end
      system "#{exp}; cd extras/contrib; ./bootstrap x86_64-apple-darwin10"
    end
    system "#{exp}; cd extras/contrib; make"

    # VLC
    system "#{exp}; ./bootstrap"
    if MACOS_VERSION == 10.5
      system "#{exp}; ./configure --enable-debug --prefix=#{prefix}"
    else
      system "#{exp}; ./configure --enable-debug  --build=x86_64-apple-darwin10 --with-macosx-sdk=/Developer/SDKs/MacOSX10.6.sdk --prefix=#{prefix}"
    end
    system "#{exp}; make install"
  end
end
