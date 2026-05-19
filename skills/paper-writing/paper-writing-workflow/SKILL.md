---
name: paper-writing-workflow
description: >-
  End-to-end research paper workflow: plan the narrative, draft IMRaD sections,
  produce figure assets, compile LaTeX to PDF, and debug layout by visually
  inspecting output (VLM). Use when starting, editing, or submitting a manuscript.
---

# Paper writing workflow

**Deliverable:** a reproducible manuscript PDF whose **message**, **figures**, and
**text** agree. Figures are project-generated PDF assets, not chat screenshots.

**References (optional, local):** Chamba, Knapen & Black (2022), Papers I–II —
place `paper_plan.pdf` and `paper_writing.pdf` in repo root `ref_papers/` (gitignored;
see `ref_papers/README.md`). Read before a major draft if available.

## Principles

1. **Think before you write** — define message, gap, and story before opening the
   Introduction (Paper I, Sect. 2.1). Methodology alone is not the story.
2. **Audience** — professionals in the field, not necessarily experts in your
   sub-field. Explain methods and tools you use; avoid jargon *and* stating the
   obvious (Paper I, Sect. 2.5).
3. **Reproducibility** — enough detail that results can be judged and reproduced.
   Never "we reduced the data in the standard way"; cite the procedure or spell
   out steps (Paper I, Sect. 2.5; Paper II, Sect. 2.6).
4. **Figures early** — place figures/tables in the outline; draft captions before
   polishing body text (Paper I step 4; Paper II, Sect. 2.3).
5. **IMRaD + hourglass** — broad intro → narrow methods/results → broad discussion
   (Paper II, Sect. 2.4).
6. **Compile + debug by looking** — **paper-layout-review**, **vlm-figure-audit**;
   fix sources and recompile; do not paste LaTeX in chat as the primary fix.
7. **Prose** → **manuscript-writing-style**; plots → **scientific-plotting**;
   provenance → **research-figure-manifest**.

## Literature review (before drafting)

For each paper you skim, ask (Paper I, Sect. 2.1):

- Why am I reading this? What question does it answer for my project?
- Why did the authors write it? (title + abstract first)
- What story do the **figures and captions** tell?
- Are the conclusions supported by the evidence?
- What use is this paper to me — deep read or citation only?

Take notes in your own words; do not copy-paste into the draft (plagiarism risk,
Paper I, Sect. 2.4).

## Planning sequence (ten steps, Paper I Sect. 2.3)

1. Define **message** and story (critical thinking + literature).
2. Draft **title** and **abstract** (~150 words, whole paper in miniature).
3. **Outline** — words, bullets, or flow chart (match your thinking style; Paper I
   Sect. 2.2: visual vs verbal planners both valid).
4. Place **figures/tables**; draft **captions**.
5. Paragraph-level notes per section.
6. **First draft** — often data/methods first, Discussion last.
7. Track **citations** as you draft; verify each citation supports your claim.
8. **Edit ruthlessly** — cut what does not serve the message (appendix ok).
9. **Polish** — co-author feedback; share early drafts; fresh-eyes pass after a break.
10. **Submit** when good enough or deadline-bound.

If a fact or figure is missing, **note it and keep writing**; fill later (Paper I).

## Data, code, and ethics (Paper I Sect. 2.3.2)

- Publish data and code with the paper when possible (CDS, Zenodo, Dryad, Figshare).
- Do not rely on personal or institute URLs alone.
- License software explicitly if you release it.
- Acknowledge archives, pipelines, and funding in Acknowledgements (Paper II, Sect. 2.10).

## Build loop (after drafting exists)

1. Update plot scripts or `.tex` in the repo.
2. Regenerate figure PDFs; **results-check** then **vlm-figure-audit** each asset.
3. Update **research-figure-manifest** rows.
4. Compile; **paper-layout-review** on affected pages (iterative).
5. Record validator status in the project manifest if one exists.

## Do not

- Ship without visually inspecting the compiled PDF near final layout.
- Treat "compiles without error" as sufficient.
- Patch unreadable figures only in LaTeX; regenerate the asset.
- Start the Introduction before message + figure plan exist.
- Dump LaTeX or plotting code in chat instead of editing project files.

## Integration

| Skill | Role |
|-------|------|
| **manuscript-writing-style** | IMRaD text, tone, captions, English mechanics |
| **scientific-plotting** | Vector PDF at column width; colour-blind-safe design |
| **results-check** | Numeric + visual completeness |
| **vlm-figure-audit** | Figure/table content QA |
| **paper-layout-review** | Iterative float/equation clash fix |
| **research-figure-manifest** | Provenance and validator status |
