#!/bin/bash
# Turn on non-stop mode. Continuation prompt: .claude/loop-prompt.md

set -euo pipefail

ROOT="${CLAUDE_PROJECT_DIR:-.}"
mkdir -p "$ROOT/.claude"
touch "$ROOT/.claude/loop.on"

if [[ $# -gt 0 ]]; then
  printf '%s\n' "$*" > "$ROOT/.claude/loop-prompt.md"
  echo "Non-stop loop ON (prompt saved to .claude/loop-prompt.md)"
else
  echo "Non-stop loop ON"
  echo "  Flag:   .claude/loop.on"
  echo "  Prompt: .claude/loop-prompt.md (edit to change continuation text)"
fi
echo "  Stop:   /loop-off"
