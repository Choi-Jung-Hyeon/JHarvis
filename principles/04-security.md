# 04. 보안과 개인정보

## 처음부터 넣는 것

- 비밀키 파일(`.env*`)은 `.gitignore` + 훅으로 AI 수정 차단. 템플릿 `.env.example`만 커밋.
- `permissions.deny`의 `Read` 규칙은 Read 도구만 막는다. 셸로 읽는 것까지 완전히 막지는 못한다.
- 쓰기 권한 키는 CI 비밀값(GitHub Actions secrets)에만. 브라우저에는 공개 키와 로그인 세션만.
- DB 새 테이블은 같은 마이그레이션에서 RLS 켜기와 필요한 GRANT를 함께:

```sql
alter table public.foo enable row level security;
create policy "foo read" on public.foo for select to anon, authenticated using (true);
revoke all on public.foo from anon, authenticated;
grant select on public.foo to anon, authenticated;
grant all on public.foo to service_role;
```

- 보안 헤더와 콘텐츠 보안 정책(CSP). 개발용 화면은 운영에서 404.
- 서드파티 GitHub Action은 SHA로 고정. 워크플로에 `permissions: contents: read` 기본.
- 공개 레포 커밋은 GitHub noreply 이메일로. 전역 git 이메일이 개인 주소면 레포마다 바꾼다(한 번 push하면 기록에 남는다).
- 실제 개인 데이터(계좌, 신분증, 개인 화면 캡처)는 레포, PR, 이슈, 스크린샷 어디에도 올리지 않는다. 시험 이미지는 가짜 수치로 새로 만든다.
- 가입을 받으면 개인정보 처리방침 페이지와 계정 삭제 기능.

## 점검 절차 (사고 사례 기준)

[templates/security-audit.md](../templates/security-audit.md) 형식으로, 최근 실제 사고의 공통점을 기준으로 본다.

1. 로그인 없이 쓰는 기능, 내부용 기능이 뚫리는가: 익명, 다른 사용자 토큰으로 실제 시험(`BEGIN … ROLLBACK` 안에서 역할 바꾸기). 본인 토큰으로는 보이는지 대조군을 같이 돌린다. 개발용 화면은 내용뿐 아니라 상태 코드까지 404인지 본다.
2. 늦게 알게 되는가: 주간 감시가 RLS 꺼짐, 가입 급증을 잡는가.
3. 의존성: `pnpm audit --prod`, `pip-audit`. 프레임워크 보안 권고는 공개 뒤 며칠 안에 반영.

## 운영 경로 변경

- 정기 실행, 비밀키, 인증, 배포 설정, 마이그레이션을 바꾸는 PR은 머지 전 `/security-review`(내장, 추가 비용 없음).
- 정기 작업은 `dry_run` 수동 실행으로 다음 예약 실행이 통과하는지 확인.
- 공격 도구(펜테스트 에이전트 등)를 운영 주소에 돌리지 않는다.
