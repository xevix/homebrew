require 'formula'

class Qtweetlib < Formula
  url 'git://github.com/dschmidt/QTweetLib.git'
  version 'trunk'
  homepage 'https://github.com/dschmidt/QTweetLib/'

  depends_on 'cmake' => :build
  
  def install
    args = std_cmake_parameters.split
    args << ".."

    Dir.mkdir "build"
    Dir.chdir "build" do
      system "cmake", *args
      system "make install"
    end
  end
end
