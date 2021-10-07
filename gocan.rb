class Gocan < Formula
  desc "Forensics Code Analyzer"
  homepage "https://github.com/fouadh/gocan"
  version "0.2.0"
  if OS.mac?
    url "https://github.com/fouadh/gocan/releases/download/v#{version}/gocan-darwin-amd64"
    sha256 "f92ad48d5a382abad936aa982d8a1d8af76b1fa86c1f795ab0b324bf73c0845a"
  elsif OS.linux?
    url "https://github.com/fouadh/gocan/releases/download/v#{version}/gocan-linux-amd64"
    sha256 "b23966820c141b40744f63a3acf39b889292c9d852d178e12f3aa62c7806b705"
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
