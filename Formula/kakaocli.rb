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
