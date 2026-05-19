# Plotting and figure validation skills

Publication export, visual plot QA, numeric/physics checks, and VLM audit — usable
**outside** a manuscript (analysis notebooks, talks) or as input to
[paper-writing](../paper-writing/).

Each skill is **self-contained**. Domain thresholds, units, and assert tables live
in the project's `CLAUDE.md`, not here.

| Skill | Use when |
|-------|----------|
| [scientific-plotting](scientific-plotting/SKILL.md) | Export vector PDF / PNG at dpi=300 for print |
| [plot-check](plot-check/SKILL.md) | VLM + array completeness right after `savefig` |
| [physics-check](physics-check/SKILL.md) | Numeric sanity on saved arrays (project asserts) |
| [vlm-figure-audit](vlm-figure-audit/SKILL.md) | Figure/table legibility and completeness at print size |
| [research-figure-manifest](research-figure-manifest/SKILL.md) | Provenance and validator status per figure |
| [results-check](results-check/SKILL.md) | Run plot-check → physics-check in one pass (alias) |

**Typical order:** scientific-plotting → plot-check → physics-check →
vlm-figure-audit → update research-figure-manifest.

For LaTeX float clashes and full-page layout loops, use
[paper-layout-review](../paper-writing/paper-layout-review/SKILL.md).
