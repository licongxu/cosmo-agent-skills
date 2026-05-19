#!/bin/bash
# Block Edit/Write outside the Claude project root (CLAUDE_PROJECT_DIR).

set -euo pipefail

if [[ -z "${CLAUDE_PROJECT_DIR:-}" ]]; then
  echo "Blocked: CLAUDE_PROJECT_DIR is not set" >&2
  exit 2
fi

if ! command -v realpath >/dev/null 2>&1; then
  echo "Blocked: realpath required for write-scope hook" >&2
  exit 2
fi

ALLOWED_ROOT=$(realpath -m "$CLAUDE_PROJECT_DIR")
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [[ -z "$FILE_PATH" ]]; then
  exit 0
fi

if [[ "$FILE_PATH" != /* ]]; then
  FILE_PATH="$ALLOWED_ROOT/$FILE_PATH"
fi

if [[ -e "$FILE_PATH" ]]; then
  CANON=$(realpath "$FILE_PATH")
else
  CANON=$(realpath -m "$FILE_PATH")
fi

if [[ "$CANON" == "$ALLOWED_ROOT" || "$CANON" == "$ALLOWED_ROOT/"* ]]; then
  exit 0
fi

echo "Blocked: file edits only allowed under $ALLOWED_ROOT (got: $CANON)" >&2
exit 2
