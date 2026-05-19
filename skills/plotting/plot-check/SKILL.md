---
name: plot-check
description: >-
  Visual (VLM) and array-completeness check for plots and figure files. Use
  proactively after savefig or export; before citing a figure in a paper or report.
  Axis styling and export settings → scientific-plotting; domain physics → physics-check.
---

# Plot check

Inspect the **figure file** and, when available, the **arrays** the plotting script
used. Do not infer quality from file size, timestamps, or log lines alone.

**VLM alone is not enough for curves and scatter plots.** A figure can look smooth
while regions, bins, or series are missing. Run Step 2 when numeric artefacts exist;
never mark `OK` on visuals only in that case.

## When to run

- Right after any script writes a figure (`savefig`, PDF/PNG/SVG export).
  **PNG:** always `dpi=300` (see **scientific-plotting**).
- Before a manuscript section, slide, or report cites the figure.
- When a plot looks suspicious (gaps, saturation, wrong panel count).

## Step 1 — visual inspection (VLM)

Open the figure with the **Read** tool (PNG/PDF at roughly final print size).

Verify:

- Axis labels, units, and tick formatting present and match the caption.
- Scales appropriate (linear vs log obvious; no misleading truncation).
- Dynamic range plausible (no flat lines, all-NaN panels, unexpected saturation).
- Multi-panel: consistent fonts; comparable scaling when panels are compared.
- Legend readable; series distinguishable; no clipped labels or text overlap.
- Model vs data panels labeled and visually comparable.
- No rendering artefacts (ringing, resampling moiré, debug overlays).

**Data completeness (VLM):** for every line, curve, scatter cloud, or error-bar series:

- **Gaps:** holes in curves; lines stopping before the axis ends; thinning scatter.
- **Truncation:** series ends early while x continues; sibling panels disagree on range.
- **Dropped series:** legend lists N curves but fewer than N visible traces.
- **Masking artefacts:** stairs, notches, flat segments where density is expected.
- **Histograms:** empty interior bins; jagged drops to zero vs stated binning.
- **Caption vs plot:** claims like "all", "full sample", or count N must be supported.

If incomplete or ambiguous → run Step 2. If arrays are unavailable, verdict is at
most `WARN` with "completeness not verified numerically".

Project-specific visual bands (reference curves, expected ranges) → repo `CLAUDE.md`.

## Step 2 — completeness vs arrays (required when data exists)

Load the arrays the plotting script used. **Count before concluding the VLM pass.**

```python
import numpy as np

x, y = np.asarray(x).ravel(), np.asarray(y).ravel()
assert x.size == y.size, "x and y length mismatch"
n_total = x.size
plottable = np.isfinite(x) & np.isfinite(y)
n_plotted = int(plottable.sum())
n_dropped = n_total - n_plotted

print(f"total={n_total} plottable={n_plotted} dropped(non-finite)={n_dropped}")
assert n_dropped == 0, f"{n_dropped} points dropped — check mask/NaN handling"
```

| Check | Fail when |
|-------|-----------|
| Expected count | Caption/manifest says N but `n_plotted < N` |
| Shared abscissa | Compared curves differ in `x` length or finite mask |
| NaNs | Non-finite values not documented in caption |
| Histogram | Occupied bins ≪ expected without explanation |
| 2D / image | Most pixels non-finite without stated mask |
| Replot spot-check | Re-plot `(x, y)` and diff against saved PNG if unsure |

Step 1 OK but Step 2 shows drops → `BLOCKING`. Scientific plot without arrays → `WARN`
unless user confirms completeness.

## Step 3 — manifest cross-check (when project has a run log)

Path from `CLAUDE.md`. Confirm `git_hash`, `data_paths`, `seed`, `script`/`command`
match what produced the figure.

## Step 4 — verdict

Exactly one of:

- `OK: <one-line summary>`
- `WARN: <summary>; <what to investigate>`
- `BLOCKING: <reason>; <fix>`

Record in **research-figure-manifest** or source comment. Then run **physics-check**
on saved arrays when they exist.

## Integration

| Skill | Role |
|-------|------|
| **scientific-plotting** | Export before Step 1 |
| **physics-check** | Numeric/domain asserts after plot looks complete |
| **vlm-figure-audit** | Print-size QA; defer final `OK` on curves until plot-check passes |
| **research-figure-manifest** | Store `plot_check` verdict |
| **paper-writing-workflow** | Manuscript build loop references this category |
