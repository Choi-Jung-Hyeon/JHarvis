# JHarvis

[![ci](https://github.com/Choi-Jung-Hyeon/JHarvis/actions/workflows/ci.yml/badge.svg)](https://github.com/Choi-Jung-Hyeon/JHarvis/actions/workflows/ci.yml)

새 프로젝트를 시작할 때 작업 세팅을 깔아 주는 개인 키트입니다.
규칙 문서, Claude Code 설정과 훅, CI, GitHub 양식과 보안 설정을 명령 두 개로 넣습니다. 두 프로젝트에서 실제로 쓰며 남긴 것만 담았습니다.

## 해 주는 일

`scripts/bootstrap.sh`는 현재 폴더에 파일을 넣습니다. 이미 있는 파일은 덮어쓰지 않고 `.playbook-new`로 옆에 둡니다.

- `AGENTS.md`(규칙), `CLAUDE.md`, `DESIGN.md`(화면이 있을 때)
- `.claude/` 설정과 훅(비밀키 파일 읽기와 수정 차단, 강제 push 차단, 커밋 전 빠른 검사), 검토한 디자인 스킬
- `.github/` CI, Dependabot, PR과 이슈 양식, 행동 강령, 기여 안내, 보안 정책, 루트 `LICENSE`(MIT)

`scripts/github-setup.sh`는 GitHub 레포 설정을 켭니다. 공개 레포에서는 모두 무료입니다.

- Dependabot alerts와 security updates, 비공개 취약점 신고, secret scanning, push protection, CodeQL 기본 설정
- 기본 브랜치 Ruleset(삭제, 강제 push 차단). 이미 있으면 건드리지 않고, 비공개 레포에서 돈이 드는 항목과 Code Quality는 켜지 않습니다.

## 빠른 시작

```bash
git clone https://github.com/Choi-Jung-Hyeon/JHarvis ~/jharvis
cd <새 프로젝트> && bash ~/jharvis/scripts/bootstrap.sh
git add -A && git commit -m "chore: 작업 세팅" && git push   # GitHub 레포가 연결돼 있어야 합니다
bash ~/jharvis/scripts/github-setup.sh --apply
```

| 옵션 | 쓸 때 |
|---|---|
| `bootstrap.sh --hackathon` | 해커톤처럼 짧은 프로젝트. CI 하나, 디자인 스킬 하나만 넣습니다 |
| `bootstrap.sh --no-ui` | 화면이 없는 프로젝트. DESIGN.md, 스킬, web-ci, 문구 검사를 뺍니다 |
| `github-setup.sh`(`--apply` 없이) | 바꿀 항목을 표로만 봅니다. 레포 설명이 비어 있으면 `--description "설명"` |

첫 CI가 돈 뒤 Ruleset에 필수 체크를 추가합니다. 자세한 순서와 해커톤 모드는 [START.md](START.md)에 있습니다.

## 일하는 흐름

```text
채팅 Claude: 계획과 프롬프트  →  Claude Code: 구현, PR, CI  →  /export  →  채팅 Claude: 검토표, 놓친 것, 다음 프롬프트
```

첫 메시지 양식: 채팅 Claude는 [kickoff-chat.md](templates/kickoff-chat.md), Claude Code는 [kickoff-claude-code.md](templates/kickoff-claude-code.md).

## 구성

| 위치 | 내용 |
|---|---|
| [templates/](templates/) | 프로젝트에 복사할 양식: AGENTS.md, 프롬프트, 회의록, 보안 점검, 평가, 연구, GitHub 파일 |
| [claude/](claude/) | Claude Code 설정, 훅, [검토한 스킬(SHA 고정)](claude/skills/README.md), [개인 설정 예](claude/user/README.md) |
| [scripts/](scripts/) | `bootstrap.sh`, `github-setup.sh`, `check.sh` |
| [principles/](principles/), [tacit-knowledge.md](tacit-knowledge.md) | 규칙과 그 이유 |
| [tools/tool-radar.md](tools/tool-radar.md) | 도구 판정표(채택, 기각과 이유) |
| [cases/](cases/) | 규칙이 나온 사례 |

## 내 방식으로 고쳐 쓰기

- `AGENTS.md`: bootstrap 뒤 `<빈칸>`을 프로젝트에 맞게 채웁니다. 규칙은 이 파일 한 곳에 둡니다.
- `.claude/hooks/guard.py`의 `CHECKS`: 커밋 전에 돌릴 검사(바뀐 파일 조건, 명령, 폴더)를 쓰는 스택에 맞게 바꿉니다.
- `claude/user/`: 제 개인 전역 설정입니다. **그대로 복사하지 말고** 참고만 하세요.
- Codex처럼 다른 에이전트만 쓴다면 `AGENTS.md`만 있으면 됩니다. `CLAUDE.md`와 `.claude/`는 지워도 됩니다.

## 원칙

1. 채팅 Claude는 설계와 검증, Claude Code는 실행. 프롬프트는 Goal / Context / Constraints / Done-when, 결과는 `/export`로 돌려받아 검토한다.
2. 규칙은 한 곳(AGENTS.md)에만. 틀리면 채팅으로 고치지 않고 문서를 고친다. 되돌리기 힘든 규칙은 훅, CI, 권한으로 강제한다.
3. 무료만, 구조로 강제. 결제 수단을 등록하지 않고, 한도 예산표와 주간 감시를 둔다. 1원이라도 들거나 유지보수, 토큰 부담이 생기면 쓰지 않는다.
4. 추정과 확인을 구분하고, 숫자는 이름 그대로. 결과가 없으면 없다고 쓴다.

## 기여, 라이선스

기여 방법은 [CONTRIBUTING](.github/CONTRIBUTING.md), 보안 문제는 [SECURITY](.github/SECURITY.md)를 봐 주세요.
라이선스: 이 레포의 글과 스크립트는 MIT. `claude/skills/` 안의 스킬은 각 폴더의 원본 라이선스를 따른다.

## English

A personal starter kit for new projects, built around Claude Code.
`bootstrap.sh` copies rules (AGENTS.md), Claude Code settings and hooks, CI, and GitHub community files into a repo.
`github-setup.sh` turns on the free GitHub security features and a default-branch ruleset. Docs are in Korean.
