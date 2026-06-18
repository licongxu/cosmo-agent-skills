---
name: paper-deep-reading
description: >-
  Deep-read an academic paper and produce a durable, critical research note —
  not a loose summary. Use when given a paper title, DOI, arXiv ID,
  publisher/PDF/GitHub URL, or local PDF, or when asked to read closely,
  summarize, extract contributions, analyze experiments, critique, compare to
  related work, reproduce results, or maintain a paper-reading repository index.
  Works across fields (astro/physics, ML, bio, security, …); examples lean
  astro-ph but the workflow is general.
---

# Paper deep reading

Turn a paper into a **durable, falsifiable note**: factually grounded, explicit
about uncertainty, and connected to the reader's existing literature. Default
output language is English (preserve original technical terms in parentheses
when translation loses meaning); match the surrounding repo if its notes use
another language.

**Core principle:** ground every claim in the paper's actual text. Separate
*what the paper demonstrates* from *what you conclude*. Mark anything you cannot
verify as `Unknown`/`TBD`/`inference` — never invent venue, year, code, dataset,
numbers, or claims.

The full note format lives in
[`references/note-schema.md`](references/note-schema.md). A worked example is in
[`references/example-note.md`](references/example-note.md). Read the schema
before writing or revising a note file.

## Step 1 — Resolve the source (don't read what you can't cite)

Get the canonical paper before reading. Use whichever applies:

- **Local PDF** → read it directly.
- **arXiv ID / DOI / URL** → fetch it. Two verified paths in this environment:
  - Metadata via the valency MCP (fast, structured), e.g. for `2006.12566`:
    `get_paper_by_id(paper_id="2006.12566", source="arxiv")` returns title,
    authors, categories, date, license, URL, citation count.
  - Full abstract / page via `WebFetch https://arxiv.org/abs/<id>` (or the
    publisher/DOI URL). For the PDF text use `https://arxiv.org/pdf/<id>`.
- **Title only** → find the official source first. Search the valency corpus
  (`search_by_title`, optionally with `author=`), or the web / ADS
  (`https://ui.adsabs.harvard.edu`). Confirm you have the right paper (authors +
  year + venue) before reading.
- **Inside a paper-reading repo** → before creating anything, grep `README.md`,
  `notes/`, `papers/`, `literature/` for an existing note or local copy. Prefer
  editing the existing note over making a duplicate.

Record the source URL and how you accessed it in the note. If access fails and
you only have the abstract, **say so explicitly** — an abstract-only note is
labelled as such, never passed off as a full read.

## Step 2 — Metadata

Title, authors, venue, year, paper URL, code URL, dataset/artifact URL,
scope/subfield (the narrow research lane, not the broad field), topic tags,
reading status. Leave unknowns as `TBD`.

## Step 3 — Read in three passes

