require 'formula'

class Liblastfm < Formula
  homepage 'https://github.com/mxcl/liblastfm/'
  url 'https://github.com/mxcl/liblastfm/tarball/0.3.1'
  md5 'e31617b5254624743ed084469f163a93'

  depends_on 'qt'
  depends_on 'fftw'
  depends_on 'libsamplerate'

  def install
    inreplace ["admin/Makefile.rb", "admin/qpp"],
      "File.dirname( __FILE__ )", "File.absolute_path(File.dirname( __FILE__ ))"
    system "./configure", "--release", "--prefix", prefix
    system "make"
    system "make install"
  end
end

