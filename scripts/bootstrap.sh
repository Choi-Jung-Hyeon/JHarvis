#!/usr/bin/env bash
# JHarvis 템플릿을 현재 폴더(새 프로젝트 루트)에 넣는다.
# 이미 있는 파일은 덮어쓰지 않고 <파일>.playbook-new 로 옆에 둔다.
# 사용: bash ~/JHarvis/scripts/bootstrap.sh [--hackathon] [--no-ui]
set -euo pipefail
PB="$(cd "$(dirname "$0")/.." && pwd)"
HACK=0; UI=1
for a in "$@"; do
  case "$a" in
    --hackathon) HACK=1 ;;
    --no-ui) UI=0 ;;
    *) echo "모르는 옵션: $a"; exit 1 ;;
  esac
done

copy_skill() { # copy_skill <스킬 이름> : 이미 있으면 건너뜀
  if [ -e ".claude/skills/$1" ]; then echo "있음 → .claude/skills/$1(건너뜀)"; else mkdir -p .claude/skills; cp -r "$PB/claude/skills/$1" ".claude/skills/$1"; echo "추가 → .claude/skills/$1"; fi
}

put() { # put <원본> <대상>
  local src="$PB/$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ]; then cp "$src" "$dst.playbook-new"; echo "있음 → $dst.playbook-new"; else cp "$src" "$dst"; echo "추가 → $dst"; fi
}

put templates/AGENTS.md AGENTS.md
put templates/CLAUDE.md CLAUDE.md
put claude/settings.json .claude/settings.json
put claude/hooks/guard.py .claude/hooks/guard.py
put templates/github/pull_request_template.md .github/pull_request_template.md
put templates/github/ISSUE_TEMPLATE/task.md .github/ISSUE_TEMPLATE/task.md
put templates/github/ISSUE_TEMPLATE/bug.md .github/ISSUE_TEMPLATE/bug.md

if [ "$UI" = 1 ]; then
  put templates/DESIGN.md DESIGN.md
  if [ "$HACK" = 1 ]; then
    copy_skill frontend-design
  else
    for d in "$PB"/claude/skills/*/; do copy_skill "$(basename "$d")"; done
    put claude/skills/README.md .claude/skills/README.md
  fi
fi

if [ "$HACK" = 0 ]; then
  put templates/free-tier-budget.md docs/ops/free-tier-budget.md
  put templates/security-audit.md docs/security/audit-template.md
fi

grep -qxF ".env" .gitignore 2>/dev/null || { printf '.env\n.env.*\n!.env.example\n' >> .gitignore; echo "추가 → .gitignore(.env)"; }
echo
echo "다음: AGENTS.md의 <빈칸>을 채우고, templates/kickoff-claude-code.md를 Claude Code 첫 프롬프트로 보내세요."
