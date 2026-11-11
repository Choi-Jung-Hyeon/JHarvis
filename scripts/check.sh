#!/usr/bin/env bash
# 레포 체크를 한 번에 돌린다. CI도 같은 명령을 부른다(검사 명령은 이 파일 한 곳에).
# 사용: bash scripts/check.sh [shell|md|actions|links|py|unit]...   (인자 없으면 전부)
# 로컬에서 도구가 없으면 건너뛰고 알린다. CI(CI=true)에서는 도구가 없으면 실패한다.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 2
FAIL=0; SKIP=()

need() {
  command -v "$1" >/dev/null && return 0
  if [ "${CI:-}" = true ]; then echo "도구 없음: $1"; FAIL=1; else SKIP+=("$1"); fi
  return 1
}
run() { echo "▶ $*"; "$@" || FAIL=1; }

shell()   { need shellcheck && run shellcheck scripts/*.sh tests/*.sh; }
# claude/skills/<스킬>/ 은 SHA 고정한 외부 원본이라 검사에서 뺀다. 규칙은 .markdownlint.jsonc
md()      { need npx && run npx --yes markdownlint-cli2@0.24.0 '**/*.md' '#claude/skills/*/**' '#node_modules'; }
actions() { need actionlint && run actionlint .github/workflows/*.yml templates/github/workflows/*.yml; }
# 내부 링크만 실패 처리. 외부 링크는 CI에서 경고만 낸다(ci.yml links 잡)
links()   { need lychee && run lychee --offline --no-progress README.md START.md; }
py()      { need ruff && run ruff check .; }
unit()    {
  run bash tests/bootstrap.sh
  run python3 claude/hooks/test_guard.py
  run python3 templates/github/scripts/test_free_tier_watch.py
}

[ $# -eq 0 ] && set -- shell md actions links py unit
for c in "$@"; do
  case "$c" in shell|md|actions|links|py|unit) "$c" ;; *) echo "모르는 체크: $c"; exit 2 ;; esac
done
[ ${#SKIP[@]} -gt 0 ] && echo "건너뜀(설치 필요): ${SKIP[*]}"
if [ "$FAIL" = 0 ]; then echo "✓ 통과"; else echo "✗ 실패"; exit 1; fi
