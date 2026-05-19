#!/bin/bash
# When .claude/loop.on exists, block session stop and re-send .claude/loop-prompt.md.

set -euo pipefail

ROOT="${CLAUDE_PROJECT_DIR:-.}"
FLAG="$ROOT/.claude/loop.on"
PROMPT_FILE="$ROOT/.claude/loop-prompt.md"

if [[ ! -f "$FLAG" ]]; then
  exit 0
fi

if [[ -f "$PROMPT_FILE" ]] && [[ -s "$PROMPT_FILE" ]]; then
  PROMPT=$(cat "$PROMPT_FILE")
  jq -n --arg prompt "$PROMPT" '{
    "decision": "block",
    "reason": $prompt,
    "systemMessage": "Non-stop loop ON — continuation from .claude/loop-prompt.md. /loop-off to exit."
  }'
else
  jq -n '{
    "decision": "block",
    "systemMessage": "Non-stop loop ON but .claude/loop-prompt.md is missing or empty. /loop-off to exit."
  }'
fi

exit 0
