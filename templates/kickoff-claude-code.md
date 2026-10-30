# Claude Code 첫 프롬프트

bootstrap.sh를 돌린 뒤 새 레포에서 붙여 넣습니다.

```
Goal
이 저장소를 JHarvis 방식으로 시작할 수 있게 기본 틀을 갖춘다.

Context
- ~/JHarvis를 클론해 두었고 scripts/bootstrap.sh로 AGENTS.md, CLAUDE.md, .claude/, .github/ 템플릿을 넣었다.
- 프로젝트: <한 줄>, 마감 <날짜>, 팀 <구성>, 스택 <예정 스택 또는 미정>.
- 규칙 원본은 AGENTS.md 하나다. ~/JHarvis/principles/와 tacit-knowledge.md를 읽고 판단 기준으로 삼는다.

Constraints
- 하위 에이전트를 쓰지 않고, 끝나면 최종 보고를 한 번만 한다.
- 무료 도구와 무료 한도만. 결제, 유료 플랜, 상시 연결 MCP를 추가하지 않는다.
- 이미 있는 파일은 덮어쓰지 않고, 바꿀 내용은 diff로 보여 준다.

할 일
1. AGENTS.md의 <빈칸>을 채운다: 프로젝트 정의, 저장소 구조, 명령어(lint, test, build), PR 규칙, 금지 사항.
2. 스택이 정해졌으면 최소 실행 뼈대와 CI 하나(lint + test + build)를 만든다. main 보호 규칙(필수 체크) 설정 방법을 사람이 할 일로 정리한다.
3. 팀 프로젝트면 schema/에 블록 사이 계약 초안과 예시 JSON을 둔다.
4. .claude/hooks/guard.py의 커밋 전 검사 명령을 이 저장소에 맞춘다.
5. 화면이 있으면 DESIGN.md의 <빈칸>(색, 서체)을 채우고, 없으면 지운다.

Done-when
- CI가 초록이고, guard.py가 .env 수정을 막는 것을 한 번 시험했다.
- AGENTS.md에 빈칸이 남지 않았다(모르는 것은 "미정"으로).
- 사람이 해야 할 설정(저장소 공개 범위, Rulesets, 비밀값 등록)을 따라 할 수 있는 목록으로 보고한다.
- 최종 보고: 검토표 → 놓친 것 → 다음 프롬프트.
```
