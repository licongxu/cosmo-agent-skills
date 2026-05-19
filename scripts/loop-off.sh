#!/bin/bash
# Turn off non-stop mode.

set -euo pipefail

PROJECT="${CLAUDE_PROJECT_DIR:-.}"
rm -f "$PROJECT/.claude/loop.on"
echo "Non-stop loop OFF — Claude can exit normally on the next stop."
