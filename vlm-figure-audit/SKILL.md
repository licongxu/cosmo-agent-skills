---
name: vlm-figure-audit
description: >-
  Uses vision (VLM) to audit figures, tables, and layout in manuscript PDFs before
  submission. Primary debug path for publication quality, float clashes, and
  legibility. Use when creating plots, editing papers, recompiling PDFs, or when
  the user mentions visual QA or figure validation.
---

# VLM figure and layout audit

**Principle:** look at the output. Figures, tables, and most layout problems are
found by opening the image or PDF with a vision-capable tool, not by memorizing
manuscript markup recipes. Do not fix layout by quoting LaTeX or plotting snippets
in chat; change the source (plot script or manuscript text) and re-export or
recompile, then look again.

**Completeness:** VLMs often approve curves that look smooth but omit chunks of data.
For line plots, scatter, and error bars, run the data-completeness items below and,
when possible, **results-check** (numeric point counts) before `OK`.

## When to run

- After each new or updated figure file.
- After recompiling the paper PDF when figures, tables, or captions changed.
- Before citing a figure or table number in the abstract or main conclusions.

## What to open

- Standalone figure PDF or PNG at roughly **final printed width**.
- Relevant **pages of the compiled manuscript PDF** (full column or spread) when
  checking tables, float placement, or figure–text interaction.

## Visual checklist

### Figures

- Labels, ticks, legend, colorbar, and panel letters readable without zooming.
- No clipped or overlapping text; line and marker weights visible in print.
- Vector-sharp lines (not a blurry screenshot).
- Multi-panel: consistent font sizes; fair comparison scaling when required.
- Matches caption (units, panels, method version).

**Data completeness (curves and scatter — required):**

- Trace each legend entry: confirm a visible line/markers for every named series.
- Scan the full x-axis range: gaps, early line termination, or thinning scatter where
  density should be uniform.
- Compare panels that should show the same domain: no panel missing a segment others have.
- Histograms / binned plots: suspicious empty bins or cutoffs inside the stated range.
- If the caption implies full coverage ("all bins", "full sample", sample size N), the
  figure must support it; otherwise `WARN` or `BLOCKING`, not `OK`.
- When source arrays are available, defer final `OK` to **results-check** Step 1b.

### Tables

- Headers and numbers readable; columns not crushed together.
- Table not overlapping body text or floating in a confusing gap.
- Content aligns with caption and in-text claims.

### Page layout (from compiled PDF)

- No obvious table–text or figure–text collision.
- No large empty blocks that suggest a stuck float, unless intentional.
- Figure and table order readable relative to where they are first mentioned.

Optional: spot-check that headline numbers in the caption match the plot or table.

## Verdict

End with exactly one of:

- `OK: <one-line summary>`
- `WARN: <concern>; <suggested fix>`
- `BLOCKING: <reason>; <must fix before paper use>`

Do not ship while `BLOCKING` is unresolved. Typical blocks: never visually inspected,
unreadable text, wrong asset version, table or figure rammed into unrelated prose,
**missing datapoints or series** (gap in curve, legend without trace, numeric count
mismatch vs caption).
