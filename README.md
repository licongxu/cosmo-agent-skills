# Cosmo agent skills

Portable skills for Claude Code, Cursor, Ralph loops, and other agent workflows.
This repository **is** also a Claude Code plugin — skills live under `skills/`; manifest
under `.claude-plugin/` (tracked in git).

**Design:** principles and checks, not copy-paste recipes. Every `SKILL.md` works
standalone in any project — symlink, copy, or install via plugin. Project-specific
commands, units, and science belong in that repo's `CLAUDE.md`.

## Layout

```
cosmo-agent-skills/
├── .claude/                  # hooks + non-stop loop (copy into your project)
│   ├── hooks/                # loop-stop, protect-write-scope
│   ├── scripts/              # loop-on, loop-off
│   ├── commands/             # /loop-on, /loop-off
│   ├── loop-prompt.md        # continuation checklist each stop
│   └── settings.json         # template (hooks + permissions)
├── .claude-plugin/
│   ├── plugin.json           # plugin manifest
│   └── marketplace.json      # marketplace catalog
├── agents/                   # bundled subagents (code-reviewer, repo-organizer)
├── examples/                 # settings snippets
├── ref_papers/               # local PDFs only (gitignored)
└── skills/
    ├── hydrosim/             # simulation data (FLAMINGO: 6 skills)
    ├── plotting/             # figure export + validation (6 skills)
    ├── paper-writing/        # manuscript workflow (3 skills)
    └── coding/               # software engineering (4 skills)
```

Add new categories under `skills/` with a category `README.md`.

## Non-stop loop (Claude Code hooks)

Optional **autonomous iteration**: a Stop hook re-sends `.claude/loop-prompt.md` whenever Claude tries to end a turn, so the session keeps running until you run `/loop-off`.

1. Copy [`.claude/`](.claude/README.md) into your project (or `rsync` hooks, scripts, commands, and `loop-prompt.md`).
2. Merge `hooks` and `env` from [`.claude/settings.json`](.claude/settings.json) or [examples/claude-settings.nonstop-loop.json](examples/claude-settings.nonstop-loop.json).
3. `chmod +x .claude/hooks/*.sh .claude/scripts/*.sh`
4. In Claude Code: `/loop-on`, then your first task. Run `/loop-off` when done.

Requires **bash**, **jq**, and **realpath**. Plugin install alone does not enable hooks — copy `.claude/` into your project.

See [.claude/README.md](.claude/README.md) for safety notes and troubleshooting. Customize `loop-prompt.md` per project.

## Claude Code plugin

