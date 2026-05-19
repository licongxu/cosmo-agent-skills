---
name: research-figure-manifest
description: >-
  Tracks which script and run produced each manuscript figure, plus VLM validator
  status. Use when adding figures, auditing stale results, or long agent runs.
---

# Research figure manifest

Stale or unverified figures are a common source of wrong papers. Keep a simple
record linking each figure in the manuscript to how it was produced and whether
VLM audit passed.

## Per-figure record

| Field | Purpose |
|-------|---------|
| Figure path | File on disk under the paper figures directory |
| Manuscript reference | Where the paper cites it (section, label name) |
| Generating script | Script that produced the file |
| Input artifacts | Data files or run directory used |
| Run id / git hash | Reproducibility |
| Sample count, seed | If applicable |
| Validator | OK / WARN / BLOCKING from **plot-check**, **physics-check**, and/or **vlm-figure-audit** + date |

Store in project notes or a manifest file the repo already uses.

## Rules

- New figure: add a row and pass VLM before citing in the abstract or key claims.
- Regenerated figure: update run id, re-run VLM, refresh validator status.
- Removed data: remove or archive the file and update manuscript references.

## Audit pass (long agent runs)

List figures referenced by the manuscript; flag missing files, missing scripts, or
BLOCKING validator status. Fix or regenerate before unrelated work.

## Integration

- **scientific-plotting:** export rules for the asset file.
- **plot-check** / **physics-check:** validation on new artefacts (or **results-check** for both).
- **vlm-figure-audit:** print/layout; use on compiled PDF pages.
- **paper-writing-workflow:** compile only when on-disk figures and manifest agree ([paper-writing](../paper-writing/)).
