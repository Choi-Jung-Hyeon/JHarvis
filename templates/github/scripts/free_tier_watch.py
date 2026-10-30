"""무료 한도 주간 감시(free-tier-watch.yml). 기준을 넘으면 이슈를 열거나 기존 이슈에 코멘트한다.

기준값은 워크플로 맨 위 env에서 온다. 표준 라이브러리와 gh CLI만 쓴다.
DB 값은 budget_usage.sql의 RPC가 준다. 다른 DB를 쓰면 fetch_usage만 바꾼다.
외부 API는 공급자마다 달라서 api_remaining만 바꾼다.
"""

import json
import os
import subprocess
import sys
from datetime import date, datetime, timedelta, timezone
from urllib.request import Request, urlopen

TITLE = "[ops] 무료 한도 경고"
SECURITY_TITLE = "[ops] 보안 감시 경고"
SITE_URL_TITLE = "[ops] 인증 Site URL 변경됨"
BUDGET_DOC = "docs/ops/free-tier-budget.md"


def setting(name, default=""):
    return os.environ.get(name) or default


def weekdays_between(start, end):
    """start 다음 날부터 end까지의 평일 수."""
    return sum((start + timedelta(days=i)).weekday() < 5 for i in range(1, (end - start).days + 1))


def check(usage, remaining, today):
    """usage가 비었으면(DB 미연결) DB 항목은 건너뛴다."""
    alerts = []
    if usage:
        db_limit, storage_limit = int(setting("DB_LIMIT_MB", "350")), int(setting("STORAGE_LIMIT_MB", "700"))
        db_mb, storage_mb = usage["db_bytes"] / 2**20, usage["storage_bytes"] / 2**20
        if db_mb > db_limit:
            alerts.append(f"DB {db_mb:.0f}MB > {db_limit}MB")
        if storage_mb > storage_limit:
            alerts.append(f"저장 공간 {storage_mb:.0f}MB > {storage_limit}MB")
        as_of = usage.get("last_published_as_of")
        if "last_published_as_of" in usage:  # 게시 작업이 없는 프로젝트는 RPC에서 이 값을 빼면 건너뛴다
            max_lag = int(setting("MAX_PUBLISH_LAG", "2"))
            lag = weekdays_between(date.fromisoformat(as_of), today) if as_of else None
            if lag is None:
                alerts.append("게시 기록이 없음")
            elif lag > max_lag:
                alerts.append(f"게시가 {lag}영업일 밀림(마지막 {as_of})")
    daily_plan = int(setting("API_DAILY_PLAN", "0"))
    if daily_plan:
        needed = daily_plan * weekdays_between(today, date.fromisoformat(setting("PLAN_END", "2099-12-31")))
        if remaining is None or remaining < needed:
            alerts.append(f"외부 API 남은 횟수 {remaining} < 운영 종료일까지 계획 {needed}")
    return alerts


def security_check(usage):
    """RLS가 꺼진 public 테이블과 가입 수. 값이 없으면 그것도 경고다."""
    if not usage:
        return []
    alerts = []
    tables = usage.get("rls_disabled_tables")
    if tables is None:
        alerts.append("RLS 검사값이 없음(budget_usage.sql 적용 확인)")
    elif tables:
        alerts.append(f"RLS가 꺼진 public 테이블 {len(tables)}개: {', '.join(tables)}")
    limit = int(setting("SIGNUPS_7D_LIMIT", "50"))
    signups = usage.get("signups_7d")
    if signups is None:
        alerts.append("가입 수 검사값이 없음(budget_usage.sql 적용 확인)")
    elif signups > limit:
        alerts.append(f"최근 7일 가입 {signups}건 > {limit}건")
    return alerts


def post_json(url, body, headers):
    request = Request(url, data=json.dumps(body).encode(), headers={"Content-Type": "application/json", **headers})
    with urlopen(request, timeout=30) as response:
        return json.loads(response.read())


