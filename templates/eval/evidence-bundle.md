# 증거 묶음 구조

스크린샷 모음이 아니라 실행이 남긴 기록입니다.

```text
evidence/<run_id>/
  manifest.json        # 파일별 sha256, 묶음 해시
  summary.md           # 재현 지문(설정/계산/승인 해시), 상태, 사람이 읽는 요약
  trace_ref.json       # 트레이스 ID와 링크(본문 복사 아님)
  replay_compare.json  # 같은 입력 2회 대조 결과
  judge.json           # 축별 판정과 사유, 재시도 횟수
  approvals.json       # 누가, 언제, 무엇을 승인/거절
  citations.json       # 통과 인용 + 탈락 인용과 사유
  calibration.json     # 최근 캘리브레이션 요약과 evalset_hash
  state_dump.json      # 결정론 상태 덤프
  stop_record.json     # 차단된 경우 멈춘 지점과 이유

빠진 항목은 파일을 지우지 말고 {"available": false, "reason": "<왜>"} 로 남긴다.
제출: 성공 <n>건 + 의도적 차단 <n>건.
```
