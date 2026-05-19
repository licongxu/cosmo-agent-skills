---
name: scientific-plotting
description: >-
  Publication-quality plots for LaTeX papers: vector PDF output, PNG at dpi=300,
  label and tick font sizes readable at final column width. Use when generating
  or updating manuscript figures, or when plot text is too small or clipped in the PDF.
---

# Scientific plotting

**Goal:** figures that look correct in the **compiled paper PDF**, not on a large
monitor. Do not teach or paste plotting code in chat; change the project's plot
script and re-export.

## What matters

1. **Vector PDF** saved under the manuscript figures directory, with a stable
   filename the paper already references. Prefer PDF for manuscript figures.
2. **PNG exports: `dpi=300` always** — for slides, previews, VLM audit, or when
   raster is required. Do not rely on matplotlib's default (~100 dpi); text and
   lines will look soft or pixelated when zoomed or printed.

   ```python
   fig.savefig("figure.pdf")                    # vector — preferred for LaTeX
   fig.savefig("figure.png", dpi=300)           # raster — always 300
   plt.savefig("figure.png", dpi=300, bbox_inches="tight")
   ```

3. **Font sizes** chosen for the width the figure will occupy in the PDF:
   axis labels, ticks, legend, colorbar, and panel letters should read as roughly
   7--9 pt in the printed page. Defaults are usually too small after scaling.
4. **Figure dimensions** set in the plotting step for that width, not oversized
   on screen and shrunk only in the manuscript.
5. **No clipped or overlapping text** at the edges; legend must not hide the data.

Secondary styling: distinguish series with **line/marker style and colour**, not
colour alone (colour-vision deficiency affects up to ~10% of readers; Paper II,
Sect. 2.3). Other styling unless the project specifies it.

## How to verify

After export, run **vlm-figure-audit** on the figure file, or on the relevant
page of the compiled PDF at approximately final size. If labels fail the visual
check, adjust sizes or layout in the plot script and regenerate. Do not patch
readability in the manuscript source with ad hoc scaling tricks.

## Workflow

1. Regenerate the figure asset (PDF and/or PNG at `dpi=300`).
2. VLM audit at publication size.
3. Rebuild the paper PDF and VLM-check the embedded result if layout changed.

Domain-specific units, axis ranges, and science checks belong in the project, not here.
