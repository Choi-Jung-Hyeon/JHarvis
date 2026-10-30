# Claude Code 실행 프롬프트 (XML판)

[prompt-claude-code.md](prompt-claude-code.md)의 네 칸과 대응합니다: `task`+`context` = Goal/Context, `scope`+`constraints` = Constraints, `self_check` = Done-when. 차이는 맨 앞의 정찰 칸입니다.

```xml
<task>
<한 문장 목표>
배경: <왜 이걸 하나, 한두 줄>
</task>

<context>
- 관련 PR / 이슈: <번호>
- 이미 정해진 것: <결정 목록>
- 담당 경계: <내가 고쳐도 되는 파일 / 읽기만 할 파일>
</context>

<branch_reconnaissance>
아래를 확인하고 보고한 뒤 멈춰라. 사람 승인 없이 파일을 수정하지 마라.
1. git status — 깨끗하지 않으면 중단하고 보고
2. git fetch origin 후 origin/main(또는 develop) 기준 분기 가능 여부
3. <고칠 파일>의 현재 구현과 호출 지점
4. <선행 PR>이 머지됐는지
</branch_reconnaissance>

<scope>
- 허용: <커밋, 푸시, PR 생성 / 진단만>
- 아래 작업 외에는 건드리지 않는다. 요청하지 않은 정리는 보고에 제안만
- 다음 경우에만 멈추고 물어라: <원칙이 걸린 충돌>, <운영 데이터 쓰기>
</scope>

<constraints>
- main 직접 커밋 금지
- 포매터 실행 금지(설정 없음)
- 시드 없는 난수 금지
- <SSOT 함수>가 유일한 계산 위치. 다른 곳에서 재계산 금지
- 문서(.md) 파일 생성 금지. 결과는 CLI로만
- 커밋 메시지: <레포 규칙>
- 화면 문구 금지어: <T11 목록 참조>
</constraints>

<work>
## 1. <작업>
## 2. <작업>
</work>

<deliverable>
1. 브랜치 <이름>
2. PR 본문: 변경 파일과 동작을 표로
</deliverable>

<self_check>
각 항목 통과/실패를 따로 보고하라. 확인 못 한 항목은 "미확인"으로 쓰고 추론으로 통과 처리하지 마라.
[ ] git diff --stat — 의도한 파일 외 변경 없음
[ ] 빌드 / 린트 / 테스트
[ ] 도메인 불변식 1: <예: 비중 합계 100%>
[ ] 도메인 불변식 2: <예: 상태별 버튼 동작>
[ ] 화면 문구 금지어 grep 결과 첨부
[ ] 커밋 메시지 규칙 준수
</self_check>
```
