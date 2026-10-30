# 도구 판정표 (Tool Radar)

2026-09~10 졸업작품에서 판정한 것을 분야별로 모았습니다(프로젝트 메모리의 10/06 이전 판정 포함). 판정 기준은 [scrap-review.md](scrap-review.md).
날짜는 마지막 판정일. 바뀌면 지우지 말고 새 줄에 날짜와 함께 덧붙입니다.

묶음으로 다시 온 스크랩(인기 스킬 5개, 스킬 TOP 10, 공식 플러그인 TOP 5, 무료 플러그인 6가지, 고수 도구 4개)은 구성 도구를 아래에서 각각 판정했으므로 "기존 판정 유지"로 끝냅니다.

## 쓰는 것

| 도구 | 판정 | 어떻게 쓰나 | 날짜 |
|---|---|---|---|
| Claude Code 내장 `/code-review`, `/security-review`, `/simplify` | 채택 | PR 점검. 운영 경로를 바꾸는 PR은 머지 전 `/security-review`(추가 비용 없음) | 10-11 |
| Claude Code 훅(PreToolUse) | 채택 | 되돌리기 힘든 규칙만: 비밀키 파일 수정 차단, 커밋 전 빠른 검사. 종료 코드 2만 막는다 | 10-20 |
| Claude Design (`/design`, 단독 앱) | 사용 | 새 화면 구현 전 시안 여러 개. 시안도 DESIGN.md를 따른다 | 09-23 |
| Claude 슬라이드, 독스, 디자인 | 발표 준비 후보 | 발표 자료를 채팅에서 만들고 PPTX나 PDF로 | 10-27 |
| [ponytail](https://github.com/DietrichGebert/ponytail) (MIT) | 사용 중(전역) | 코드 줄이기, "라이브러리 대신 네이티브 한 줄". 작업 끝에 `/ponytail-audit`(레포 전체), `/ponytail-review`(diff). 5.x로 갱신 | 10-26 |
| Playwright(`@playwright/test` + 플러그인, Playwright MCP) | 사용 중 | e2e와 전후 스크린샷은 스크립트로. MCP 도구는 한두 번 눌러 볼 때만(스냅샷 토큰이 큼) | 10-18 |
| [frontend-design](https://github.com/anthropics/skills) (Apache-2.0) | 채택(SHA 고정) | 새 화면: 브리프 → 토큰 계획 → 기본값 점검 → 구현 → 스크린샷 자기 비판 | 09-26 |
| [taste-skill](https://github.com/Leonxlnx/taste-skill) `redesign-skill`, `minimalist-skill` (MIT) | 채택(2종만, SHA 고정) | 기존 화면 진단, 절제된 표면 원칙. 본체와 다른 스타일은 제외 | 10-11 |
| [ui-skills](https://github.com/ibelick/ui-skills) `baseline-ui`, `fixing-motion-performance` (MIT) | 채택(SHA 고정) | 간격, 위계, 빈 상태, 모션 점검 | 09-26 |
| [web-interface-guidelines](https://github.com/vercel-labs/web-interface-guidelines) (MIT), 스킬판 web-design-guidelines | 규칙만 적용 | 원문으로 한 번 점검(`theme-color`, `touch-action` 등). 스킬은 실행마다 원격 규칙을 받아 SHA 고정과 안 맞음 | 10-09 |
| Dependabot, CodeQL 기본, GitHub Rulesets | 사용 | 공개 레포 무료 기능. 필수 체크로 머지 막기 | 10-09 |
| 검색 노출 기본(robots, sitemap, 페이지별 메타, 서치 콘솔) | 채택 | 프레임워크 기본 기능으로. 검색 도구 소유 확인은 사람이 | 10-13 |
| 웹 출시 전 점검("출시 전 20가지" 중 개인정보 처리방침, 맞춤 404, OG 이미지) | 채택 | 가입을 받으면 개인정보 처리방침 필수 | 10-26 |
| BentoPDF | 개인 도구 | 보고서 PDF 합치기, 줄이기(브라우저 안에서 처리) | 10-26 |
| 입력창 기준(이름표 = 무엇, placeholder = 형식, 오류 = 다음 행동, 선택 요소 표시) | 채택 | 입력칸을 만들 때마다 네 가지 점검. 색만으로 오류를 알리지 않는다 | 10-15 |
| `pnpm audit --prod`, `pip-audit` | 사용 | 보안 소식을 보면 먼저 돌린다(추가 비용 없음) | 10-26 |
| 네이티브 `<details>` + 쉬운 말 사전 | 채택 | 용어 풀이에 의존성 0, 키보드와 스크린리더 기본 지원 | 10-07 |
| Recharts (MIT) | 유지 | 이미 번들에 있어 순증가가 없다 | 10-07 |

## 필요할 때만 (설치 없이 일회성)

| 도구 | 쓰는 법 | 날짜 |
|---|---|---|
| [MarkItDown](https://github.com/microsoft/markitdown) (MIT) | `pipx run markitdown 파일.docx` | 10-18 |
| [gitingest](https://github.com/coderamp-labs/gitingest) (MIT) | 남의 레포를 웹 채팅에 통째로 보여 줄 때만 | 10-26 |
| 보안 감사 스킬(Cloudflare security-audit-skill, 공식 `claude-security`) | 큰 출시 전 한 번(여러 에이전트라 토큰이 큼) | 10-26 |
| HyperFrames (Apache-2.0) | 발표 영상이 필요할 때 | 10-06 |
| Remotion | HyperFrames가 맞지 않을 때만. 일정 규모 이상 회사는 라이선스가 따로 있어 후순위 | 10-09 |
| knip | 안 쓰는 export 찾기: `npx -y knip@5 --include exports,types,files`. 결과는 검토 범위 파일로만 좁힌다 | 10-13 |
| gitleaks | git 전체 이력 비밀키 검사, 릴리스 바이너리 일회성 | 10-20 |
| Stirling-PDF, MinerU | PDF 작업은 BentoPDF로 충분, 설치가 필요한 이 둘은 꼭 필요할 때만 | 10-26 |

## 아이디어만 (설치하지 않음)

| 도구 | 가져온 생각 | 날짜 |
|---|---|---|
| [superpowers](https://github.com/obra/superpowers) (MIT) | 질문 → 설계 승인 → 짧은 계획 → 테스트 먼저. 단계마다 문서를 만들어 토큰이 많아 개인 선택 | 10-26 |
| [andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) (라이선스 없음) | "단계 → 확인 방법" 계획 형식. 원문은 복사하지 않음 | 10-21 |
| [mattpocock/skills](https://github.com/mattpocock/skills) (MIT) | prototype의 `?variant=`로 시안 비교. grill-me, handoff는 기존 방식과 겹침 | 10-13 |
| awesome-claude-design, Apple 스타일 DESIGN.md | 절제 원칙 대조, 터치 영역 규칙만 추가 | 09-23 |
| [design-motion-principles](https://github.com/kylezantos/design-motion-principles) (MIT) | 자주 반복되는 동작은 모션 없이, reduced-motion 필수(이미 충족) | 10-15 |
| [emil-design-eng, apple-design](https://github.com/emilkowalski/skills) (MIT) | 눌림 피드백은 pointer-down에 바로 | 10-09 |
| 화면 만드는 8역할 프롬프트 | 마지막 "화면 검수"(실제 캡처 비교, 영향 큰 차이부터)만 작업 끝 절차로 | 10-09 |
| 기업 자체 업무 벤치마크(스크랩) | 범용 점수보다 우리 업무 기준으로 모델 선택 | 10-15 |
| "CLAUDE.md는 부탁, 훅은 강제" | 채택해 훅으로 적용 | 10-20 |
| "에이전트 말고 스킬(업무별 설명서)" | 이미 하는 방식: AI 하나 + 규칙 문서 + 완료 기준, 틀리면 설명서를 고친다 | 10-20 |
| "크래시 아웃", "공격적 질문 8기법"(답을 스스로 공격해 검증) | 프롬프트보다 실제 검증(테스트, 실측, 감사) | 10-26 |
| [diagram-design](https://github.com/cathrynlavery/diagram-design) (MIT) | 보고서 그림은 직접, 본문 서체로. mermaid로 충분 | 10-26 |
| Google Stitch | 무료 크레딧이지만 방향이 정해지면 불필요 | 10-27 |
| 형식 검증(Claude + Theorem) | "지킬 약속을 먼저 적고 경계 입력으로 검사" | 10-27 |
| [Laya](https://github.com/NandhaKishorM/laya) (Apache-2.0) | CPU로 도는 분류 모델 후보(다음 프로젝트) | 10-27 |
| Claude Code 팁(`/security-review`, 오토 모드, `ultrathink`, 스킵 퍼미션) | `/security-review`만 채택. 스킵 퍼미션은 쓰지 않고, 생각 강도 문구는 지시문에 넣지 않음 | 10-11 |
| "아우라 파밍"(AI 티 나는 디자인 금지) | DESIGN.md 금지 항목과 문구 검사로 이미 충족 | 10-20 |
| Whisper (MIT) | 음성 입력을 넣을 때 후보. 지금은 메모만 | 10-26 |
| View Transitions(브라우저 기본) | 목록 카드에서 상세로 넘어가는 모션 후보. 모션 규칙을 바꾸는 결정이라 사람이 정한다 | 10-06 |

## 기각

| 도구 | 이유(기준 번호) | 날짜 |
|---|---|---|
| ui-ux-pro-max-skill | 스타일 고르는 도구, 방향은 이미 정함(6) | 10-20 |
| caveman, caveman-compress, cavecrew | 실제 절감 효과 작음, 간결 출력 스타일로 충분(6) | 10-15 |
| [hallmark](https://github.com/nutlope/hallmark) | 게이트가 길어 토큰 부담(3, 6) | 10-09 |
| Ruflo(옛 Claude Flow), ECC, Cindy, Orca, "육칠" 병렬 에이전트 | 에이전트 군집, 하네스 교체로 토큰 몇 배(2, 3) | 10-26 |
| Graphify, Graft(Trail-code), Codebase Memory MCP, Agency Agents | 색인, 메모리 관리 부담, 첫 실행에 지난 대화를 읽어 사용량(2, 3) | 10-27 |
| context7 등 상시 연결 MCP | 매 대화 토큰 증가(3) | 10-26 |
| 공식 `security-guidance` 플러그인 | 매 턴 diff 재검토로 토큰이 계속 듦(3) | 10-26 |
| Claude Mem, gstack | 내장 메모리와 겹침, 라이선스 표기 혼선, 스킬 23개(3, 4, 6) | 10-27 |
| addyosmani/agent-skills | 스킬 24개와 훅이 기존 규칙과 두 벌이 됨(6) | 10-21 |
| Firecrawl | 호스팅판 과금, 무료는 셀프 호스팅(1, 2) | 10-11 |
| Ollama, OpenJarvis, ComfyUI | 모델 서버, 모델 파일 관리(2) | 10-27 |
| OpenClaw(옛 Clawdbot) | 컴퓨터 전체 권한 데몬, 원격 코드 실행 취약점과 악성 스킬 사고(7) | 10-18 |
| PentAGI, Strix | 도커, LLM 키, 운영 주소에 공격 도구(1, 2, 7) | 10-26 |
| screenshot-to-code, Image to Code | 종량 API 키 또는 이미지 생성 필요(1) | 10-11 |
| Open Code Review, Fabric, Gemini API CLI | 별도 모델 키 필요, 내장 기능과 겹침(1, 6) | 10-27 |
| Arco Design 등 새 UI 라이브러리 | 디자인 토큰과 충돌, 번들 증가(6) | 10-15 |
| awesome-design-md, design-md-chrome, 남의 사이트 DESIGN.md 추출 확장 | 남의 브랜드를 베끼는 일(7) | 10-15 |
| REA | 상시 MCP, 바이너리 분석 도구 별도 필요(2, 3) | 10-15 |
| Agent-Reach, agent-browser | SNS 쿠키 필요, Playwright로 충분(6, 7) | 10-09 |
| public-apis | 목록일 뿐, 필요한 원천 없음(6) | 10-11 |
| ai-jailbreaks | 용도 없음, 라이선스 없음(4) | 10-26 |
| "DM으로 설치 가이드" 류 스크랩 | 실체 없음(5) | 10-20 |
| Jev 계열 API, claude-x-jev 등 9선 | 유료 종량제이거나 실체 불명(1, 5) | 10-26 |
| Impeccable | frontend-design 확장판이라 중복(6) | 10-06 |
| OpenMontage | AGPL, 생성 API 비용(1, 4) | 10-06 |
| Humanizer, ADHD 스킬 | 용도 없음(6) | 10-06 |
| "보고서 스킬" 광고 | 실체 없음(5) | 10-06 |
| prompts.chat, iFixAi, OpenShell, ai-engineering-from-scratch, AnyPS5, openGym | 프롬프트 모음, 샌드박스, 학습 자료, 무관한 앱. 쓸 곳이 없음(6) | 10-09 |
| Salesforce SOQL `FORMULA()` | 스택과 무관, Postgres는 원래 된다(6) | 10-15 |
| 공식 플러그인 frontend-design, code-review, code-simplifier | 스킬과 내장 `/code-review`, `/simplify`와 겹친다. 같은 스킬이 두 번 뜬다(6) | 10-26 |
| MoneyPrinterV2, Agent S, google-maps-scraper | 스팸 자동화, PC 원격 조작, 약관 위반 수집(7) | 10-26 |
| TencentDB Agent Memory, harness2, CLI-Anything, OmniRoute | 도커, 프록시, 모델 키, 벤치 실행 비용, 여러 제공자 키 관리(1, 2, 6) | 10-26 |
| linkedin-skills, notfair-plugin, vercel-labs writing-guidelines, vercel-labs agent-skills | 용도 없음. agent-skills는 라이선스 표기가 없어 복사하지 않음(4, 6) | 10-26 |
| Gemini CLI, Open Design, find-skills, Claude Code Setup | Claude Code와 같은 일, 자기 모델 키 필요, 허용 목록 밖 스킬을 끌어옴(1, 6) | 10-26 |
| yt-dlp, Immich, AppFlowy, Penpot, n8n, Plausible, Cal, Bitwarden | 서버 운영이 필요하거나 무관(2, 6) | 10-26 |
| 사진 앱 3개, VoiceStudio, 공식 업무 플러그인(Marketing, Legal 등), FastAPI, Dessa, DeepInfer, Raon | 무관하거나 유료 요금제 기능(1, 6) | 10-26 |
| Vibe-Trading | LLM이 매매 전략을 만든다. "자동 실행 금지" 원칙과 반대(7) | 10-26 |
| Glassy Dashboard V2 | 카드 전체를 유리로 만든다. 유리는 탐색 층에만. "Code" 댓글 미끼(5, 6) | 10-27 |

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
| marcap | 보류 | 라이선스 표시 없음 |
| dart-fss (MIT) | 보류 | 무거운 의존성, 지표 몇 개에는 과함 |
| 언론사 RSS | 보류 | 언론사마다 약관이 달라 확인 비용이 큼 |
| Radix Popover, Tooltip (MIT) | 보류 | 의존성 추가, 모바일에서 누르기 어려움 |

## 화면 스타일

| 스타일 | 판정 | 이유 | 날짜 |
|---|---|---|---|
| 유리(Liquid Glass) | 부분 채택 | 콘텐츠 위에 뜨는 탐색 층에만. 데이터 면은 불투명 | 09-26 |
| 클레이모피즘, 뉴모피즘, 스큐어모피즘 | 기각 | 낮은 대비, 근거를 읽는 화면의 무게와 맞지 않음 | 09-26 |

## 디자인 시스템 라이선스

가져다 쓰기 전에 원문을 확인합니다(09-30 기준, 쓸 때 다시 확인).

| 시스템 | 판정 |
|---|---|
| Shopify Polaris | 주의: 쇼피파이 연동 앱 한정 |
| Microsoft Fluent UI | 주의: 폰트와 아이콘 약관이 따로 있다 |
| 토스 TDS | 주의: 앱인토스 한정 |
| 당근 SEED, 라인 ABC Def | 국내에서 쓸 수 있는 후보 |
| Apache-2.0 공통 | 이름과 로고 사용 금지, "참고했다"는 서술은 가능 |
| 폰트 파일 재배포 | OFL 원문 동봉 |

## 보안 소식 (확인만)

스택에 있는지 먼저 보고, 없으면 "확인만"으로 끝냅니다.

| 소식 | 판정 | 날짜 |
|---|---|---|
| Next.js 보안 권고 3건(치명 2, 높음 1) | **적용**: `pnpm audit --prod`로 확인 후 나흘 만에 업그레이드. 코드에 해당 기능이 없어도 권고가 즉시 업그레이드를 요구하면 따른다 | 10-26 |
| PHP, GitLab, NGINX, Node.js Brotli 패치 | 확인만: 스택에 없거나 플랫폼이 자동 적용. 로컬 개발 PC만 직접 올린다 | 10-26 |
| LiteLLM 1.107.0 변조 | 확인만: 요구 파일과 로컬 환경 어디에도 없음 | 10-26 |
| Tailworm(Tailscale SSH 결함) | 확인만: 스택에 없음. 개인 PC에서 쓴다면 SSH 규칙을 기기 쌍 단위로 좁힌다 | 10-27 |

## 스크랩 판정 기록

위 표는 분야별 현재 판정, 여기는 날짜별 기록입니다. 새 스크랩은 맨 아래에 날짜 표를 덧붙입니다.

### 2026-10-30

사실은 GitHub API와 원본 README, 라이선스 원문으로 확인했습니다(별 수는 판단 근거로 쓰지 않습니다).

| 스크랩 | 판정 | 이유(기준 번호) |
|---|---|---|
| [Harness²](https://github.com/google-research/harness2) (Apache-2.0) | 기존 판정 유지(기각), 생각만 | 후보 하네스를 여러 번 돌려 비교해 토큰이 몇 배로 들고, 실제 실행에 Vertex AI 모델과 벤치 도구가 필요하다. 지원 실행기는 OpenCode, Codex뿐이다(1, 2, 3). 가져올 생각: 효과가 보인 수정과 근거 있는 교훈만 남긴다. 이미 "사고 → 규칙 한 줄 + 번호"로 하고 있다 |
| [How the Claude Code team does code review](https://claude.dev/blog/solving-code-review-at-anthropic/) (공식 글, 10-15) | **규칙 채택** | 위험도별 사람 승인, 에이전트 승인 불인정, 리뷰 3회 제한, 지적은 고치거나 이유 남기기, 되돌리는 법을 [AGENTS 템플릿](../templates/AGENTS.md)과 [PR 양식](../templates/github/pull_request_template.md)에 반영. 인원과 도구는 소규모에 맞게 줄였다. 수치는 Claude Code 팀 사례로만 인용한다 |
| Code Review for Claude Code(관리형, Team, Enterprise) | 기각 | 플랜과 별도로 사용량 크레딧 과금(1). 대신 내장 `/code-review`는 모든 플랜에서 쓰고 세션 사용량으로 계산된다. 기존 판정 유지 |
| Coolify (Apache-2.0) | 기각 | 내 서버가 필요하다(1, 2). 무료 호스팅으로 충분 |
| OpenHands (MIT) | 기각 | 모델 키가 따로 들고 Claude Code와 겹친다(1, 6) |
| Maxun (AGPL-3.0) | 기각 | 셀프 호스팅 스크래퍼(2, 7) |
| Open WebUI (자체 라이선스) | 기각 | 표준 오픈소스 라이선스가 아니고, 모델 서버나 키가 필요하다(2, 4, 6) |
| Browser Use (MIT) | 기각 | LLM 키가 필요하고 Playwright와 겹친다(1, 6) |
| Langflow (MIT), Dify (Apache-2.0 변형) | 기각 | 서버 운영, 모델 키가 필요하다. Dify는 멀티테넌트와 로고 제한이 붙는다(1, 2, 4, 6) |
| Supabase (Apache-2.0) | 호스팅 무료 플랜만 사용 | 셀프 호스팅은 기각(2) |
| Stirling PDF | 기존 판정 유지 | 필요할 때만, 평소는 BentoPDF. 일부 폴더는 별도 라이선스이므로 쓸 때 확인 |
| Crawl4AI (Apache-2.0) | 필요할 때만 | 약관을 확인한 공개 페이지를 일회성으로 정리할 때 로컬 실행 후보. 상시 수집과 클라우드 기능은 쓰지 않는다. 실행해 보지는 않았다 |
| Fincept Terminal (AGPL-3.0) | 기각 | LLM과 데이터 비용이 별도다(1, 4, 6) |
| Open-Gen-AI | 기각 | 스크랩 이름과 같은 레포를 찾지 못했다. 가장 가까운 [Open-Generative-AI](https://github.com/Anil-matcha/Open-Generative-AI)는 MuAPI 연동과 "콘텐츠 필터 없음"을 내세운다(1, 5, 7) |
| Vibe Trading (MIT) | 기존 판정 유지(기각) | "자동 실행 금지" 원칙과 반대. "돈을 찍어낸다"는 문구도 근거가 없다(7) |
| Claude Ads (MIT) | 기각 | 광고 계정 감사 스킬, 쓸 곳이 없다(6) |
| HyperFrames (Apache-2.0) | 기존 판정 유지 | 발표 영상이 필요할 때만 |
| Camofox Browser (MIT) | 기각 | 봇 탐지 우회가 목적이라 약관 위반으로 이어진다(7) |
| Oh-My-Hermes (MIT), Hermes Agent (MIT) | 기각, 생각 하나 채택 | 하네스 교체, 전문 스킬 100개 이상, 병렬 실행, 여러 모델 키(1, 2, 3, 6). 가져온 생각: 상태를 "계획 / 구현 보고 / 검증됨"으로 나눠 보고한다([prompt-claude-code.md](../templates/prompt-claude-code.md)) |
| "AI 에이전트 툴 4가지" 영상 | 기존 판정 유지(추정) | 이름이 없어 설명으로 추정했다: Graft(Trail-code), Agency Agents, Codebase Memory MCP, OpenMontage. 모두 기각. 영상에서 다른 이름이 나오면 다시 판정한다 |
| 다크패턴 9가지 | **채택** | 9개 목록은 스크랩에 없어 [deceptive.design](https://www.deceptive.design/types) 분류로 [DESIGN 템플릿](../templates/DESIGN.md)에 넣었다. 국내 규제: 전자상거래법 13개 유형(2025-02-14 시행), 금융 다크패턴 가이드라인(2026-04 시행)이 있다는 것은 금융위 자료로 확인했고, 13개 목록 원문은 확인하지 못했다 |

