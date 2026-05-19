# Claude Code hooks (non-stop loop)

Copy this `.claude/` directory into your **analysis project** (not only into cosmo-agent-skills itself), then launch Claude Code from that project root.

**Note:** Installing the cosmo-agent-skills **plugin** loads skills only. Hooks are **not** applied until you copy this tree (or merge `settings.json`) into the project where you run `claude`.

## Prerequisites

- **bash**, **jq**, **realpath** (GNU coreutils) on the machine running Claude Code
- Claude Code launched from the **project root** so `CLAUDE_PROJECT_DIR` is set

## Files

| Path | Purpose |
|------|---------|
| `hooks/loop-stop.sh` | Blocks exit while `loop.on` exists; re-sends `loop-prompt.md` |
| `hooks/protect-write-scope.sh` | PreToolUse: edits only under `CLAUDE_PROJECT_DIR` |
| `scripts/loop-on.sh` / `loop-off.sh` | Toggle non-stop mode |
| `commands/loop-on.md` / `loop-off.md` | Slash commands `/loop-on`, `/loop-off` |
| `loop-prompt.md` | Continuation checklist (science, code, figures, innovate) |
| `settings.json` | Hooks + `CLAUDE_CODE_STOP_HOOK_BLOCK_CAP` + example permissions |

## Quick start

```bash
# From your project (e.g. autoflamingo):
rsync -a /path/to/cosmo-agent-skills/.claude/hooks/   .claude/hooks/
rsync -a /path/to/cosmo-agent-skills/.claude/scripts/ .claude/scripts/
rsync -a /path/to/cosmo-agent-skills/.claude/commands/ .claude/commands/
cp /path/to/cosmo-agent-skills/.claude/loop-prompt.md .claude/
# Merge hooks + env from settings.json into your .claude/settings.json
chmod +x .claude/hooks/*.sh .claude/scripts/*.sh
```

In Claude Code:

```text
/loop-on
```

Give your first task. On each stop, Claude receives `loop-prompt.md` again until `/loop-off`.

Optional: pass a one-off prompt that overwrites `loop-prompt.md`:

```text
/loop-on Focus on fixing the tSZ stacking notebook tests.
```

## Safety

- While `/loop-on` is active, Claude **cannot exit** until `/loop-off` (Stop hook blocks).
- `protect-write-scope.sh` limits **Edit** / **Write** to `CLAUDE_PROJECT_DIR` only.
- Review `permissions.allow` in `settings.json` before enabling `defaultMode: auto` in a shared repo.

## Customize

- Edit `loop-prompt.md` for your workflow.
- Tighten `permissions.allow` in `settings.json` (e.g. absolute `Edit(//scratch/.../your-project/**)`).
- `defaultMode: auto` may need to live in `~/.claude/settings.json` on Claude Code ≥ 2.1.142.

## Gitignore in your project

```gitignore
.claude/loop.on
.claude/settings.local.json
```

Commit `loop-prompt.md`, hooks, and shared `settings.json`.

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| Loop never triggers | Merge `hooks.Stop` from `settings.json`; run `/loop-on`; confirm `.claude/loop.on` exists |
| Hook errors in `/plugin` Errors tab | `chmod +x .claude/hooks/*.sh`; install `jq` |
| Writes blocked outside project | Expected — widen `permissions.allow` only if intentional |
| `loop-prompt.md` ignored | File must be non-empty; path is `$CLAUDE_PROJECT_DIR/.claude/loop-prompt.md` |

Settings snippet without copying the full template: [examples/claude-settings.nonstop-loop.json](../examples/claude-settings.nonstop-loop.json).
