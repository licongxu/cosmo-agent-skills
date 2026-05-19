---
name: manuscript-writing-style
description: >-
  Style and structure for research manuscript text: IMRaD, hourglass narrative,
  formal tone, topic sentences, reproducible Methods, captions that tell the story.
  Use when drafting or editing titles, abstracts, sections, captions, or reports.
---

# Manuscript writing style

Guidance from Chamba, Knapen & Black (2022), Papers I–II (optional local PDFs
in repo root `ref_papers/`, gitignored).
Applies to `.tex` body text, abstracts, and captions.

## Narrative structure

- **One message** — every section advances the story from planning (Paper I).
  Cut prose that does not serve it.
- **IMRaD:** Introduction → Methods/Data → Results → Discussion → Conclusion.
  Do not mix roles (no new background in Discussion; no results in Methods).
- **Hourglass** (Paper II, Sect. 2.4): broad intro → narrow methods/results →
  broad discussion/conclusion.

### Section checklists (Paper II)

| Section | Job |
|---------|-----|
| **Title** | ~15 words; accurate; keywords; main result if possible; no vague "On…"/"Towards…"; no jokes |
| **Abstract** | Scene → problem → method → results → conclusion → optional outlook (~150 words) |
| **Introduction** | Big picture → sub-topic → literature gap → your aim → what you did → optional section map |
| **Methods** | What data/tools and **why** they meet your goals; enough to judge and **reproduce**; state caveats honestly; past active ("we used…"); no results here |
| **Results** | What you found; figures drive structure; foreshadow main points; compare (i) "Figure 3 shows…" vs (ii) "To show how x relates to y, Figure 3 shows…" — prefer (ii) |
| **Discussion** | See seven-point list below; limitations explicit |
| **Conclusions** | Separate section (or "Discussion and Conclusions"); many readers skip here — summarise why/how/what; refer to key figures; **strong final sentence** with implication |

### Discussion — seven aspects (Paper II, Sect. 2.8)

Work through in order, widening the hourglass:

1. Repeat why you did the study.
2. Return to the main question from the abstract; answer it.
3. Show how the answer is supported by data, models, figures.
4. Compare to literature — agreement and disagreement.
5. Explain disagreement or alternatives without losing the main message.
6. Wider implications, applications, recommendations.
7. What future work would clarify or advance the field.

## Formal tone (Paper I, Sect. 2.5)

- **Inform**, do not entertain. Objective, neutral, professional.
- **No contractions** (write "do not", not "don't").
- **No imperative to the reader** ("note that…" → "the data are…").
- **No colloquialisms, slang, or pop-culture references.**
- Criticise prior work professionally, not personally.
- **Inclusive language:** avoid violent metaphors common in astrophysics when
  alternatives exist (Paper I, Sect. 2.5.1); define non-standard terms on first use.

## Paragraphs and sentences (Paper II, Sect. 3.1–3.3)

- **Topic sentence first** — main idea in sentence 1, then evidence (~3–7 sentences).
- **One idea per paragraph**; split half-page blocks.
- **Link sentences** — repeat a key noun at the start of the next sentence; new
  information at the end of the sentence (English convention).
- **Sign-post words:** "for example", "first/next/finally", "however", "in contrast",
  "consequently", "similarly".
- **Length:** average 18–32 words; limit long "which/that" chains (~1 in 3–4).
- **Subject–verb–object**; keep subject and verb close.
- **Active voice** when possible ("we measured…"; also "Figure 1 shows…",
  "this paper presents…").
- **Tenses:** present for facts and for referring to figures in this paper; **past**
  for what you or others did in the study; present perfect for recent work with
  current relevance ("algorithms have been proposed…").
- **Dangling modifiers** — place phrases next to what they modify (Paper II, Sect. 3.4).
- **Ambiguous "this"** — follow with a noun ("this evolution", not bare "this").
- **Phrasal verbs** — avoid in formal prose ("investigate" not "look into";
  "discuss" not "talk about"; Paper II, Sect. 3.10).
- **Data** is usually plural; **amount** for uncountable quantities, **number** for
  countable objects (Paper II, Sect. 3.6, 3.9).

Before heavy notation: one plain sentence on what the quantity is and why it matters.

## Captions and figures (text side, Paper II Sect. 2.3)

- Captions: full sentences; explain every panel element; units, sample size, method id.
- Figures should **tell the story** — many readers see only title, abstract, figures.
- End captions with a **one-sentence takeaway** when helpful.
- Consistent typeface, text size, and colour coding across figures in one paper.
- Text and captions must match **current** figure files and run ids.
- Abstract/conclusion numbers must trace to the same artifacts as figures.

Visual export (vector PDF, colour-blind-safe line styles + colour) → **scientific-plotting**.

## Clarity and honesty

- State caveats and limitations; do not bury serious doubts only in an appendix.
- Prefer concrete ids (`method v2`, `N=512`) over vague "the model".
- Cite claims; read cited papers — verify they support your statement.
- No hype without numbers.

## No em dashes

Do **not** use em dashes (U+2014) in manuscript text, captions, or user-facing reports.

Use comma, parentheses, colon, separate sentences, or en dash for numeric ranges
(e.g. 10--20 samples). Hyphenate compound modifiers (`cross-validated`).

## Self-check before submitting text

1. Search for `—` and replace every instance.
2. Skimmer test: result clear from title + abstract + figure captions alone?
3. Methods: could a colleague reproduce the analysis from this section?
4. Discussion: all seven aspects addressed; limitations stated?
5. Conclusions: strong final sentence, not only "more research is needed"?
6. Formal tone: no contractions, phrasal verbs, or imperative-to-reader?
7. Numbers in abstract/conclusion match manifest-backed figures?

## Integration

- **paper-writing-workflow:** planning, literature review, compile/VLM loop.
- **scientific-plotting** / **vlm-figure-audit:** visual side of figures.
- **paper-layout-review:** layout only — not wording.