def fetch_usage():
    url, key = setting("SUPABASE_URL"), setting("SUPABASE_SECRET_KEY")
    if not url or not key:
        return None
    return post_json(url.rstrip("/") + "/rest/v1/rpc/budget_usage", {}, {"apikey": key})


def api_remaining():
    """외부 API 남은 횟수. 공급자의 사용량 API에 맞게 고친다. 예시는 Event Registry 형식."""
    if not setting("API_KEY"):
        return None
    usage = post_json("https://eventregistry.org/api/v1/usage", {"apiKey": setting("API_KEY")}, {})
    return usage["availableTokens"] - usage["usedTokens"]


def current_site_url():
    """인증 Site URL(Management API). 되돌리지 않고 읽기만 한다."""
    request = Request(setting("AUTH_CONFIG_URL"),
                      headers={"Authorization": "Bearer " + setting("SUPABASE_ACCESS_TOKEN"),
                               "User-Agent": "free-tier-watch"})  # 기본 urllib UA는 Cloudflare가 막을 수 있다
    with urlopen(request, timeout=30) as response:
        return json.loads(response.read())["site_url"]


def report(title, body):
    found = subprocess.run(["gh", "issue", "list", "--state", "open", "--search", f'"{title}" in:title',
                            "--json", "number", "-q", ".[0].number"], capture_output=True, text=True, check=True).stdout.strip()
    if found:
        subprocess.run(["gh", "issue", "comment", found, "--body", body], check=True)
        return
    assignee = ["--assignee", setting("OWNER")] if setting("OWNER") else []
    subprocess.run(["gh", "issue", "create", "--title", title, "--body", body, *assignee], check=True)


def main():
    today = datetime.now(timezone(timedelta(hours=int(setting("UTC_OFFSET_HOURS", "9"))))).date()
    try:
        usage, usage_error = fetch_usage(), None
    except Exception as exc:  # 측정 실패도 경고로 남긴다. RLS를 못 봤으니 보안 경고로 올린다
        usage, usage_error = None, f"DB 측정 실패({type(exc).__name__})"
    try:
        remaining = api_remaining()
    except Exception:  # 측정 실패도 경고로 남긴다
        remaining = None
    alerts, security = check(usage, remaining, today), security_check(usage)
    if usage_error:
        security.append(usage_error)

    site_url, expected = None, setting("SITE_URL").rstrip("/")
    if expected and setting("AUTH_CONFIG_URL") and setting("SUPABASE_ACCESS_TOKEN"):
        try:
            site_url = current_site_url()
        except Exception as exc:  # 측정 실패도 경고로 남긴다
            site_url = f"읽기 실패({type(exc).__name__})"

    measured = {"db_bytes": (usage or {}).get("db_bytes"), "storage_bytes": (usage or {}).get("storage_bytes"),
                "api_remaining": remaining, "last_published_as_of": (usage or {}).get("last_published_as_of"),
                "signups_7d": (usage or {}).get("signups_7d"), "site_url": site_url}
    print(json.dumps({"event": "free_tier_watch", **measured, "alerts": alerts + security}, ensure_ascii=False))
    if setting("DRY_RUN") == "true":  # 수동 시험: 이슈는 남기지 않고 실패 여부만 본다
        sys.exit(1 if security else 0)
    if site_url is not None and site_url.rstrip("/") != expected:
        report(SITE_URL_TITLE, f"{today} 주간 감시\n\n- 인증 Site URL `{site_url}` != `{expected}`\n\n자동으로 되돌리지 않습니다.")
    if alerts:
        report(TITLE, f"{today} 주간 감시\n\n" + "\n".join(f"- {a}" for a in alerts)
               + f"\n\n측정값: `{json.dumps(measured)}`\n\n기준: {BUDGET_DOC}")
    if security:
        report(SECURITY_TITLE, f"{today} 주간 감시\n\n" + "\n".join(f"- {a}" for a in security))
        sys.exit(1)  # 작업을 실패로 표시해 Actions 알림 메일도 가게 한다


if __name__ == "__main__":
    main()
