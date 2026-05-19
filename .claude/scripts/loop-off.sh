#!/bin/bash
# Turn off non-stop mode.

set -euo pipefail

ROOT="${CLAUDE_PROJECT_DIR:-.}"
rm -f "$ROOT/.claude/loop.on"
echo "Non-stop loop OFF — Claude can exit normally on the next stop."
