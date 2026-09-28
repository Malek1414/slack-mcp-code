# slack-mcp-code

Claude Code ↔ CODE University Slack (codeuniversity.slack.com, malek.hassan@code.berlin)
via [c3-oss/slack-mcp-server](https://github.com/c3-oss/slack-mcp-server), browser-session auth, posting enabled.

- `SETUP-GUIDE.pdf`: step-by-step token extraction + registration (redo when tokens expire)
- `setup-code-slack.sh`: prompts for xoxc + d cookie, verifies with Slack, registers `slack-code` (user scope)
- The server itself runs via `npx @c3-oss/slack-mcp-server@latest`; for reading its source,
  `git clone https://github.com/c3-oss/slack-mcp-server upstream-repo` (ignored here)
- Caches: `~/.cache/slack-mcp-code/` · Tokens: `~/.claude.json` (plain text, never commit)

## Setup

1. Follow `SETUP-GUIDE.pdf` to copy your `xoxc` token and `d` cookie from Slack in Chrome.
2. `./setup-code-slack.sh`: paste both at the hidden prompts. It checks them with Slack's
   `auth.test` before registering, so a wrong paste fails loudly.
3. Restart Claude Code (or `/mcp`).

Redo 1–3 when Slack signs you out. This repo never contains tokens: they only live in
`~/.claude.json` on your Mac.
