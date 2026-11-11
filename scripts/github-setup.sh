#!/usr/bin/env bash
# 현재 폴더 레포의 GitHub 설정(보안, Ruleset, 설명)을 무료 범위에서 켠다. 파일 복사는 bootstrap.sh 몫이다.
# 사용: bash ~/jharvis/scripts/github-setup.sh [--apply] [--description "레포 설명"]
#   기본은 미리보기(할 일 표만). --apply 일 때만 바꾼다. 상태를 먼저 읽고 다른 것만 바꾸므로 여러 번 돌려도 결과가 같다.
#   1원이라도 드는 것(비공개 레포의 secret scanning, code scanning, Ruleset, Code Quality, AI Scan)은 켜지 않는다.
#   근거: tools/tool-radar.md 2026-11-11
set -uo pipefail
APPLY=0; DESC=""
while [ $# -gt 0 ]; do
  case "$1" in
    --apply) APPLY=1 ;;
    --description) DESC="${2:-}"; [ -n "$DESC" ] || { echo "--description 뒤에 설명을 주세요"; exit 2; }; shift ;;
    *) echo "모르는 옵션: $1"; exit 2 ;;
  esac
  shift
done
command -v gh >/dev/null || { echo "gh가 없습니다: https://cli.github.com"; exit 2; }
gh auth status >/dev/null 2>&1 || { echo "먼저 gh auth login"; exit 2; }

