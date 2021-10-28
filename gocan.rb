class Gocan < Formula
  desc "Forensics Code Analyzer"
  homepage "https://github.com/fouadh/gocan"
  version "0.2.3"
  if OS.mac?
    url "https://github.com/fouadh/gocan/releases/download/v#{version}/gocan-darwin-amd64"
    sha256 "4d651c1f14cf830d6b67058095941d7a9c2e30eaa3c34016cd82558b4b0fd6c9"
  elsif OS.linux?
    url "https://github.com/fouadh/gocan/releases/download/v#{version}/gocan-linux-amd64"
    sha256 "3ad5cdd8d24bf9463a8700720f992a262a21ad56de02b759642caf57137b62f7"
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
