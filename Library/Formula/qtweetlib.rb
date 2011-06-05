require 'formula'

class Qtweetlib < Formula
  url 'git://github.com/minimoog/QTweetLib.git'
  version 'trunk'
  homepage 'https://github.com/minimoog/QTweetLib/'
  
  def install
    Dir.mkdir "build"
    Dir.chdir "build" do
      system "qmake  .."
      system "make sub-src"
      prefix.install Dir['lib']
    end
  end
end
