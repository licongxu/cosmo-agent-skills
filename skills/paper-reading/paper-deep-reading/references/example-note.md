# 【arXiv'2020】Astronomy Paper Seminar Participation Guide & Reading Walkthrough

> Worked example produced by the `paper-deep-reading` skill from the full text of
> [arXiv:2006.12566](https://arxiv.org/abs/2006.12566). Shows the schema applied
> to a real (non-research, methods/education) paper. A normal note would not
> carry this banner.

## Metadata
- **Authors:** Kevin C. Cooke, J. L. Connelly, K. M. Jones, Allison Kirkpatrick, E. A. C. Mills, Ian J. M. Crossfield
- **Venue / Year:** arXiv preprint (astro-ph.IM; physics.ed-ph), 2020 — no journal_ref / DOI (`TBD` whether refereed)
- **Paper:** https://arxiv.org/abs/2006.12566   **Code:** none   **Data/Artifact:** none
- **Scope / Subfield:** research training / reading methodology for astronomy students
- **Tags:** Education, Reading methodology, Journal club, ADS, arXiv, Reference management
- **Source accessed:** full text (user-provided) + metadata verified via valency `get_paper_by_id` and `WebFetch arxiv.org/abs/2006.12566`
- **Status:** DONE

## TL;DR
A short pedagogical guide that teaches early-career astronomers how to find,
read, and present papers efficiently. It covers discovery tools (ADS, arXiv,
Astrobites/AAS Nova), a non-linear reading method organized around three
questions — *what mystery is addressed, how, and what was found* — a recipe for
presenting a paper in journal club (figures axes-first), and reference-management
options (BibDesk, Zotero/Mendeley, Evernote).

## Critic's verdict
This is a friendly onboarding doc, not a result — and it should be read as one.
Its actual contribution is the compact three-question reading scaffold; the rest
(ADS/arXiv tutorials, tool lists) dates fast and is already covered by each
tool's own docs. It is explicitly astronomy- and US-centric (ADS, AAS Nova,
"never pay for a paper, that's the university's job"), assumes institutional
access, and offers no evidence that its method improves comprehension — it is
distilled experience, presented as advice, with zero figures and no evaluation.
Useful as a checklist; mistaking it for a rigorous study of how people read would
be the error.

## Motivation & Basic Idea
New students face an unbounded, ever-growing literature and feel they must read
papers cover-to-cover. The basic idea: reading is **non-linear and
goal-directed** — extract physical meaning by interrogating the paper with a
fixed set of questions, rather than absorbing every detail in written order.

## Background
Astronomy training relies on seminars/journal clubs where papers are discussed,
but students are rarely taught *how* to read or present efficiently → a practical
gap this guide fills for an undergrad/grad audience.

## Assumptions & Scope
Assumes the reader has university/institutional access (paywalls), works in
astronomy (ADS, astro-ph, AAS Nova), and reads English-language refereed
literature. These conditions limit transfer to other fields or unaffiliated
readers — material to whether the advice applies.

## Method
No formal method; the "method" is the prescribed reading and presentation
workflow:
1. **Triage** with the abstract (relevance test), or paper-summary sites
   (Astrobites, AAS Nova) when short on time.
2. **Read by three questions** (the core scaffold):
   - *What mystery/controversy?* — intro + conclusions; the gap is usually the
     penultimate intro paragraph.
   - *How addressed?* — sample selection + observations/derived quantities;
     focus on physical meaning (wavelength regime, photometry vs spectroscopy),
     not arcane instrument detail.
   - *What found / not found?* — discussion + conclusions; the most-discussed
     figure is the central result.
3. **Present** by restating the big picture → data/analysis → physical meaning of
   results → fit back to the original question; walk figures **axes → legend →
   meaning**.
4. **Manage** references with BibDesk (.bib/LaTeX), Zotero/Mendeley (PDF + bib),
   or Evernote (rich notes). *(inference: the three-question framing generalizes
   beyond astronomy, though the paper only claims it for astronomy.)*

## Evidence artifacts
None — "5 pages, 0 figures" (confirmed in valency `comments`). The guide's claims
are pedagogical assertions, not empirically supported artifacts. The recurring
fill-in-the-blank sentences ("This paper is investigating [problem] with
[objects]") are the closest thing to a reusable artifact.

## Evaluation
No evaluation. The guide does not test whether its method improves reading speed
or comprehension; its authority rests on the authors' and contributors' teaching
experience at the University of Kansas.

## Prior work & novelty
Novelty is **setting/packaging**, not method: it assembles widely-known practices
(skim intro/conclusions first, read figures critically, manage citations) into
one astronomy-specific onboarding document. No comparison to other reading guides
is made.

## Strengths
- Concrete, memorable scaffold (the three questions + fill-in-the-blank sentences).
- Practical, free-tool-focused, lowers the barrier for anxious beginners.
- Good figure-presentation discipline (axes-first) that transfers to talks.

## Limitations
- No evaluation; advice only.
- Astronomy/US/institution-bound; tool list will age.
- Says nothing about reading *theory/methods-heavy* or equation-dense papers,
  where "skip the details" advice breaks down.

## My Takeaways
The three-question scaffold is the durable core and maps cleanly onto this
skill's Pass-1/2/3 structure. "Read the most-discussed figure axes-first" is a
useful default for evidence extraction. The guide's lack of any evaluation is a
fair reminder that reading advice is craft, not science.

## Connections & open questions
- Pairs with this skill's three-pass reading and `paper-writing` skills.
- Open: does the three-question method hold for theory/simulation papers with no
  "objects observed"? How would the figure-first rule adapt to derivation-heavy
  work?
