#!/bin/zsh
# Registers the CODE University Slack workspace (malek.hassan@code.berlin) as the
# "slack-code" MCP server in Claude Code. Posting is enabled; see SETUP-GUIDE.pdf.
read -rs "XOXC?Paste xoxc token: "; echo
read -rs "XOXD?Paste d cookie (xoxd-...): "; echo
[[ $XOXC == xoxc-* ]] || { echo "xoxc token should start with xoxc-"; exit 1; }
[[ $XOXD == xoxd-* ]] || { echo "d cookie should start with xoxd-"; exit 1; }
if ! curl -s https://slack.com/api/auth.test -H "Authorization: Bearer $XOXC" -H "Cookie: d=$XOXD" | grep -q '"ok":true'; then
  echo "Slack rejected these tokens. Re-copy them (see SETUP-GUIDE.pdf)."; exit 1
fi
NPX=$(command -v npx) || { echo "npx not found — install Node.js first"; exit 1; }
mkdir -p "$HOME/.cache/slack-mcp-code"
claude mcp remove slack-code -s user >/dev/null 2>&1
claude mcp add slack-code -s user \
  -e SLACK_MCP_XOXC_TOKEN="$XOXC" \
  -e SLACK_MCP_XOXD_TOKEN="$XOXD" \
  -e SLACK_MCP_ADD_MESSAGE_TOOL=true \
  -e SLACK_MCP_USERS_CACHE="$HOME/.cache/slack-mcp-code/users.json" \
  -e SLACK_MCP_CHANNELS_CACHE="$HOME/.cache/slack-mcp-code/channels.json" \
  -- "$NPX" -y @c3-oss/slack-mcp-server@latest --transport stdio \
  | grep -v xox
echo "Done. Restart Claude Code (or run /mcp) to load slack-code."
