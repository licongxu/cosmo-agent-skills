---
name: scientific-plotting
description: >-
  Publication-quality plots for LaTeX papers: vector PDF output, label and tick
  font sizes readable at final column width. Use when generating or updating
  manuscript figures, or when plot text is too small or clipped in the PDF.
---

# Scientific plotting

**Goal:** figures that look correct in the **compiled paper PDF**, not on a large
monitor. Do not teach or paste plotting code in chat; change the project's plot
script and re-export.

## What matters

1. **Vector PDF** saved under the manuscript figures directory, with a stable
   filename the paper already references.
2. **Font sizes** chosen for the width the figure will occupy in the PDF:
   axis labels, ticks, legend, colorbar, and panel letters should read as roughly
   7--9 pt in the printed page. Defaults are usually too small after scaling.
3. **Figure dimensions** set in the plotting step for that width, not oversized
   on screen and shrunk only in the manuscript.
4. **No clipped or overlapping text** at the edges; legend must not hide the data.

Secondary styling (colors, spines, grid) is optional unless the project specifies it.

## How to verify

After export, run **vlm-figure-audit** on the figure file, or on the relevant
page of the compiled PDF at approximately final size. If labels fail the visual
check, adjust sizes or layout in the plot script and regenerate. Do not patch
readability in the manuscript source with ad hoc scaling tricks.

## Workflow

1. Regenerate the figure asset (PDF).
2. VLM audit at publication size.
3. Rebuild the paper PDF and VLM-check the embedded result if layout changed.

Domain-specific units, axis ranges, and science checks belong in the project, not here.
