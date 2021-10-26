class Gocan < Formula
  desc "Forensics Code Analyzer"
  homepage "https://github.com/fouadh/gocan"
  version "0.2.1"
  if OS.mac?
    url "https://github.com/fouadh/gocan/releases/download/v#{version}/gocan-darwin-amd64"
    sha256 "0ac52d208d698a43b1642095c896935a60ad658b76947f899af216779c049ed0"
  elsif OS.linux?
    url "https://github.com/fouadh/gocan/releases/download/v#{version}/gocan-linux-amd64"
    sha256 "09b258bde331aa3c2a67efa089f68a040bc665f08087a49032547b4629a0df22"
  end
  
  depends_on :arch => :x86_64

  def install
    if OS.mac?
      bin.install "gocan-darwin-amd64" => "gocan"
    elsif OS.linux?
      bin.install "gocan-linux-amd64" => "gocan"
    end
  end

  test do
    assert_match /#{version.to_s}/, `gocan -v`.chomp
  end
end
