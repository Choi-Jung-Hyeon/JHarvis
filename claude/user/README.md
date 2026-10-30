# 개인 Claude Code 설정 (전역)

`~/.claude/` 실제 값에서 공개할 수 있는 것만 옮겼습니다(2026-10-30 기준). 프로젝트 설정은 [../settings.json](../settings.json)이고, 여기 있는 것은 PC 한 대에 한 번만 합니다.

| 항목 | 값 | 파일 |
|---|---|---|
| 전역 지침 | 작업 방식 요약 | [CLAUDE.md](CLAUDE.md) |
| 설정 | 아래 표 | [settings.example.json](settings.example.json) |
| 플러그인 | 3개(아래 표) | settings의 `enabledPlugins` |
| 상태 표시줄 | ponytail 제공 스크립트 | settings의 `statusLine` |
| 출력 스타일 | 지정 없음(기본). `outputStyle` 키도 `~/.claude/output-styles/`도 없다 | — |
| 커스텀 명령 | 없음. `~/.claude/commands/`를 두지 않고 내장 명령과 플러그인 명령을 쓴다 | — |

`claude/user/CLAUDE.md`는 원래 `~/.claude/CLAUDE.md`가 없어서, 프로젝트 메모리에 쌓인 개인 지침을 일반화해 새로 쓴 판입니다.

## 플러그인

| 플러그인 | 판 | 커밋 | 마켓 | 왜 |
|---|---|---|---|---|
| `ponytail@ponytail` (MIT) | 5.3.2 | `09c434ab73ca43761c5d8b0c5d341926c2fba710` | `DietrichGebert/ponytail` | 코드 줄이기, 작업 끝 점검 |
| `playwright@claude-plugins-official` | `f8c5e7a1dcb7` | `f8c5e7a1dcb71b10cb74586224b5401f3de5db28` | `anthropics/claude-plugins-official` | 브라우저 확인(필요할 때만 불러와 평소 토큰 부담 없음) |
| `vercel@claude-plugins-official` | 0.50.0 | `882e66c2698689324c341b7bb8fd8beb92c27bf6` | `anthropics/claude-plugins-official` | Vercel 배포와 Next 문서. 다른 호스팅을 쓰는 프로젝트에서는 끈다 |

## 설정 값과 이유

| 키 | 값 | 이유 |
|---|---|---|
| `model` | `opus` | 기본 모델 |
| `modelSettings` | Opus 5 `high`, Opus 5.5 `medium` | 모델별 노력 수준 |
| `alwaysThinkingEnabled` | `true` | 판단이 많은 작업이 대부분이라 |
| `autoCompactEnabled` | `true` | 긴 작업이 끊기지 않게 |
| `permissions.allow` | `git stash`, `git checkout` | 자주 쓰는 로컬 명령만 |
| `permissions.ask` | `gh api`, `git push` | 밖으로 나가는 명령은 매번 묻는다 |
| `permissions.deny` | `git push --force`, `git push -f` | 강제 push 금지. main 보호는 GitHub Rulesets가 함께 맡는다 |
| 알림 | `iterm2` 채널, 입력 대기와 에이전트 알림 켬 | 터미널에 맞게 바꾼다 |

쓰지 않는 것: 권한 건너뛰기(skip permissions), 상시 연결 MCP.

## 새 PC에서 같은 환경 만들기

1. Claude Code를 설치하고 로그인합니다.
2. 이 레포를 받습니다.

   ```bash
   git clone https://github.com/Choi-Jung-Hyeon/JHarvis ~/jharvis
   ```

3. 설정을 복사합니다. 이미 있는 설정이 있으면 덮어쓰지 말고 키를 합칩니다.

   ```bash
   mkdir -p ~/.claude
   cp ~/jharvis/claude/user/CLAUDE.md ~/.claude/CLAUDE.md
   cp ~/jharvis/claude/user/settings.example.json ~/.claude/settings.json
   ```

4. Claude Code를 켜면 `extraKnownMarketplaces`와 `enabledPlugins`를 보고 설치를 묻습니다. 묻지 않으면 직접 설치합니다.

   ```
   /plugin marketplace add DietrichGebert/ponytail
   /plugin install ponytail@ponytail
   /plugin install playwright@claude-plugins-official
   /plugin install vercel@claude-plugins-official
   ```

5. 상태 표시줄 경로의 판 번호를 실제 설치된 판에 맞춥니다.

   ```bash
   ls ~/.claude/plugins/cache/ponytail/ponytail/
   ```

6. 공개 레포에 쓸 커밋 이메일을 GitHub noreply 주소로 바꿉니다(주소는 GitHub Settings의 Emails에 있습니다).

   ```bash
   git config --global user.email "<번호>+<계정>@users.noreply.github.com"
   ```

7. 확인합니다. 새 세션에서 `/status`로 모델과 설정 파일을, `/plugin`으로 플러그인 3개를 봅니다. 상태 표시줄이 보이고 `ponytail`이 켜져 있으면 성공입니다.
