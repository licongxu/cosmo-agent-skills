# Research iteration (non-stop loop)

You are continuing work in the **current project** (the directory where Claude Code was launched). Keep all edits inside the project tree unless the human explicitly widened permissions.

Run this checklist **in order**. Do not skip steps. Record findings briefly in `docs/NOTES.md` (create the file if needed).

---

## 1. Verify science and reasoning

- Re-read your latest results, calculations, and conclusions.
- For each major claim, confirm it follows from the data or equations shown (no hand-waving).
- Check units, conventions, and domain assumptions (use installed **cosmo-agent-skills** / `.claude/skills/` as needed).
- Flag anything under-justified; fix or re-derive before moving on.

## 2. Verify code quality and internal consistency

- Review code you changed or rely on: logic bugs, off-by-one errors, wrong array shapes, stale paths, silent failures.
- Run relevant tests or minimal reproduction scripts; if none exist, add a small check and run it.
- Stress-test consistency: inputs ↔ outputs, config ↔ plots, catalogues ↔ figures, scripts ↔ saved files must agree.
- Fix inconsistencies immediately; do not leave known bugs for “later”.

## 3. Verify figures (VLM + numeric checks)

For **every plot** you produced or that supports a conclusion:

- Apply **vlm-figure-audit**, **plot-check**, **physics-check**, and **scientific-plotting** (plugin or project skills).
- Visually inspect at print-like size: missing points, clipped axes, overlapping labels, broken legends, wrong colours, empty panels.
- Confirm publication quality: vector PDF where appropriate, readable fonts, LaTeX-style math in labels when needed, consistent styling across figures.
- Confirm physics: each curve/feature is interpretable; units and axis labels match the computation; no accidental linear/log mix-ups.
- Cross-check plotted arrays against source data (spot-check extrema, integrals, or key bins).

If any figure fails, regenerate or fix before proceeding.

---

## 4. If everything passes — innovate and implement

Only when sections 1–3 are satisfied (or you have fixed all issues found):

- Brainstorm **one or more novel directions** that are not obvious rehashes of what you already did.
- Pick the highest-value idea and **implement it in this repo** (code, plot, or documented experiment plan with a runnable stub).
- Leave a short note in `docs/NOTES.md`: what you checked, what you changed, and what to do next iteration.

---

## 5. Loop discipline

- Do not declare the project “finished” unless the human has run `/loop-off`.
- End this turn with a concise status: checks done, issues fixed, new work started.
- Prefer small, verifiable steps over large unvalidated refactors.
