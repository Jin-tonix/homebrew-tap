class Kakaocli < Formula
  desc "CLI tool for KakaoTalk on macOS — read chats, search messages, send texts"
  homepage "https://github.com/Jin-tonix/styleseller-kakaocli"
  # silver-flight-group/kakaocli(공식) 대신 실제 개발중인 사설 리포를 직접 가리킨다 —
  # 예전엔 여기가 아예 딴 repo(구fork, fix/verify-derived-db-key 브랜치, 9b1c358 고정)를
  # 박아놔서 그 뒤 실제 리포에 들어간 auth fix(계정전환 재검증, 브루트포스 30분 상향,
  # mtime tie-break 락경합 제거 등)가 하나도 안 들어왔다(2026-08-06 실측: userId
  # 자동탐지 계속 실패 + sync --follow가 판정 오판마다 브루트포스 재실행해 CPU 500~900%
  # 몇시간 지속). revision은 안정판 나올 때마다 최신 커밋 해시로 갱신한다.
  url "https://github.com/Jin-tonix/styleseller-kakaocli.git",
      branch: "main",
      revision: "a6cf65f675bb10e7c3a25be2ed84c79bb7530092"
  version "0.9.1"
  license "MIT"
  # 위 url의 revision(git커밋 해시)만 바꾸고 version 문자열을 그대로 두면 `brew
  # upgrade`가 "버전 동일 = 이미 최신"으로 오판해 재빌드를 통째로 스킵한다(2026-08-21
  # 실측: revision을 세 번 갱신했는데도 로컬 설치본이 계속 구커밋 그대로 빌드된 상태로
  # 남아있었음 — Homebrew는 version 문자열이나 이 정수 revision이 바뀌어야 재빌드를
  # 인식한다). 앞으로 url revision을 갱신할 때마다 이 정수도 반드시 +1 할 것.
  revision 2
  head "https://github.com/Jin-tonix/styleseller-kakaocli.git", branch: "main"

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
