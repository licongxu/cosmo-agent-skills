---
name: results-check
description: >-
  General visual (VLM) and numerical correctness check for any research artefact
  (figure plus saved arrays). Use proactively after every script that writes a
  plot or a result file. Domain-specific thresholds and asserts live in the
  project's CLAUDE.md, not here.
---

# Results check

Inline validation after a script produces a figure or saved arrays — same
workflow as a dedicated validator agent, without spawning a sub-agent.

**Principle:** look at the output and read the numbers. Do not infer quality from
file size, timestamps, or log lines alone.

## When to run

- Right after any script writes a figure (`savefig`, export to PDF/PNG/SVG) or a
  result file (`np.savez`, `np.save`, `torch.save`, `pickle`, Parquet, HDF5, etc.).
- Before any manuscript section, slide, or report cites the figure.
- Whenever a plot or metric looks suspicious (discontinuities, empty panels,
  saturated colors, orders-of-magnitude jumps).

## Protocol

### Step 1 — visual inspection (VLM)

Open the figure with the **Read** tool (PNG/PDF at roughly final print size).
Do not skip this step.

Verify:

- Axis labels, units, and tick formatting are present and match the caption.
- Scales are appropriate (linear vs log stated or obvious; no misleading truncation).
- Dynamic range is plausible for the quantity shown (no flat lines, no all-NaN panels,
  no obvious saturation unless expected).
- Multi-panel layouts: consistent fonts, comparable scaling when panels are compared.
- Legend readable; color choices distinguish series; no clipped tick labels or text overlap.
- For model vs data / truth vs estimate: panels are labeled and visually comparable.
- No obvious rendering artefacts (ringing, block boundaries, dead pixels, moiré from
  wrong resampling, watermarking from debug overlays left on).

Project-specific visual ranges (expected value bands, reference curves) belong in the
repo's `CLAUDE.md` or a project skill — apply those after this generic pass.

### Step 2 — numerical checks on saved arrays

For each array file the figure depends on, load and summarize:

```python
import numpy as np

d = np.load("path.npz")  # or appropriate loader for .npy, HDF5, torch, etc.
print(sorted(d.files))   # list keys / datasets
for k in d.files:
    a = np.asarray(d[k])
    print(k, a.shape, a.dtype,
          float(np.nanmin(a)), float(np.nanmax(a)),
          int(np.isfinite(a).all()))
```

Then apply **generic** asserts:

```python
assert np.isfinite(a).all(), f"{k}: non-finite values"
# Empty or degenerate outputs:
assert a.size > 0, f"{k}: empty array"
# If the figure is a ratio or residual, guard divide-by-zero blow-ups:
if "ratio" in k or "residual" in k:
    assert np.nanmax(np.abs(a)) < 1e12, f"{k}: ratio/residual magnitude implausible"
```

Then apply **project asserts** documented in `CLAUDE.md` (conservation laws, sign
constraints, normalization, symmetry, bounds on physical parameters, etc.). This
skill intentionally does not encode domain physics.

**Provenance checks (generic):**

- Saved metadata or sidecar JSON states units, normalization, and random seed when
  stochastic.
- If the caption or manifest claims "noisy", "observed", or "simulated" data, the
  saved arrays and run config must match that claim; mismatch → `BLOCKING`.
- If two series are compared, confirm they share the same grid, units, and sample
  definition (or document the transform applied).

### Step 3 — manifest / run record cross-check

Open the project's run manifest or experiment log (path defined in `CLAUDE.md`).
Confirm at minimum:

| Field | Check |
|-------|--------|
| `git_hash` or equivalent | Set and matches `git rev-parse HEAD` when reproducibility matters |
| `data_paths` | Point at real inputs used, not placeholders |
| `seed` | Set for stochastic runs |
| `script` / `command` | Matches what produced the artefact |
| `validator` | Prior verdict recorded if re-auditing |

Add domain fields in the project manifest schema; do not invent paths here.

### Step 4 — verdict

End with exactly one of:

- `OK: <one-line summary with the dominant numerical result>`
- `WARN: <one-line summary>; <what to investigate>`
- `BLOCKING: <one-line reason>; <fix>`

A `BLOCKING` figure must not enter the manuscript, slides, or external report until
regenerated or corrected. Record the verdict in the figure's source comment, manifest
row, or **research-figure-manifest** entry for later auditing.

## Integration

- **vlm-figure-audit:** layout and print QA on the compiled PDF; run after this skill
  passes for paper-bound figures.
- **research-figure-manifest:** store validator status and run id per figure.
- **scientific-plotting:** export settings before running Step 1.

Domain-specific validator agents or project skills (e.g. a repo-local `physics-check`)
extend this protocol with asserts and thresholds; keep those in the project, not in
this shared skill.
