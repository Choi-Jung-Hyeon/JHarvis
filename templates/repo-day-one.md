# 저장소 첫날 설정 체크리스트 (팀 레포)

- [ ] 모노레포 구조: frontend / backend / engine / docs / corpus / goldenset / scripts / tests
- [ ] README, AGENTS.md(규칙 본문), CLAUDE.md(AGENTS.md를 따르라), CONTRIBUTING.md
- [ ] 브랜치 보호: main(과 develop) 직접 푸시 금지, PR 승인 <n>명, 필수 CI
- [ ] CI: ruff + pytest(Python), lint + build(웹), 개발용 의존성은 requirements-dev 한 곳
- [ ] PR 템플릿, 이슈 템플릿
- [ ] 커밋 메시지 규칙(언어, 트레일러 허용 여부)을 AGENTS.md와 CI에 같이 적기
- [ ] .gitignore: 원문 PDF, 인덱스, 비밀키. 추적은 manifest만
- [ ] 말뭉치 파일명 규칙: {source}_{type}_{YYYYMM}[_{slug}].pdf + 약어 사전
- [ ] 말뭉치 manifest: 파일명 | 출처 | 기준일 | 카테고리 | 라이선스/이용 조건 | 원문 백업 위치
- [ ] Dependabot 묶음 설정, 발표 전 일시정지 날짜
- [ ] 유료 전환 예정 기능 목록과 끌 날짜
