# Paper-writing skills

Manuscript planning, IMRaD prose, LaTeX compile, and PDF layout — not figure export
or plot validation (see [plotting](../plotting/)).

Each skill is **self-contained**. Paths, build commands, and domain rules belong in
that repo's `CLAUDE.md`.

| Skill | Use when |
|-------|----------|
| [paper-writing-workflow](paper-writing-workflow/SKILL.md) | Plan → draft → compile → layout QA |
| [manuscript-writing-style](manuscript-writing-style/SKILL.md) | IMRaD prose, tone, captions, English mechanics |
| [paper-layout-review](paper-layout-review/SKILL.md) | Iterative float/equation layout clash fix |

## Plotting and figure validation

Use the [plotting](../plotting/) category for exports and checks:

| Skill | Use when |
|-------|----------|
| [scientific-plotting](../plotting/scientific-plotting/SKILL.md) | Vector PDF at column width |
| [plot-check](../plotting/plot-check/SKILL.md) | VLM + array completeness after `savefig` |
| [physics-check](../plotting/physics-check/SKILL.md) | Numeric asserts on saved arrays |
| [vlm-figure-audit](../plotting/vlm-figure-audit/SKILL.md) | Figure/table visual QA at print size |
| [research-figure-manifest](../plotting/research-figure-manifest/SKILL.md) | Figure provenance and validator status |
| [results-check](../plotting/results-check/SKILL.md) | plot-check → physics-check in one pass |

**Typical manuscript order:** workflow → style while drafting →
scientific-plotting → plot-check → physics-check → manifest → compile →
vlm-figure-audit → paper-layout-review.

References (optional): Chamba et al. (2022) — [arXiv:2207.12959](https://arxiv.org/abs/2207.12959).
