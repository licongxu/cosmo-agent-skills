#!/bin/bash
# Turn on non-stop mode. Project prompt overrides plugin default.

set -euo pipefail

PROJECT="${CLAUDE_PROJECT_DIR:-.}"
mkdir -p "$PROJECT/.claude"
touch "$PROJECT/.claude/loop.on"

if [[ $# -gt 0 ]]; then
  printf '%s\n' "$*" > "$PROJECT/.claude/loop-prompt.md"
  echo "Non-stop loop ON (prompt saved to .claude/loop-prompt.md)"
else
  echo "Non-stop loop ON"
  echo "  Flag:   .claude/loop.on"
  echo "  Prompt: .claude/loop-prompt.md (optional override)"
  echo "          or plugin default loop-prompt.md"
fi
echo "  Stop:   /loop-off"
