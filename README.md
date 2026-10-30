# JHarvis

AI 두 개(채팅 Claude와 Claude Code)로 프로젝트를 빠르게, 무료로, 근거 있게 끝내는 개인 작업 방식 모음입니다.
2026년 졸업작품 Take a Look(4인 팀, 5~10월, 병합 PR 369개)에서 실제로 써 보고 남긴 규칙, 템플릿, 도구 판정만 담았습니다.

새 프로젝트를 시작할 때마다 인수인계를 처음부터 다시 쓰지 않으려고 만들었습니다. **이 레포 하나를 넣으면 AI가 같은 방식으로 일합니다.**

## 5분 시작

```bash
git clone https://github.com/Choi-Jung-Hyeon/JHarvis ~/JHarvis
cd <새 프로젝트>
bash ~/JHarvis/scripts/bootstrap.sh            # 일반 프로젝트
bash ~/JHarvis/scripts/bootstrap.sh --hackathon # 해커톤, 공모전처럼 짧은 프로젝트
```

그다음 두 가지만 하면 됩니다.

1. 채팅 Claude 프로젝트를 새로 만들고 [`templates/kickoff-chat.md`](templates/kickoff-chat.md)를 첫 메시지로 붙여 넣습니다.
2. Claude Code에서 [`templates/kickoff-claude-code.md`](templates/kickoff-claude-code.md)를 첫 프롬프트로 붙여 넣습니다.

자세한 순서는 [START.md](START.md)에 있습니다.

## 무엇이 들어 있나

| 위치 | 내용 | 언제 보나 |
|---|---|---|
| [START.md](START.md) | 새 프로젝트에 적용하는 순서, 해커톤 모드 | 프로젝트 첫날 |
| [tacit-knowledge.md](tacit-knowledge.md) | **잘 된 방식의 이유를 글로 옮긴 것(암묵지 → 형식지)** | 판단이 막힐 때 |
| [principles/](principles/) | AI 협업, 제품, 무료 운영, 보안, 연구 정직성, 화면, 팀과 문서 | 규칙을 정할 때 |
| [tools/tool-radar.md](tools/tool-radar.md) | 도구, 스킬, 플러그인 판정표(채택, 아이디어만, 기각과 이유) | 새 도구를 볼 때 |
| [tools/scrap-review.md](tools/scrap-review.md) | 스크랩을 선검토하고 후적용하는 절차 | 스크랩이 쌓였을 때 |
| [templates/](templates/) | AGENTS.md, DESIGN.md, 프롬프트, 인수인계, 회의록, 보안 점검, 무료 예산표 | 복사해서 쓸 때 |
| [claude/](claude/) | Claude Code 설정, 훅, 검토한 스킬(SHA 고정) | bootstrap이 복사 |
| [cases/take-a-look.md](cases/take-a-look.md) | 사례: 무엇을 했고 어떤 사고에서 어떤 규칙이 나왔나 | 근거가 필요할 때 |

## 다섯 줄 요약

1. **채팅 Claude는 설계와 검증, Claude Code는 실행.** 프롬프트는 Goal / Context / Constraints / Done-when, 결과는 `/export`로 돌려받아 검토한다.
2. **규칙은 한 곳(AGENTS.md)에만.** 틀리면 채팅으로 고치지 않고 문서를 고친다. 되돌리기 힘든 규칙은 훅, CI, 권한으로 강제한다.
3. **무료만, 구조로 강제.** 결제 수단을 등록하지 않고, 한도 예산표와 주간 감시를 둔다. 1원이라도 들거나 유지보수, 토큰 부담이 생기면 쓰지 않는다.
4. **추정과 확인을 구분하고, 숫자는 이름 그대로.** 결과가 없으면 없다고 쓴다.
5. **끝은 항상 교통정리 표와 넥스트 액션.** 사람이 해야 할 일은 따라 할 수 있는 가이드로.

## 갱신 규칙

- 새 프로젝트에서 배운 것은 이 레포에 PR로 올린다. 사례는 `cases/`, 규칙은 해당 `principles/` 파일, 도구 판정은 `tools/tool-radar.md`.
- 판정이 바뀌면 지우지 않고 날짜와 함께 덧붙인다(왜 바뀌었는지가 다음 판단의 근거다).
- 개인정보, 비밀키, 팀원 평가, 실제 계좌나 수치는 올리지 않는다(공개 레포).

라이선스: 이 레포의 글과 스크립트는 MIT. `claude/skills/` 안의 스킬은 각 폴더의 원본 라이선스를 따른다.
