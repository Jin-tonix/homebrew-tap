class Kakaocli < Formula
  desc "CLI tool for KakaoTalk on macOS — read chats, search messages, send texts"
  homepage "https://github.com/silver-flight-group/kakaocli"
  # 병합대기중(silver-flight-group/kakaocli#24) — 여러 계정 흔적 있는 맥에서 잘못된 키로
  # 조용히 확정되던 버그 수정판. 병합되면 공식 태그로 되돌린다.
  url "https://github.com/Jin-tonix/kakaocli.git",
      branch: "fix/verify-derived-db-key",
      revision: "9b1c358e8dd274defa1d2aef1dafe69292074da6"
  version "0.6.0"
  license "MIT"
  head "https://github.com/silver-flight-group/kakaocli.git", branch: "main"

  depends_on :macos
  depends_on "sqlcipher"

  bottle do
    root_url "https://github.com/Jin-tonix/homebrew-tap/releases/download/kakaocli-0.6.0"
    rebuild 3
    sha256 cellar: :any, sequoia: "67ed2e3f28a881634882a26256cc3ee06caf38fa7fdc619ef1b1b49acbcf3227"
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
