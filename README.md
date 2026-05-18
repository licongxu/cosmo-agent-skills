# Cosmo agent skills

Portable, domain-agnostic skills for Claude Code, Cursor, Ralph loops, and other
agentic workflows. Each skill is a directory with a `SKILL.md` file.

**Design:** principles and VLM-based checks, not copy-paste LaTeX or plotting code.
Agents edit project files, recompile or re-export, then look at the PDF.

## Install

```bash
git clone https://github.com/licongxu/cosmo-agent-skills.git
```

Symlink or copy each skill folder into `~/.cursor/skills/` (Cursor) or reference
the library path from project `CLAUDE.md` / your agent prompt.

```bash
# Cursor: one skill
ln -s "$(pwd)/vlm-figure-audit" ~/.cursor/skills/vlm-figure-audit

# Or symlink the whole library and point agents at it
ln -s "$(pwd)" ~/.cursor/skills/cosmo-agent-skills
```

## Skills

| Skill | Use when |
|-------|----------|
| [vlm-figure-audit](vlm-figure-audit/SKILL.md) | Visual QA on figures, tables, and PDF layout |
| [latex-paper-workflow](latex-paper-workflow/SKILL.md) | Building manuscript PDFs; layout debug via VLM |
| [paper-layout-review](paper-layout-review/SKILL.md) | Iterative PDF layout clash fix (text, floats, equations) |
| [scientific-plotting](scientific-plotting/SKILL.md) | Publication-quality figure exports for LaTeX |
| [prose-style-research](prose-style-research/SKILL.md) | Paper text and captions (no em dashes) |
| [research-figure-manifest](research-figure-manifest/SKILL.md) | Figure provenance and validator status |
| [results-check](results-check/SKILL.md) | VLM + numerical validation after plots or saved arrays |

## Maintenance

Keep skills short. Project-specific build commands, units, and science checks
belong in that repo's `CLAUDE.md`, not in these shared skills.
