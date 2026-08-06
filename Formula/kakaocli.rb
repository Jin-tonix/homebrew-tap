class Kakaocli < Formula
  desc "CLI tool for KakaoTalk on macOS — read chats, search messages, send texts"
  homepage "https://github.com/silver-flight-group/kakaocli"
  url "https://github.com/silver-flight-group/kakaocli.git",
      tag: "v0.6.0",
      revision: "8b6ffcfdaebc592a735dc1a8bd5e50037e626406"
  license "MIT"
  head "https://github.com/silver-flight-group/kakaocli.git", branch: "main"

  depends_on :macos
  depends_on "sqlcipher"

  bottle do
    root_url "https://github.com/Jin-tonix/homebrew-tap/releases/download/kakaocli-0.6.0"
    rebuild 1
    sha256 cellar: :any, sequoia: "0700b31220c0ba2dfff6c446f7d63b33da9b7b14db54af994bf4d03a35ab4669"
  end

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/kakaocli"
  end

  test do
    # Basic smoke test — status command returns info about KakaoTalk installation
    output = shell_output("#{bin}/kakaocli status 2>&1", 1)
    assert_match(/kakaotalk|container|database/i, output)
  end
end
