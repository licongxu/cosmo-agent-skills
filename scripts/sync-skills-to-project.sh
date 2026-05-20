#!/bin/bash
# Copy cosmo-agent-skills into a project's flat .claude/skills/ layout.
# Usage: sync-skills-to-project.sh /path/to/project

set -euo pipefail

PLUGIN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="${1:?usage: $0 /path/to/project}"

DEST_SKILLS="$DEST/.claude/skills"
mkdir -p "$DEST_SKILLS"

copy_skill() {
  local src="$1" name="$2"
  mkdir -p "$DEST_SKILLS/$name"
  cp "$src/SKILL.md" "$DEST_SKILLS/$name/SKILL.md"
}

for d in "$PLUGIN_ROOT"/skills/plotting/*/; do
  copy_skill "$d" "$(basename "$d")"
done
for d in "$PLUGIN_ROOT"/skills/paper-writing/*/; do
  copy_skill "$d" "$(basename "$d")"
done
for d in "$PLUGIN_ROOT"/skills/coding/*/; do
  copy_skill "$d" "$(basename "$d")"
done
for d in "$PLUGIN_ROOT"/skills/hydrosim/flamingo/*/; do
  name="flamingo-$(basename "$d")"
  copy_skill "$d" "$name"
done

echo "Synced skills to $DEST_SKILLS"
