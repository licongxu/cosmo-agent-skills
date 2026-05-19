---
description: "Enable non-stop mode (Stop hook keeps the session running)"
argument-hint: "[optional continuation prompt — overwrites loop-prompt.md]"
allowed-tools: ["Bash(\"$CLAUDE_PROJECT_DIR\"/.claude/scripts/loop-on.sh:*)"]
hide-from-slash-command-tool: "true"
---

```!
"$CLAUDE_PROJECT_DIR"/.claude/scripts/loop-on.sh $ARGUMENTS
```

Non-stop mode is now active.

Each time Claude tries to stop, the Stop hook re-sends **`.claude/loop-prompt.md`**. Edit that file to change the loop instructions.

Use `/loop-off` to allow exit.
