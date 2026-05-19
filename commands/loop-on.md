---
description: "Enable non-stop mode (Stop hook keeps the session running)"
argument-hint: "[optional continuation prompt — saves to project .claude/loop-prompt.md]"
allowed-tools: ["Bash(\"${CLAUDE_PLUGIN_ROOT}/scripts/loop-on.sh:*\")"]
hide-from-slash-command-tool: "true"
---

```!
"${CLAUDE_PLUGIN_ROOT}"/scripts/loop-on.sh $ARGUMENTS
```

Non-stop mode is now active (cosmo-agent-skills plugin).

Each time Claude tries to stop, the Stop hook re-sends the loop prompt:
project **`.claude/loop-prompt.md`** if present, otherwise the plugin default.

Use `/loop-off` to allow exit.
