"""실행: python3 -m unittest .github/scripts/test_free_tier_watch.py (또는 이 폴더에서 python3 -m unittest)"""
import os
import sys
import unittest
from datetime import date
from pathlib import Path
from unittest import mock

sys.path.insert(0, str(Path(__file__).parent))
import free_tier_watch as w

MB = 2**20
OK = {"db_bytes": 100 * MB, "storage_bytes": 100 * MB, "rls_disabled_tables": [], "signups_7d": 1,
      "last_published_as_of": "2026-10-29"}
THURSDAY = date(2026, 10, 29)


class Watch(unittest.TestCase):
    def test_no_alert_when_inside_limits(self):
        self.assertEqual(w.check(OK, None, THURSDAY), [])
        self.assertEqual(w.security_check(OK), [])

    def test_skips_db_checks_without_usage(self):
        self.assertEqual(w.check(None, None, THURSDAY), [])
        self.assertEqual(w.security_check(None), [])

    def test_db_storage_and_lag(self):
        usage = {**OK, "db_bytes": 400 * MB, "storage_bytes": 800 * MB, "last_published_as_of": "2026-10-20"}
        self.assertEqual(len(w.check(usage, None, THURSDAY)), 3)

    def test_no_publish_key_means_no_publish_check(self):
        usage = {k: v for k, v in OK.items() if k != "last_published_as_of"}
        self.assertEqual(w.check(usage, None, THURSDAY), [])

    def test_api_budget(self):
        env = {"API_DAILY_PLAN": "20", "PLAN_END": "2026-11-05"}  # 평일 5일 = 100회 필요
        with mock.patch.dict(os.environ, env):
            self.assertEqual(w.check(None, 100, THURSDAY), [])
            self.assertEqual(len(w.check(None, 99, THURSDAY)), 1)
            self.assertEqual(len(w.check(None, None, THURSDAY)), 1)  # 측정 실패도 경고

    def test_rls_off_and_signups(self):
        self.assertEqual(len(w.security_check({**OK, "rls_disabled_tables": ["foo"], "signups_7d": 99})), 2)
        self.assertEqual(len(w.security_check({k: v for k, v in OK.items() if k != "rls_disabled_tables"})), 1)


if __name__ == "__main__":
    unittest.main()
