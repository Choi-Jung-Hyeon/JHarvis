"""실행: python3 claude/hooks/test_guard.py"""
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock

sys.path.insert(0, str(Path(__file__).parent))
import guard


class Guard(unittest.TestCase):
    def test_protect(self):
        self.assertTrue(guard.protect({"file_path": "/x/.env.local"}))
        self.assertIsNone(guard.protect({"file_path": "/x/.env.example"}))

    def test_commit_checks_files_not_staged_yet(self):
        with tempfile.TemporaryDirectory() as folder:
            subprocess.run(["git", "init", "-q"], cwd=folder, check=True)
            (Path(folder) / "my file.py").write_text("")
            failing = [(lambda files: "my file.py" in files, ["false"], ".")]
            with mock.patch.object(guard, "ROOT", Path(folder)), mock.patch.object(guard, "CHECKS", failing):
                self.assertTrue(guard.commit({"command": "git add -A && git commit -m x"}))
                self.assertIsNone(guard.commit({"command": "git status"}))


if __name__ == "__main__":
    unittest.main()
