class Gocan < Formula
  desc "Forensics Code Analyzer"
  homepage "https://github.com/fouadh/gocan"
  version "0.2.2"
  if OS.mac?
    url "https://github.com/fouadh/gocan/releases/download/v#{version}/gocan-darwin-amd64"
    sha256 "d73431d4e67d78297ae89d1b96f37c80ca1b6907680b6464e9e58daf0a871f84"
  elsif OS.linux?
    url "https://github.com/fouadh/gocan/releases/download/v#{version}/gocan-linux-amd64"
    sha256 "975991da25dea45bc4ef3d81622964825974d1617903d2bb437b56298663ef10"
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
