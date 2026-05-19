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
├── .claude-plugin/
│   ├── plugin.json           # plugin manifest
│   └── marketplace.json      # marketplace catalog
├── agents/                   # bundled subagents (code-reviewer, repo-organizer)
├── ref_papers/               # local PDFs only (gitignored)
└── skills/
    ├── hydrosim/             # simulation data (FLAMINGO: 6 skills)
    ├── paper-writing/        # manuscript workflow (7 skills)
    └── coding/               # software engineering (4 skills)
```

Add new categories under `skills/` with a category `README.md`.

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
for d in skills/paper-writing/*/ skills/coding/*/; do
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

### [skills/paper-writing/](skills/paper-writing/)

Manuscript planning, prose, figures, validation, LaTeX compile, VLM layout QA.

| Skill | Use when |
|-------|----------|
| [paper-writing-workflow](skills/paper-writing/paper-writing-workflow/SKILL.md) | Plan → draft → compile → VLM |
| [manuscript-writing-style](skills/paper-writing/manuscript-writing-style/SKILL.md) | IMRaD text, tone, captions |
| [scientific-plotting](skills/paper-writing/scientific-plotting/SKILL.md) | Publication-quality figure exports |
| [results-check](skills/paper-writing/results-check/SKILL.md) | VLM + numeric validation |
| [vlm-figure-audit](skills/paper-writing/vlm-figure-audit/SKILL.md) | Figure/table visual QA |
| [paper-layout-review](skills/paper-writing/paper-layout-review/SKILL.md) | PDF layout clash loop |
| [research-figure-manifest](skills/paper-writing/research-figure-manifest/SKILL.md) | Figure provenance |

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
