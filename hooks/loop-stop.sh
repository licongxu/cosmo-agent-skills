#!/bin/bash
# When .claude/loop.on exists in the project, block stop and re-send loop prompt.

set -euo pipefail

PROJECT="${CLAUDE_PROJECT_DIR:-.}"
PLUGIN="${CLAUDE_PLUGIN_ROOT:-}"

FLAG="$PROJECT/.claude/loop.on"
PROJECT_PROMPT="$PROJECT/.claude/loop-prompt.md"
DEFAULT_PROMPT="${PLUGIN}/loop-prompt.md"

if [[ ! -f "$FLAG" ]]; then
  exit 0
fi

PROMPT_FILE=""
if [[ -f "$PROJECT_PROMPT" ]] && [[ -s "$PROJECT_PROMPT" ]]; then
  PROMPT_FILE="$PROJECT_PROMPT"
elif [[ -n "$PLUGIN" && -f "$DEFAULT_PROMPT" ]] && [[ -s "$DEFAULT_PROMPT" ]]; then
  PROMPT_FILE="$DEFAULT_PROMPT"
fi

if [[ -n "$PROMPT_FILE" ]]; then
  PROMPT=$(cat "$PROMPT_FILE")
  jq -n --arg prompt "$PROMPT" '{
    "decision": "block",
    "reason": $prompt,
    "systemMessage": "Non-stop loop ON — /loop-off to exit."
  }'
else
  jq -n '{
    "decision": "block",
    "systemMessage": "Non-stop loop ON but no loop prompt found. Add .claude/loop-prompt.md or reinstall cosmo-agent-skills. /loop-off to exit."
  }'
fi

exit 0
