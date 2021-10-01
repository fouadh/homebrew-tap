class Gocan < Formula
  desc "Forensics Code Analyzer"
  homepage "https://github.com/fouadh/gocan"
  version "0.1.0"
  if OS.mac?
    url "https://github.com/fouadh/gocan/releases/download/v#{version}/gocan-darwin-amd64"
    sha256 "0126ba572ee657af9b0089ef114d8f8c6fd846dce9d35b2592c2946e0522360d"
  elsif OS.linux?
    url "https://github.com/fouadh/gocan/releases/download/v#{version}/gocan-linux-amd64"
    sha256 "4466ed9b2c960404c7683caa6e0c4de7b2473e59cda30e6a7586485f501b18b9"
  end
  
  depends_on :arch => :x86_64

  def install
    if OS.mac?
      bin.install gocan-darwin-amd64 => gocan
    elsif OS.linux?
      bin.install gocan-linux-amd64 => gocan
    end
  end

  test do
    assert_match /#{version.to_s}/, `gocan -v`.chomp
  end
end
