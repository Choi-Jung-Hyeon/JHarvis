#!/usr/bin/env bash
# github-setup.sh 테스트. 가짜 gh(PATH 맨 앞 스텁)로 미리보기, 공개, 비공개, 다시 실행을 본다. 실행: bash tests/github-setup.sh
# 스텁은 --jq를 실제로 돌리지 않고 그 결과 모양을 바로 출력한다. STUB_VIS=public|private, STUB_ON=1이면 이미 다 켜진 레포
set -euo pipefail
SETUP="$(cd "$(dirname "$0")/.." && pwd)/scripts/github-setup.sh"
BIN="$(mktemp -d)"; LOG="$BIN/calls"; export LOG
FAIL=0
cat > "$BIN/gh" <<'STUB'
#!/usr/bin/env bash
echo "$*" >> "$LOG"
on=${STUB_ON:-0}
case "$*" in
  "auth status") exit 0 ;;
  api\ -X*) exit 0 ;; # 바꾸는 호출은 기록만
  *vulnerability-alerts*) [ "$on" = 1 ] ;;
  *automated-security-fixes*|*private-vulnerability-reporting*) [ "$on" = 1 ] && echo true || echo false ;;
  *default-setup*) [ "$on" = 1 ] && echo configured || echo not-configured ;;
  *rules/branches*) [ "$on" = 1 ] && echo 2 || echo 0 ;;
  *community/profile*) [ "$on" = 1 ] || echo "code_of_conduct, contributing" ;;
  "api repos/{owner}/{repo} --jq"*)
    s=disabled; [ "$on" = 1 ] && s=enabled
    printf '%s\x1f%s\x1f%s\x1f%s\x1f%s\x1f%s\x1f%s\n' o/r "$STUB_VIS" User main "$s" "$s" "" ;;
  *) echo "스텁이 모르는 호출: $*" >&2; exit 9 ;;
esac
STUB
chmod +x "$BIN/gh"
export PATH="$BIN:$PATH"
run()    { : > "$LOG"; OUT=$(bash "$SETUP" "$@" 2>&1) || CODE=$?; }
writes() { grep -c -- '-X' "$LOG" || true; }
called() { grep -qF -- "$1" "$LOG" || { echo "  호출 없음: $1"; FAIL=1; }; }
notcalled() { ! grep -qF -- "$1" "$LOG" || { echo "  호출되면 안 됨: $1"; FAIL=1; }; }
says()   { grep -qF -- "$1" <<<"$OUT" || { echo "  출력에 없음: $1"; FAIL=1; }; }

echo "미리보기: 아무것도 바꾸지 않는다"
export STUB_VIS=public STUB_ON=0; CODE=0; run
[ "$(writes)" = 0 ] || { echo "  미리보기가 바꿈"; FAIL=1; }
says "enabled 예정"; says "Description | 비어 있음 | 건너뜀(--description 필요)"; says "커뮤니티 파일 없음(code_of_conduct, contributing)"

echo "공개 레포 --apply"
CODE=0; run --apply --description "설명"
[ "$CODE" = 0 ] || { echo "  종료 코드 $CODE"; FAIL=1; }
for c in "-X PATCH repos/{owner}/{repo} -f description=설명" "-X PUT repos/{owner}/{repo}/vulnerability-alerts" \
  "-X PUT repos/{owner}/{repo}/automated-security-fixes" "-X PUT repos/{owner}/{repo}/private-vulnerability-reporting" \
  "secret_scanning][status]=enabled" "secret_scanning_push_protection][status]=enabled" \
  "-X PATCH repos/{owner}/{repo}/code-scanning/default-setup -f state=configured" "-X POST repos/{owner}/{repo}/rulesets"; do called "$c"; done
says "Code Quality | - | 켜지 않음"

echo "비공개 레포 --apply: 유료, 미지원 항목은 건너뛴다"
export STUB_VIS=private; CODE=0; run --apply
called "-X PUT repos/{owner}/{repo}/vulnerability-alerts"
for c in private-vulnerability-reporting "security_and_analysis[" default-setup rules community/profile; do notcalled "$c"; done
says "Secret scanning | - | 건너뜀(유료)"; says "main Ruleset | - | 건너뜀(유료)"; says "건너뜀(공개 레포만 지원)"

echo "이미 다 켜진 공개 레포 --apply: 다시 돌려도 바꾸는 호출 없음"
export STUB_VIS=public STUB_ON=1; CODE=0; run --apply
[ "$(writes)" = 0 ] || { echo "  바꾸는 호출 $(writes)개"; FAIL=1; }
says "main Ruleset | 규칙 2개 | 그대로(건드리지 않음)"

echo "모르는 옵션은 실패"
CODE=0; run --nope; [ "$CODE" = 2 ] || { echo "  --nope 종료 코드 $CODE"; FAIL=1; }

if [ "$FAIL" = 0 ]; then echo "통과"; else echo "실패"; exit 1; fi
