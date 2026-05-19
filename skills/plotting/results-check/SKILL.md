---
name: results-check
description: >-
  Run plot-check then physics-check on a new figure and its arrays. Use proactively
  after every script that writes a plot or result file. Prefer plot-check or
  physics-check alone when only one layer applies.
---

# Results check

Orchestrator for the plotting validation stack. Same trigger as before the split,
but each step has its own skill.

## Protocol

1. **scientific-plotting** — if the figure was just exported, confirm PDF/PNG settings.
2. **plot-check** — VLM + array completeness on the figure file.
3. **physics-check** — numeric asserts on saved arrays (skip if no arrays exist).
4. **research-figure-manifest** — update validator row when both pass.

For manuscript PDF pages (tables, float placement), add **vlm-figure-audit** and
**paper-layout-review** from [paper-writing](../paper-writing/).

## Verdict

Propagate the **worst** verdict from plot-check and physics-check (`BLOCKING` >
`WARN` > `OK`). Summarize both in one line for the manifest.

## Integration

See [plotting/README.md](../README.md) for the full figure pipeline.
