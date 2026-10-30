# START — 새 프로젝트에 적용하는 순서

## 0. 먼저 정할 세 가지 (5분)

| 질문 | 예 | 어디에 적나 |
|---|---|---|
| 기간과 마감 | 해커톤 2박 3일, 공모전 6주, 졸업작품 6개월 | `AGENTS.md` 맨 위 |
| 무엇을 증명해야 하나 | 데모가 끝까지 돈다 / 수치가 개선된다 / 사용자가 이해한다 | `AGENTS.md` 프로젝트 한 줄 정의 |
| 혼자인가 팀인가 | 팀이면 블록(담당 영역)과 블록 사이 계약 | `AGENTS.md` 저장소 구조, `schema/` |

## 1. 레포에 넣기

```bash
bash ~/JHarvis/scripts/bootstrap.sh            # 기본
bash ~/JHarvis/scripts/bootstrap.sh --hackathon # 짧은 프로젝트
```

bootstrap이 하는 일(이미 있는 파일은 덮어쓰지 않고 `.playbook-new`로 옆에 둔다):

- `AGENTS.md`(규칙 원본), `CLAUDE.md`(AGENTS.md를 가리키는 몇 줄), `DESIGN.md`(화면이 있을 때)
- `.claude/settings.json`, `.claude/hooks/guard.py`(비밀키 파일 수정 차단, 커밋 전 빠른 검사)
- `.claude/skills/`(검토하고 SHA를 고정한 디자인 스킬, 화면이 있을 때만)
- `.github/pull_request_template.md`, 이슈 양식
- `docs/ops/free-tier-budget.md`, `docs/security/audit-template.md`(해커톤 모드에서는 생략)

## 2. 채팅 Claude 프로젝트 만들기

1. Claude 앱에서 프로젝트를 새로 만들고, 공모 요강, 기획서, 평가표를 파일로 올린다.
2. [`templates/kickoff-chat.md`](templates/kickoff-chat.md)의 빈칸을 채워 첫 메시지로 보낸다.
3. 채팅이 길어지면 [`templates/handoff-chat.md`](templates/handoff-chat.md) 형식으로 인수인계 문서를 만들고, 프로젝트 문서에 저장한 뒤 새 채팅에서 "이 문서를 읽고 이어가 주세요"로 시작한다.

## 3. Claude Code 시작

1. [`templates/kickoff-claude-code.md`](templates/kickoff-claude-code.md)를 첫 프롬프트로 보낸다(레포 구조 파악, AGENTS.md 빈칸 채우기, CI 뼈대).
2. 이후 작업은 채팅 Claude가 써 준 프롬프트를 그대로 붙여 넣는다. 형식은 [`templates/prompt-claude-code.md`](templates/prompt-claude-code.md).
3. 끝나면 `/export`로 로그를 저장해 채팅에 올린다. 채팅 Claude가 검토표, 놓친 것, 다음 프롬프트를 준다.

## 4. 매일 반복하는 고리

```
채팅 Claude: 계획과 프롬프트  →  Claude Code: 구현, PR, CI  →  /export  →  채팅 Claude: 검토표, 놓친 것, 다음 프롬프트
                                          ↓
                         사고나 실수가 나면 AGENTS.md에 규칙 한 줄 + 재발 방지 번호
```

## 해커톤 모드 (2박 3일 ~ 2주)

시간이 짧으면 규칙을 줄이고, **줄이면 안 되는 것만** 남긴다.

| 남긴다 | 줄인다 |
|---|---|
| Goal / Context / Constraints / Done-when 프롬프트, `/export` 검토 | 디자인 스킬 여러 개 → `frontend-design` 하나 |
| 블록 사이 JSON 계약(팀이면 첫 2시간 안에 고정) | 무료 예산표 → 한 줄 메모(쓰는 API와 한도) |
| 비밀키 훅, main 직접 push 금지, CI 빌드 하나 | 셀프 머지 허용(필수 체크 통과만) |
| 데모 경로 하나를 처음부터 끝까지 먼저 | 기능 가짓수 |
| 발표 수치는 출처와 함께, 추정은 추정이라고 | 문서 분량(README, 데모 시나리오, 평가표 대응표만) |
| 마감 반나절 전 동결, 태그 | 리팩터링 |

해커톤에서 특히 잘 통한 순서:

1. **평가표부터 읽는다.** 평가 항목마다 "무엇을 보여 주면 점수가 나오나"를 한 줄씩 적고, 기능을 거기에 맞춘다.
2. **데모 시나리오를 먼저 쓴다.** 심사위원이 3분 동안 보는 화면 순서를 정하고, 그 경로만 끝까지 만든다.
3. **가짜 데이터 금지, 예시는 예시라고 표시.** 없는 수치를 만들어 내면 질의응답에서 무너진다.
4. **발표 클레임 스트레스 테스트.** 발표 전 채팅 Claude에게 "심사위원이 공격할 질문 10개와 답"을 시킨다.
5. **제출물 체크리스트를 따로 둔다.** 파일 이름 규칙, 형식, 용량, 마감 시각, 제출 화면 캡처.

## 공모전, 해커톤 프로젝트에서 첫 메시지 예

```
~/JHarvis을 쓰는 프로젝트입니다. START.md의 해커톤 모드로 진행합니다.
공모 요강과 평가표는 프로젝트 파일에 있습니다. 먼저 평가표를 항목별 '보여 줄 것'으로 바꾸고,
데모 시나리오 초안과 Claude Code 첫 프롬프트를 주세요.
```
