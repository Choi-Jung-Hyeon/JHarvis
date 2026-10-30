# 도구 판정표 (Tool Radar)

2026-09~10 졸업작품에서 판정한 것을 분야별로 모았습니다. 판정 기준은 [scrap-review.md](scrap-review.md).
날짜는 마지막 판정일. 바뀌면 지우지 말고 새 줄에 날짜와 함께 덧붙입니다.

## 쓰는 것

| 도구 | 판정 | 어떻게 쓰나 | 날짜 |
|---|---|---|---|
| Claude Code 내장 `/code-review`, `/security-review`, `/simplify` | 채택 | PR 점검. 운영 경로를 바꾸는 PR은 머지 전 `/security-review`(추가 비용 없음) | 10-11 |
| Claude Code 훅(PreToolUse) | 채택 | 되돌리기 힘든 규칙만: 비밀키 파일 수정 차단, 커밋 전 빠른 검사. 종료 코드 2만 막는다 | 10-20 |
| Claude Design (`/design`, 단독 앱) | 사용 | 새 화면 구현 전 시안 여러 개. 시안도 DESIGN.md를 따른다 | 09-23 |
| Claude 슬라이드, 독스, 디자인 | 발표 준비 후보 | 발표 자료를 채팅에서 만들고 PPTX나 PDF로 | 10-27 |
| [ponytail](https://github.com/DietrichGebert/ponytail) (MIT) | 사용 중(전역) | 코드 줄이기, "라이브러리 대신 네이티브 한 줄". 5.x로 갱신 | 10-26 |
| Playwright(`@playwright/test` + 플러그인) | 사용 중 | e2e와 전후 스크린샷은 스크립트로. MCP 도구는 한두 번 눌러 볼 때만(스냅샷 토큰이 큼) | 10-18 |
| [frontend-design](https://github.com/anthropics/skills) (Apache-2.0) | 채택(SHA 고정) | 새 화면: 브리프 → 토큰 계획 → 기본값 점검 → 구현 → 스크린샷 자기 비판 | 09-26 |
| [taste-skill](https://github.com/Leonxlnx/taste-skill) `redesign-skill`, `minimalist-skill` (MIT) | 채택(2종만, SHA 고정) | 기존 화면 진단, 절제된 표면 원칙. 본체와 다른 스타일은 제외 | 10-11 |
| [ui-skills](https://github.com/ibelick/ui-skills) `baseline-ui`, `fixing-motion-performance` (MIT) | 채택(SHA 고정) | 간격, 위계, 빈 상태, 모션 점검 | 09-26 |
| [web-interface-guidelines](https://github.com/vercel-labs/web-interface-guidelines) (MIT) | 규칙만 적용 | 원문으로 한 번 점검(`theme-color`, `touch-action` 등). 스킬은 실행마다 원격 규칙을 받아 SHA 고정과 안 맞음 | 10-09 |
| Dependabot, CodeQL 기본, GitHub Rulesets | 사용 | 공개 레포 무료 기능. 필수 체크로 머지 막기 | 10-09 |
| 검색 노출 기본(robots, sitemap, 페이지별 메타, 서치 콘솔) | 채택 | 프레임워크 기본 기능으로. 검색 도구 소유 확인은 사람이 | 10-13 |
| 웹 출시 전 점검(개인정보 처리방침, 맞춤 404, OG 이미지) | 채택 | 가입을 받으면 개인정보 처리방침 필수 | 10-26 |
| BentoPDF | 개인 도구 | 보고서 PDF 합치기, 줄이기(브라우저 안에서 처리) | 10-26 |

## 필요할 때만 (설치 없이 일회성)

| 도구 | 쓰는 법 | 날짜 |
|---|---|---|
| [MarkItDown](https://github.com/microsoft/markitdown) (MIT) | `pipx run markitdown 파일.docx` | 10-18 |
| [gitingest](https://github.com/coderamp-labs/gitingest) (MIT) | 남의 레포를 웹 채팅에 통째로 보여 줄 때만 | 10-26 |
| 보안 감사 스킬(Cloudflare security-audit-skill, 공식 `claude-security`) | 큰 출시 전 한 번(여러 에이전트라 토큰이 큼) | 10-26 |
| HyperFrames (Apache-2.0) | 발표 영상이 필요할 때 | 10-06 |

## 아이디어만 (설치하지 않음)

| 도구 | 가져온 생각 | 날짜 |
|---|---|---|
| [superpowers](https://github.com/obra/superpowers) (MIT) | 질문 → 설계 승인 → 짧은 계획 → 테스트 먼저. 단계마다 문서를 만들어 토큰이 많아 개인 선택 | 10-26 |
| [andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) (라이선스 없음) | "단계 → 확인 방법" 계획 형식. 원문은 복사하지 않음 | 10-21 |
| [mattpocock/skills](https://github.com/mattpocock/skills) (MIT) | prototype의 `?variant=`로 시안 비교. grill-me, handoff는 기존 방식과 겹침 | 10-13 |
| awesome-claude-design, Apple 스타일 DESIGN.md | 절제 원칙 대조, 터치 영역 규칙만 추가 | 09-23 |
| [design-motion-principles](https://github.com/kylezantos/design-motion-principles) (MIT) | 자주 반복되는 동작은 모션 없이, reduced-motion 필수(이미 충족) | 10-15 |
| [emil-design-eng](https://github.com/emilkowalski/skills) (MIT) | 눌림 피드백은 pointer-down에 바로 | 10-09 |
| 화면 만드는 8역할 프롬프트 | 마지막 "화면 검수"(실제 캡처 비교, 영향 큰 차이부터)만 작업 끝 절차로 | 10-09 |
| 기업 자체 업무 벤치마크(스크랩) | 범용 점수보다 우리 업무 기준으로 모델 선택 | 10-15 |
| "CLAUDE.md는 부탁, 훅은 강제" | 채택해 훅으로 적용 | 10-20 |
| "에이전트 말고 스킬(업무별 설명서)" | 이미 하는 방식: AI 하나 + 규칙 문서 + 완료 기준, 틀리면 설명서를 고친다 | 10-20 |
| "크래시 아웃", "공격적 질문 8기법" | 프롬프트보다 실제 검증(테스트, 실측, 감사) | 10-26 |
| [diagram-design](https://github.com/cathrynlavery/diagram-design) (MIT) | 보고서 그림은 직접, 본문 서체로. mermaid로 충분 | 10-26 |
| Google Stitch | 무료 크레딧이지만 방향이 정해지면 불필요 | 10-27 |
| 형식 검증(Claude + Theorem) | "지킬 약속을 먼저 적고 경계 입력으로 검사" | 10-27 |
| [Laya](https://github.com/NandhaKishorM/laya) (Apache-2.0) | CPU로 도는 분류 모델 후보(다음 프로젝트) | 10-27 |

## 기각

| 도구 | 이유(기준 번호) | 날짜 |
|---|---|---|
| ui-ux-pro-max-skill | 스타일 고르는 도구, 방향은 이미 정함(6) | 10-20 |
| caveman 계열 | 실제 절감 효과 작음, 간결 출력 스타일로 충분(6) | 10-15 |
| [hallmark](https://github.com/nutlope/hallmark) | 게이트가 길어 토큰 부담(3, 6) | 10-09 |
| Ruflo(옛 Claude Flow), ECC, Cindy, Orca, "육칠" 병렬 에이전트 | 에이전트 군집, 하네스 교체로 토큰 몇 배(2, 3) | 10-26 |
| Graphify, Graft(Trail-code), Codebase Memory MCP, Agency Agents | 색인, 메모리 관리 부담, 첫 실행에 지난 대화를 읽어 사용량(2, 3) | 10-27 |
| context7 등 상시 연결 MCP | 매 대화 토큰 증가(3) | 10-26 |
| 공식 `security-guidance` 플러그인 | 매 턴 diff 재검토로 토큰이 계속 듦(3) | 10-26 |
| Claude Mem, gstack | 내장 메모리와 겹침, 라이선스 표기 혼선, 스킬 23개(3, 4, 6) | 10-27 |
| addyosmani/agent-skills | 스킬 24개와 훅이 기존 규칙과 두 벌이 됨(6) | 10-21 |
| Firecrawl | 호스팅판 과금, 무료는 셀프 호스팅(1, 2) | 10-11 |
| Ollama, OpenJarvis, ComfyUI | 모델 서버, 모델 파일 관리(2) | 10-27 |
| OpenClaw | 컴퓨터 전체 권한 데몬, 원격 코드 실행 취약점과 악성 스킬 사고(7) | 10-18 |
| PentAGI, Strix | 도커, LLM 키, 운영 주소에 공격 도구(1, 2, 7) | 10-26 |
| screenshot-to-code, Image to Code | 종량 API 키 또는 이미지 생성 필요(1) | 10-11 |
| Open Code Review, Fabric, Gemini API CLI | 별도 모델 키 필요, 내장 기능과 겹침(1, 6) | 10-27 |
| Arco Design 등 새 UI 라이브러리 | 디자인 토큰과 충돌, 번들 증가(6) | 10-15 |
| awesome-design-md, 남의 사이트 DESIGN.md 추출 | 남의 브랜드를 베끼는 일(7) | 10-15 |
| REA | 상시 MCP, 바이너리 분석 도구 별도 필요(2, 3) | 10-15 |
| Agent-Reach, agent-browser | SNS 쿠키 필요, Playwright로 충분(6, 7) | 10-09 |
| public-apis | 목록일 뿐, 필요한 원천 없음(6) | 10-11 |
| ai-jailbreaks | 용도 없음, 라이선스 없음(4) | 10-26 |
| "DM으로 설치 가이드" 류 스크랩 | 실체 없음(5) | 10-20 |

## 데이터 공급원 (졸업작품 기준, 한국 주식)

| 후보 | 판정 | 이유 |
|---|---|---|
| pykrx (MIT) | 채택 | 시장 전체 투자자별 순매수를 한 번에 |
| FinanceDataReader (MIT) | 채택 | 상장 목록, 시가총액, 종가 |
| OpenDART 직접 호출 + OpenDartReader (MIT) | 채택 | 공시 목록 하루 일괄, 재무 |
| NewsAPI.ai | 채택(무료 2,000회) | 하루 상한 안에서 |
| BigKinds | 수동 내려받기만 | 자동 수집 약관 위반 |
| 네이버 검색 API | 제외 | AI 입력 금지, 보관 21일 |
| GDELT | 미채택 | 실측 관련성 기준 미달 |
| TradingView lightweight-charts | 보류 | 번들 증가와 로고 표시 의무 |
