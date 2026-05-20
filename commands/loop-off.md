---
description: "Disable non-stop mode"
allowed-tools: ["Bash(*loop-off.sh*)"]
hide-from-slash-command-tool: "true"
---

```!
bash -c 'if [[ -n "${CLAUDE_PLUGIN_ROOT:-}" && -x "${CLAUDE_PLUGIN_ROOT}/scripts/loop-off.sh" ]]; then exec "${CLAUDE_PLUGIN_ROOT}/scripts/loop-off.sh"; elif [[ -x .claude/scripts/loop-off.sh ]]; then exec bash .claude/scripts/loop-off.sh; else echo "loop-off.sh not found" >&2; exit 1; fi'
```
