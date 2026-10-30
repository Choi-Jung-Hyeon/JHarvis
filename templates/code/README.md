# 문구 검사와 쉬운 말 사전

화면 문구를 사람의 주의력에 맡기지 않고 테스트로 막습니다. 표준 라이브러리만 쓰므로 프레임워크와 상관없이 Node 20.12 이상에서 돕니다.

| 파일 | 내용 |
|---|---|
| `copy-rules.mjs` | 금지 표현 목록(패턴과 이유). 사용자 피드백이 올 때마다 한 줄씩 는다 |
| `copy-glossary.mjs` | 쉬운 말 사전. 화면 문구는 여기서 가져다 쓴다 |
| `copy-rules.test.mjs` | 소스 문자열 전체 검사 + 목록이 대표 문장을 잡는지 + 사전 형식 검사 |

```bash
node --test lib/copy-rules.test.mjs
```

새 프로젝트에서 바꿀 곳:

1. `copy-rules.test.mjs` 맨 위 `SOURCE_DIRS`, `EXTENSIONS`, `EXCLUDED`.
2. `copy-rules.mjs`의 도메인 금지어. 규제가 있는 영역(투자 권유, 의료 진단)이면 가장 먼저 넣는다.
3. `copy-glossary.mjs`의 예시 용어.

규칙을 추가할 때는 이유에 "무엇으로 바꿀지"를 함께 적고, 테스트의 대표 문장에도 한 줄 넣습니다. 그래야 규칙이 일을 하는지 확인됩니다.