Per [Create plugins](https://code.claude.com/docs/en/plugins):

```bash
# Dev: load this repo as a plugin
claude --plugin-dir .

# Persistent: register marketplace + install
/plugin marketplace add /path/to/cosmo-agent-skills
/plugin install cosmo-agent-skills@cosmo-agent-skills
```

Skills invoke as `/cosmo-agent-skills:<skill-name>` (e.g. `/cosmo-agent-skills:code-testing`).

Validate: `claude plugin validate .`

Bump `version` in `.claude-plugin/plugin.json` and `marketplace.json` when releasing.

## Install (pick one)

**Cursor / Claude Code (standalone skills)** — symlink or copy individual skills:

```bash
git clone https://github.com/licongxu/cosmo-agent-skills.git
cd cosmo-agent-skills

# Cursor: one skill → ~/.cursor/skills/
for d in skills/plotting/*/ skills/paper-writing/*/ skills/coding/*/; do
  ln -sf "$(pwd)/$d" ~/.cursor/skills/"$(basename "$d")"
done
```

Skills trigger by name/description in any repo. No dependency on this repository's layout.

**Claude Code plugin** — see [Claude Code plugin](#claude-code-plugin) above for
`/plugin install` and namespaced skills (`/cosmo-agent-skills:code-testing`).

## Categories

### [skills/hydrosim/flamingo/](skills/hydrosim/flamingo/)

[FLAMINGO data release](https://dataweb.cosma.dur.ac.uk:8443/flamingo/index.html) — run inventory and data products. Facts verified against the portal and Schaye et al. (2023) / Helly et al. (2026) release paper.

| Skill | Use when |
|-------|----------|
| [flamingo-simulations](skills/hydrosim/flamingo/simulations/SKILL.md) | Choosing a run, paths, naming, variations |
| [flamingo-power-spectra](skills/hydrosim/flamingo/power-spectra/SKILL.md) | ASCII P(k), emulator, units |
| [flamingo-snapshots](skills/hydrosim/flamingo/snapshots/SKILL.md) | Particle HDF5, partial snapshots |
| [flamingo-halo-catalogues](skills/hydrosim/flamingo/halo-catalogues/SKILL.md) | SOAP / HBT-HERONS catalogues |
| [flamingo-lightcones](skills/hydrosim/flamingo/lightcones/SKILL.md) | HEALPix maps, particle and halo lightcones |
| [flamingo-hdfstream](skills/hydrosim/flamingo/hdfstream/SKILL.md) | Remote streaming access to FLAMINGO HDF5 on COSMA (default) |

The bundled **flamingo** subagent (in `agents/`) wires these six skills together for end-to-end FLAMINGO queries.

Local PDFs (optional): `ref_papers/flaming_schaye23.pdf`, `ref_papers/flamingo_dr26.pdf`.

### [skills/plotting/](skills/plotting/)

Figure export and validation — usable in analysis repos or before/during manuscript work.

| Skill | Use when |
|-------|----------|
| [scientific-plotting](skills/plotting/scientific-plotting/SKILL.md) | Vector PDF / PNG dpi=300 exports |
| [plot-check](skills/plotting/plot-check/SKILL.md) | VLM + array completeness after `savefig` |
| [physics-check](skills/plotting/physics-check/SKILL.md) | Numeric asserts on saved arrays |
| [vlm-figure-audit](skills/plotting/vlm-figure-audit/SKILL.md) | Figure/table visual QA at print size |
| [research-figure-manifest](skills/plotting/research-figure-manifest/SKILL.md) | Figure provenance and validator status |
| [results-check](skills/plotting/results-check/SKILL.md) | plot-check → physics-check orchestrator |

### [skills/paper-writing/](skills/paper-writing/)

Manuscript planning, IMRaD prose, LaTeX compile, PDF layout. Figure pipeline → [plotting/](skills/plotting/).

| Skill | Use when |
|-------|----------|
| [paper-writing-workflow](skills/paper-writing/paper-writing-workflow/SKILL.md) | Plan → draft → compile → layout QA |
| [manuscript-writing-style](skills/paper-writing/manuscript-writing-style/SKILL.md) | IMRaD text, tone, captions |
| [paper-layout-review](skills/paper-writing/paper-layout-review/SKILL.md) | PDF float/equation clash loop |

References (optional): Chamba et al. (2022) — [arXiv:2207.12959](https://arxiv.org/abs/2207.12959).
This repo keeps optional local PDFs in `ref_papers/` (gitignored); see [ref_papers/README.md](ref_papers/README.md).

### [skills/coding/](skills/coding/)

Software engineering — write, test, review.

| Skill | Use when |
|-------|----------|
| [code-writing](skills/coding/code-writing/SKILL.md) | Implement with minimal diff, explicit assumptions |
| [code-testing](skills/coding/code-testing/SKILL.md) | Test-first, verify red/green, edge cases |
| [code-reviewer](skills/coding/code-reviewer/SKILL.md) | Diff review vs plan/requirements before merge |
| [repo-hygiene](skills/coding/repo-hygiene/SKILL.md) | Audit layout, remove stale artifacts, align docs |

**Subagents** (in `agents/`): **code-reviewer**, **repo-organizer** — dispatch for review or repo cleanup passes.

## Adding skills

1. Add `skills/<category>/<skill-name>/SKILL.md` with frontmatter `name` and `description`.
2. Update category `README.md` and this file.
3. Bump `.claude-plugin/plugin.json` and `marketplace.json` `version` when releasing.

Keep each skill short. One concern per skill; use the category README for workflow order.