R='repos/{owner}/{repo}' # gh가 현재 폴더의 git remote로 채운다
US=$'\x1f'
IFS="$US" read -r NAME VIS OWNER BRANCH SS PP CUR_DESC < <(gh api "$R" --jq "[.full_name, .visibility, .owner.type, .default_branch,
  (.security_and_analysis.secret_scanning.status // \"disabled\"),
  (.security_and_analysis.secret_scanning_push_protection.status // \"disabled\"), (.description // \"\")] | join(\"$US\")")
[ -n "${NAME:-}" ] || { echo "레포를 읽지 못했습니다. GitHub에 push한 레포 폴더에서 실행하세요."; exit 2; }
PUBLIC=0; [ "$VIS" = public ] && PUBLIC=1
FAIL=0; HUMAN=()

echo "$NAME ($VIS, $OWNER) — $([ "$APPLY" = 1 ] && echo 적용 || echo '미리보기: --apply 를 붙이면 바꿉니다')"
echo
echo "| 항목 | 지금 | 결과 |"
echo "|---|---|---|"
row() { echo "| $1 | $2 | $3 |"; }
# step <항목> <지금> <원하는 값> <바꾸는 명령...>
step() {
  local item=$1 now=$2 want=$3 err; shift 3
  if [ "$now" = "$want" ]; then row "$item" "$now" "그대로"; return; fi
  if [ "$APPLY" = 0 ]; then row "$item" "$now" "$want 예정"; return; fi
  if err=$("$@" 2>&1 >/dev/null); then row "$item" "$now" "$want"; else row "$item" "$now" "실패: ${err:0:120}"; FAIL=1; fi
}
on() { if gh api "$@" >/dev/null 2>&1; then echo enabled; else echo disabled; fi; } # 204면 켜짐, 404면 꺼짐
tf() { [ "$(gh api "$@" 2>/dev/null)" = true ] && echo enabled || echo disabled; }

if [ -n "$CUR_DESC" ]; then row "Description" "있음" "그대로"
elif [ -n "$DESC" ]; then step "Description" "비어 있음" "설정" gh api -X PATCH "$R" -f description="$DESC"
else row "Description" "비어 있음" "건너뜀(--description 필요)"; HUMAN+=("Description: --description \"설명\"을 붙여 다시 실행하거나 레포 첫 화면 오른쪽 About의 톱니바퀴에서 입력"); fi

step "Dependabot alerts" "$(on "$R/vulnerability-alerts")" enabled gh api -X PUT "$R/vulnerability-alerts"
step "Dependabot security updates" "$(tf "$R/automated-security-fixes" --jq .enabled)" enabled gh api -X PUT "$R/automated-security-fixes"

if [ "$PUBLIC" = 1 ]; then
  step "비공개 취약점 신고" "$(tf "$R/private-vulnerability-reporting" --jq .enabled)" enabled gh api -X PUT "$R/private-vulnerability-reporting"
  step "Secret scanning" "$SS" enabled gh api -X PATCH "$R" -f 'security_and_analysis[secret_scanning][status]=enabled'
  step "Push protection" "$PP" enabled gh api -X PATCH "$R" -f 'security_and_analysis[secret_scanning_push_protection][status]=enabled'
  # 새 레포에 아직 코드가 없으면 실패할 수 있다. 첫 push 뒤 다시 돌리면 된다
  step "Code scanning 기본 설정(CodeQL)" "$(gh api "$R/code-scanning/default-setup" --jq .state 2>/dev/null || echo 알수없음)" configured \
    gh api -X PATCH "$R/code-scanning/default-setup" -f state=configured
  read -r rules checks < <(gh api "$R/rules/branches/$BRANCH" \
    --jq '"\(length) \(map(select(.type == "required_status_checks")) | length)"' 2>/dev/null || echo "0 0")
  if [ "${rules:-0}" != 0 ]; then row "$BRANCH Ruleset" "규칙 ${rules}개" "그대로(건드리지 않음)"
  else
    body=$(mktemp); trap 'rm -f "$body"' EXIT
    printf '%s' '{"name":"기본 브랜치 보호","target":"branch","enforcement":"active",
      "conditions":{"ref_name":{"include":["~DEFAULT_BRANCH"],"exclude":[]}},
      "rules":[{"type":"deletion"},{"type":"non_fast_forward"}]}' > "$body"
    step "$BRANCH Ruleset" "없음" "삭제·강제 push 차단" gh api -X POST "$R/rulesets" --input "$body"
  fi
  [ "${checks:-0}" = 0 ] && HUMAN+=("필수 체크: 첫 CI가 돈 뒤 Settings → Rules → Rulesets → 기본 브랜치 규칙 → Require status checks to pass → 잡 이름 추가 → Save")
else
  row "비공개 취약점 신고" "-" "건너뜀(공개 레포만 지원)"
  for item in "Secret scanning" "Push protection" "Code scanning 기본 설정(CodeQL)" "$BRANCH Ruleset"; do row "$item" "-" "건너뜀(유료)"; done
fi
row "Code Quality" "-" "켜지 않음(유료: 커미터당 라이선스)"
row "AI Scan" "-" "켜지 않음(유료: Advanced Security 필요)"
row "Secret scanning 일반 패턴, 유효성 검사" "-" "건드리지 않음(무료 여부 확인 필요)"

if [ "$PUBLIC" = 1 ]; then
  # issue_template은 ISSUE_TEMPLATE/ 폴더가 있어도 null로 온다(#11 확인). 폴더는 contents API로 따로 본다
  missing=$(gh api "$R/community/profile" --jq '.files | to_entries | map(select(.value == null and .key != "issue_template") | .key) | join(", ")' 2>/dev/null)
  if ! gh api "$R/contents/.github/ISSUE_TEMPLATE" --silent 2>/dev/null; then missing="${missing:+$missing, }issue_template"; fi
  [ -n "$missing" ] && HUMAN+=("커뮤니티 파일 없음($missing): bootstrap.sh로 넣고 커밋, push")
  if [ "$OWNER" = Organization ]; then
    HUMAN+=("콘텐츠 신고 허용(API 없음): Settings → Moderation options → Reported content → Prior contributors and collaborators → Save")
  fi
fi

if [ ${#HUMAN[@]} -gt 0 ]; then
  echo; echo "사람이 할 일"
  for h in "${HUMAN[@]}"; do echo "- [ ] $h"; done
fi
exit "$FAIL"
