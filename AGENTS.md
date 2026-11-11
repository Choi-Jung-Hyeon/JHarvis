# AGENTS.md

> JHarvis 레포 자신의 작업 규칙. 목적과 구성은 [README](README.md)를 본다.
> 이 파일은 모든 코딩 에이전트의 상시 지침이다. CLAUDE.md는 이 파일을 가리키기만 한다.

## 구분

- `templates/`는 **다른 레포에 복사해 줄 양식**이다. `templates/AGENTS.md`, `templates/CLAUDE.md`는 이 레포의 규칙이 아니다.
- `claude/skills/<스킬>/` 원본은 SHA 고정한 외부 파일이라 고치지 않는다. 메모는 [claude/skills/README.md](claude/skills/README.md)에.
- 무엇을 어디에 넣는지는 README의 "갱신 규칙"을 따른다.

## 작업 흐름

1. 새 브랜치(`feat/`, `fix/`, `docs/`, `chore/`)를 만든다. main 직접 push 금지.
2. 커밋 전 `bash scripts/check.sh`(전부) 또는 `bash scripts/check.sh md unit`(일부).
3. PR → CI 6개(shellcheck, markdownlint, actionlint, ruff, links, test) 초록 → squash 머지:
   `gh pr checks <번호> --watch --fail-fast && gh pr merge <번호> --squash --delete-branch`

## 기록

- 판정 기록(`tools/tool-radar.md` 등)은 지우지 않고 날짜와 함께 덧붙인다(README 갱신 규칙).
- 기존 규칙, 사례 문장은 임의로 바꾸지 않는다. 바꿔야 하면 PR 본문에 목록으로 올린다.

## 공개 레포 금지 항목

커밋, PR 본문, 이슈 어디에도 넣지 않는다.

- 비밀키, 토큰, 개인 이메일, 학번, 전화번호
- 팀원 실명, 계정, 평가
- 회사명, 프로그램명, 다른 팀 레포 이름, 노션 ID
- 내부 자료 원문, 실제 계좌, 실제 수치, 사적인 일정
- 특정 금지 단어는 목록을 레포에 두지 않는다. 머지 전 사람이 따로 확인한다.
