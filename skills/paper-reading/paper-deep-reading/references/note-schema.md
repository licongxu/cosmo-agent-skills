# Research note schema

The structure a `paper-deep-reading` note follows. Keep section headings;
drop a section only when it is genuinely `N/A` (note that explicitly). Default
language English; preserve original technical terms in parentheses where useful.

````markdown
# 【VENUE'YEAR】Paper Title

## Metadata
- **Authors:** …
- **Venue / Year:** … (`TBD` if unknown)
- **Paper:** <url>   **Code:** <url|none>   **Data/Artifact:** <url|none>
- **Scope / Subfield:** narrow research lane (not the broad field)
- **Tags:** comma-separated topic tags
- **Source accessed:** <how you read it — full PDF / abstract page / abstract-only>
- **Status:** TODO | reading | DONE

## TL;DR
2–4 sentences: the problem, the idea, and the headline result. Neutral.

## Critic's verdict
Short and sharp — one tight paragraph or 2–3 bullets. A hard, fact-grounded
judgment on the paper's real value, biggest weakness, likely overclaim, or most
fragile assumption. Must be meaningfully harder-hitting than the TL;DR; if it
could pass as a neutral summary, rewrite it. No invented defects; don't state
uncertain criticism as fact.

## Motivation & Basic Idea
The most fundamental reason this paper exists (the real gap, not surface
framing) and the simplest idea the method is built on.

## Background
Concise — only the chain *background → problem → gap*. Not a textbook section.

## Assumptions & Scope   *(optional — `N/A` if assumptions don't materially
affect correctness/validity/applicability)*
The assumptions, threat model, or scope conditions that determine whether the
result is meaningful.

## Method
How the basic idea becomes the concrete method. Ground in the paper's text /
related work / ablations / constraints. Preserve key notation, equations, and
algorithms. Label any reconstructed logic as **(inference)**.

## Evidence artifacts
The figures, tables, equations, algorithms, definitions that carry the main
claims. For each: *what claim is it evidence for?* (not just appearance).

## Evaluation
Experiment idea, metrics, results. Add dataset scale / baselines / key figures
only when needed to understand the result. Note whether the experiments actually
test the central claim.

## Prior work & novelty
Closest prior work and the claimed delta. Classify the novelty:
method / setting / data / finding. Cite recent/follow-up sources if impact is
discussed (search in-turn; never from memory).

## Strengths
What the paper does well — grounded in its evidence.

## Limitations
Concrete weaknesses (weak baseline, narrow data, missing ablation, unstated
assumption, reproducibility gap, external-validity limit, …). Separate *what the
paper shows* from *what you conclude*.

## My Takeaways
What you, the reader, take from it — including disagreements with the authors.

## Connections & open questions
Links to prior/future papers; questions worth revisiting; reproduction notes.
````

## Rules

- Mark unverifiable metadata `Unknown`/`TBD`; never invent.
- Keep the authors' claims separate from your analysis throughout.
- The evidence trail must be traceable: every headline claim ties back to a
  figure/table/metric/ablation named in the note.
- Critic's verdict ≠ TL;DR. If they read alike, the verdict is too soft.
