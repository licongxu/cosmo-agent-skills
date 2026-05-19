---
name: physics-check
description: >-
  Numerical correctness check on saved result arrays (npz, HDF5, torch, etc.).
  Use after plot-check or when validating metrics without a new figure. Domain
  laws, bounds, and thresholds live in the project's CLAUDE.md, not here.
---

# Physics check

Read the **numbers** behind a figure or analysis output. This skill does not
replace **plot-check** (visual + point-count completeness); run both when a script
just wrote a plot and arrays.

**Principle:** asserts on arrays catch wrong normalizations, sign errors, and silent
drops that VLMs miss.

## When to run

- After **plot-check** passes (or when only arrays/metrics changed, no new figure).
- Before citing quantitative claims in text or captions.
- When metrics jump by orders of magnitude or conservation seems violated.

## Step 1 — load and summarize

For each array file the result depends on:

```python
import numpy as np

d = np.load("path.npz")  # adapt for .npy, HDF5, torch, Parquet, etc.
print(sorted(d.files))
for k in d.files:
    a = np.asarray(d[k])
    print(k, a.shape, a.dtype,
          float(np.nanmin(a)), float(np.nanmax(a)),
          int(np.isfinite(a).all()))
```

## Step 2 — generic asserts

```python
assert np.isfinite(a).all(), f"{k}: non-finite values"
assert a.size > 0, f"{k}: empty array"
if a.ndim == 1 and k in ("x", "y", "ell", "bin_centers", "values"):
    n_bad = int(np.sum(~np.isfinite(a)))
    assert n_bad == 0, f"{k}: {n_bad} non-finite values will not plot"
if "ratio" in k or "residual" in k:
    assert np.nanmax(np.abs(a)) < 1e12, f"{k}: ratio/residual implausible"
```

## Step 3 — project asserts (required)

Apply rules from the repo's `CLAUDE.md` (or a project-local validator skill):

- Conservation, symmetries, sign constraints, normalization conventions.
- Physical bounds (e.g. densities ≥ 0, |δ| ≪ 1 where expected).
- Cross-series consistency (same grid, units, sample definition).

This shared skill **does not encode domain physics** — only generic numerics.

## Step 4 — provenance

- Sidecar metadata states units, normalization, seed when stochastic.
- Caption claims ("observed", "simulated", sample N) match arrays and config.
- Compared series share grid/units or document the transform → else `BLOCKING`.

## Step 5 — verdict

Exactly one of:

- `OK: <one-line summary with dominant numerical result>`
- `WARN: <summary>; <investigate>`
- `BLOCKING: <reason>; <fix>`

`BLOCKING` → do not ship in manuscript, slides, or external report until fixed.
Record in **research-figure-manifest** (`physics_check` field or combined validator).

## Integration

| Skill | Role |
|-------|------|
| **plot-check** | Visual + point-count pass first when a figure exists |
| **vlm-figure-audit** | Print QA after numeric pass |
| **research-figure-manifest** | Store verdict with run id |
| **results-check** | Orchestrates plot-check then physics-check |

Repo-local `physics-check` tables in `CLAUDE.md` extend Step 3; do not duplicate them here.
