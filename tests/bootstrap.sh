#!/usr/bin/env bash
# bootstrap.sh 스모크 테스트. 실행: bash tests/bootstrap.sh
# 순수 bash: 검사가 "파일이 있나/없나" 뿐이라 bats를 설치할 이유가 없다.
set -euo pipefail
BOOT="$(cd "$(dirname "$0")/.." && pwd)/scripts/bootstrap.sh"
FAIL=0
has()  { for f in "$@"; do [ -e "$f" ] || { echo "  없음: $f"; FAIL=1; }; done; }
hasnt(){ for f in "$@"; do [ ! -e "$f" ] || { echo "  있으면 안 됨: $f"; FAIL=1; }; done; }
fresh(){ cd "$(mktemp -d)" || exit 1; }

COMMON=(AGENTS.md CLAUDE.md .claude/settings.json .claude/hooks/guard.py .gitignore
  .github/pull_request_template.md .github/ISSUE_TEMPLATE/task.md .github/ISSUE_TEMPLATE/bug.md
  .github/CODE_OF_CONDUCT.md .github/CONTRIBUTING.md .github/SECURITY.md LICENSE)

echo "기본"
fresh; GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=user.name GIT_CONFIG_VALUE_0='A & B|C' bash "$BOOT" >/dev/null
grep -qxF "Copyright (c) $(date +%Y) A & B|C" LICENSE || { echo "  LICENSE 연도, 이름이 안 채워짐"; FAIL=1; }
has "${COMMON[@]}" DESIGN.md .github/ACCESSIBILITY.md .claude/skills/README.md .claude/skills/frontend-design/SKILL.md .claude/skills/baseline-ui/SKILL.md \
  .github/workflows/web-ci.yml .github/workflows/python-ci.yml .github/workflows/free-tier-watch.yml \
  .github/scripts/free_tier_watch.py .github/dependabot.yml docs/ops/free-tier-budget.md \
  docs/security/audit-template.md docs/research/metric-choice.md lib/copy-rules.mjs

echo "--hackathon"
fresh; bash "$BOOT" --hackathon >/dev/null
has "${COMMON[@]}" DESIGN.md .claude/skills/frontend-design/SKILL.md .github/workflows/web-ci.yml
hasnt .claude/skills/baseline-ui .github/workflows/python-ci.yml .github/dependabot.yml docs lib

echo "--no-ui"
fresh; bash "$BOOT" --no-ui >/dev/null
has "${COMMON[@]}" .github/workflows/python-ci.yml .github/dependabot.yml
hasnt DESIGN.md .github/ACCESSIBILITY.md .claude/skills .github/workflows/web-ci.yml lib

echo "두 번 실행: 덮어쓰지 않고 .playbook-new"
fresh; bash "$BOOT" >/dev/null
echo "내 규칙" > AGENTS.md
lines=$(wc -l < .gitignore)
bash "$BOOT" >/dev/null
[ "$(cat AGENTS.md)" = "내 규칙" ] || { echo "  AGENTS.md를 덮어씀"; FAIL=1; }
has AGENTS.md.playbook-new .github/pull_request_template.md.playbook-new .github/workflows/python-ci.yml.playbook-new \
  LICENSE.playbook-new .github/SECURITY.md.playbook-new
hasnt .claude/skills/frontend-design.playbook-new # 스킬 폴더는 건너뛴다
[ "$(wc -l < .gitignore)" = "$lines" ] || { echo "  .gitignore에 줄이 중복으로 붙음"; FAIL=1; }

echo "모르는 옵션은 실패"
fresh; if bash "$BOOT" --nope >/dev/null; then echo "  --nope 가 성공함"; FAIL=1; fi

if [ "$FAIL" = 0 ]; then echo "통과"; else echo "실패"; exit 1; fi
