---
description: "Enable non-stop mode (Stop hook keeps the session running)"
argument-hint: "[optional continuation prompt — saves to project .claude/loop-prompt.md]"
allowed-tools: ["Bash(*loop-on.sh*)"]
hide-from-slash-command-tool: "true"
---

```!
bash -c 'if [[ -n "${CLAUDE_PLUGIN_ROOT:-}" && -x "${CLAUDE_PLUGIN_ROOT}/scripts/loop-on.sh" ]]; then exec "${CLAUDE_PLUGIN_ROOT}/scripts/loop-on.sh" "$@"; elif [[ -x .claude/scripts/loop-on.sh ]]; then exec bash .claude/scripts/loop-on.sh "$@"; else echo "loop-on.sh not found (install cosmo-agent-skills plugin or add .claude/scripts/loop-on.sh)" >&2; exit 1; fi' _ $ARGUMENTS
```

Non-stop mode is now active (cosmo-agent-skills plugin).

Each time Claude tries to stop, the Stop hook re-sends the loop prompt:
project **`.claude/loop-prompt.md`** if present, otherwise the plugin default.

Use `/loop-off` to allow exit.