This merges the structured reading of Cooke et al. (2020),
[arXiv:2006.12566](https://arxiv.org/abs/2006.12566), with a deeper critical
extraction. Papers follow a standard skeleton (intro → data/method →
results/discussion → conclusions); use it to navigate non-linearly.

- **Pass 1 — frame it.** Abstract, introduction, conclusions. Nail down: *what
  mystery/controversy is being addressed, with what objects/system?* The real
  gap usually sits in the last intro paragraph ("Our work addresses this
  by …"). Distinguish the genuine pain point / missing capability / broken
  assumption from surface motivation. You should be able to say plainly: "This
  paper investigates **[specific problem]** with **[these objects/data]**."
- **Pass 2 — mechanism.** Method, data/sample selection, assumptions,
  algorithms, system design, definitions. Extract *how* they address it ("they
  used **[instrument/method]** to measure **[quantity]**, which answers the
  problem"). Reconstruct how the basic idea follows from the motivation and
  becomes the concrete method. Preserve notation; check equations/algorithms for
  variable meaning, ranges, missing operators, consistency with the text.
- **Pass 3 — evidence.** Results, figures, tables, ablations, case studies,
  limitations, related work. Ask: *what did they find / not find, and why is it
  new?* Do the experiments actually test the claim? The most-discussed figure is
  usually the central result — read it axes-first, then legend, then meaning.

## Step 4 — Evidence artifacts

Inventory the figures, tables, equations, algorithms, and definitions that carry
the main claims (all of them if the user wants exhaustive notes). For each, state
*what claim it is evidence for*, not just what it looks like. Preserve central
equations and definitions verbatim enough to be re-derivable.

## Step 5 — Position against prior work

Identify the closest prior work and the paper's claimed delta. Distinguish
**method** novelty, **setting** novelty, **data** novelty, and **finding**
novelty. If the delta or impact depends on recent/follow-up work, search current
sources **in the same turn and cite them** — never cite adoption or impact from
memory.

## Step 6 — Critical synthesis (internal pass)

An internal analysis pass — do **not** add a "critical review" section to the
note. Ask: is it convincing, useful, reproducible, well-scoped? Who benefits,
what can go wrong, what does it cost to reproduce/deploy, does the evaluation
actually test the claim, and does the method really follow from the stated
motivation or is the motivation post-hoc? Make critique **concrete and specific**:
weak/missing baseline, narrow dataset, missing ablation, fragile labels, data
leakage, unstated assumption, unrealistic model of the system, selection effect,
under-powered statistics, reproducibility gap, external-validity limit. Fold the
verdict into the note's `Strengths`, `Limitations`, and `My Takeaways`.

## Step 7 — Write the note

Follow [`references/note-schema.md`](references/note-schema.md). Key emphases:

- **Motivation & Basic Idea** — the most fundamental reason the paper exists and
  the simplest idea the method is built on. Give this real attention.
- **Background** — concise: only the chain *background → problem → gap*. Not a
  textbook section.
- **Assumptions & Scope** — optional; include when assumptions materially affect
  correctness, validity, or applicability (often decisive in security/empirical
  work). Otherwise `N/A`.
- **Method** — analyze how the basic idea becomes the concrete method, grounded
  in the text/related work/ablations; label inferred logic as inference.
- **Evaluation** — focus on experiment idea, metrics, and results; add dataset
  scale / baselines / key figures only when needed to understand the result.
- **Critic's verdict** — right after the TL;DR, a short, sharp, fact-grounded
  judgment (one tight paragraph or 2–3 bullets) on the paper's real value,
  biggest weakness, likely overclaim, or most fragile assumption. It must be
  **meaningfully harder-hitting than the TL;DR** — if it reads like a neutral
  summary, rewrite it. Never invent defects or state uncertain criticism as fact.
- End with connections to prior/future papers and open questions worth revisiting.

## Step 8 — Maintain the repo index (inside a paper-reading repo)

If `README.md` has a venue/year index, update the right entry; flip `TODO →
DONE` only once the note file exists; link the entry to the note and keep the
paper URL reachable. Unknown venue/year → an `Unknown / TBD` section, not a guess.

## Step 9 — Sync to Git (inside a Git-backed repo)

After note + index are updated: `git status --short`; stage **only** files this
task touched (the note, `README.md`, intentional assets) — never unrelated user
changes; commit `Add paper note: <short title>` (or `Update paper note: …` for a
revision); `git push`. No empty commits. If push fails, report the error and
leave the local commit intact.

## Output files

When saving notes in the current repo:

- Default location: `notes/` (or the repo's existing notes directory). Group by
  subfield if the repo already does (e.g. `notes/cosmology/`).
- Filename: `【VENUE'YEAR】short-title.md`, e.g. `【ApJ'2019】cooke-galaxies.md`;
  unknown venue/year → `【TBD】short-title.md`.
- Title uses the same prefix: `# 【VENUE'YEAR】Paper Title`.
- Prefer editing an existing note over creating a duplicate.

## Quality bar

- No abstract-only summaries unless the paper is genuinely inaccessible — and
  say so when that happens.
- The Critic's verdict must be sharper than the TL;DR.
- Don't overclaim novelty — frame it as the paper does, compare to related work.
- Don't omit decisive assumptions.
- Keep the evidence trail traceable: figures/tables/metrics/ablations → the
  claims they support.
- Prefer specific critique over generic praise or hedging.

## Gotchas (this environment)

- **valency vs WebFetch:** `get_paper_by_id` gives clean structured metadata but
  not full body text; `WebFetch` on `arxiv.org/abs/<id>` returns the abstract
  page, `arxiv.org/pdf/<id>` the full text. Use valency for metadata, fetch the
  PDF/abs for content. Both were verified against `2006.12566`.
- **arXiv math in abstracts** comes back as LaTeX (e.g. `$\times 10^N$`) — keep
  it as-is in the note rather than mangling it into prose.
- **`citation_count: 0`** from valency can mean "genuinely uncited" *or* "cache
  cold / not on the citation source" — don't report impact from this field
  alone; cross-check the web if impact matters.
- **WebFetch cross-host redirects** (e.g. DOI → publisher) are returned, not
  followed — call again with the redirect URL.
