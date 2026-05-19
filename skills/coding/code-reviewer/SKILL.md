---
name: code-reviewer
description: >-
  Review code changes against requirements and quality standards before merge.
  Use when dispatching a review subagent, after major features, before merging,
  or when the user asks for a code review. Requires reading the actual diff.
---

# Code reviewer

Senior code review: compare **implemented work** to **requirements/plan**, read the
**actual diff**, and catch issues before they cascade. Produce a written review
only — do not modify code unless the user explicitly asks you to fix findings.

**Core principle:** Review early, review often. Never approve code you did not read.

**Bar for merge:** **All** project tests pass, including edge-case and stress coverage
for changed behavior. "Happy path only" is not sufficient — hunt difficult inputs until
confidence is justified or gaps are filed as blocking issues.

Project-specific stacks, test commands, and domain rules live in that repo's
`CLAUDE.md` and `.claude/rules/` — apply them after this generic pass.

## When to run

**Mandatory:**
- After each task in a multi-step plan (before the next task)
- After a major feature or refactor
- Before merge to main

**Optional:**
- When stuck (fresh perspective)
- Before a large refactor (baseline check)
- After fixing a subtle bug

## Inputs (must be provided)

| Input | What to fill in |
|-------|-----------------|
| **Description** | Brief summary of what was built |
| **Plan / requirements** | Task text, plan file path, issue, or acceptance criteria |
| **Git range** | `BASE_SHA` … `HEAD_SHA`, or explicit file list if uncommitted |

```bash
git diff --stat {BASE_SHA}..{HEAD_SHA}
git diff {BASE_SHA}..{HEAD_SHA}
```

If work is uncommitted: `git diff` and `git diff --cached`, or review named paths.

## Review procedure

1. Read the **plan/requirements** first — know what "done" means.
2. Inspect **`git diff --stat`** then the **full diff**; open changed files for context
   (callers, tests, config) — not only hunks.
3. **Run the full test suite** the project documents (`pytest`, `npm test`, etc.).
   Re-run after any fix loop until **everything is green** before a `Yes` verdict.
4. **Stress-test changed behavior** — do not stop at the happy path (see below).
5. Check **plan alignment** before style nits.

## Stress testing and edge cases (required)

Treat untested or failing edge behavior as **bugs until proven otherwise**.

**Reviewer must:**
- Identify inputs/paths the change touches (empty, zero, NaN/Inf, max size, bad types,
  missing files, concurrent/retry, boundary indices, wrong shapes, permission errors).
- Check whether **tests exist** for those cases — if not, file **Important** or **Critical**
  (Critical when silent wrong output or crash in production is plausible).
- Run or propose concrete cases: e.g. `pytest path/to/test_foo.py -k edge`, minimal
  repro scripts, property/fuzz checks where the repo supports them.
- **Never** mark **Ready to merge: Yes** while any relevant test fails or while critical
  paths lack coverage you could reasonably expect in this codebase.

**Implementer must (before requesting review):**
- Add or extend tests for edge and failure modes introduced or affected by the diff.
- Run the **full** suite locally; fix failures in a loop until **all pass**.
- For numerical/research code: finiteness, shape mismatches, degenerate parameters,
  empty batches, and seed reproducibility where applicable.

**Difficult cases to consider (adapt to domain):**

| Category | Examples |
|----------|----------|
| Empty / minimal | `n=0`, empty list, single element, unset optional |
| Boundaries | off-by-one, max length, overflow, saturation |
| Invalid input | wrong type, out-of-range, malformed config |
| Failure modes | I/O error, timeout, partial write, OOM handling |
| Concurrency | race, double init, non-idempotent retry |
| Numerics | NaN, Inf, denormal, ill-conditioned, dtype mismatch |

If stress tests cannot be run (missing GPU, data, credentials), say so explicitly and
lower confidence — do not imply full verification.

## What to check

### Plan alignment
- Implementation matches plan/requirements?
- Deviations: intentional improvement or problematic drift?
- All planned functionality present?

### Code quality
- Clear separation of concerns?
- Error handling at boundaries (I/O, user input, external APIs)?
- Types / contracts where the stack uses them?
- DRY without premature abstraction?
- Edge cases (empty input, failures, off-by-one)?

### Architecture
- Sound design for this codebase's scale?
- Performance/scalability concerns for hot paths?
- Security (injection, secrets, auth, untrusted input)?
- Integrates cleanly with existing patterns?

### Testing
- Tests assert **real behavior**, not only mocks?
- **Edge cases, failure paths, and regressions** covered — not just happy path?
- **Stress / boundary** inputs exercised for changed code?
- Integration tests where wiring matters?
- **All tests pass** — full suite green; list command and result (e.g. `pytest: 142 passed`)
- Missing tests for obvious edge cases → **Important** minimum; **Critical** if bug likely

### Production / research readiness
- Migrations or breaking API changes documented?
- Backward compatibility considered?
- Docs/README updated for new surface area?
- No obvious logic bugs or silent failure modes?

### Research code (when applicable)
- Numerical stability, units, shape contracts, reproducibility (seeds)?
- Heavy compute behind documented limits?
- No debug paths left enabled by default?

## Calibration

Categorize by **actual severity** — not everything is Critical.

- Acknowledge strengths **before** issues (specific praise builds trust).
- Flag plan deviations explicitly — confirm if intentional.
- If the **plan** is wrong, say so; do not only blame the implementation.

## Output format

Use exactly these sections:

### Strengths
[Specific, file-backed positives. If none after reading, say what you checked.]

### Issues

#### Critical (Must Fix)
[Bugs, security, data loss, broken functionality, wrong results]

#### Important (Should Fix)
[Missing features, architecture problems, weak error handling, test gaps]

#### Minor (Nice to Have)
[Style, micro-optimizations, doc polish]

For each issue:
- **File:line** (or file + symbol if line unstable)
- What is wrong
- Why it matters
- How to fix (if not obvious)

### Recommendations
[Optional improvements to code, architecture, or process — not blocking]

### Assessment

**Ready to merge?** `Yes` | `No` | `With fixes`

**Reasoning:** [1–2 sentences, technical]

**Tests:** [command run, pass/fail count; edge/stress cases run or gaps noted]

`Yes` only if: diff read, plan met, **full test suite green**, and no unresolved
Critical/Important issues (including missing edge coverage for high-risk paths).

State which files you read and which tests you ran.

## Critical rules

**DO:**
- Read the diff and surrounding context
- Run the **full** test suite; stress edge cases for changed behavior
- Categorize by real severity
- Be specific (`path:line`, not "improve error handling")
- Explain **why** each issue matters
- Give a clear verdict — **No** if tests fail or edge gaps are serious

**DON'T:**
- Say "looks good" without reading the diff
- Approve on happy-path-only testing
- Mark nits as Critical
- Review from session memory instead of the git range
- Be vague or avoid a verdict
- Fix code silently during review (unless asked)

## Dispatch template (subagent / Task tool)

When spawning a reviewer, pass **only** work product context — not the implementer's
full chat history:

```
You are a code reviewer. Apply the **code-reviewer** skill.

## What was implemented
{DESCRIPTION}

## Requirements / plan
{PLAN_OR_REQUIREMENTS}

## Git range
Base: {BASE_SHA}
Head: {HEAD_SHA}

Run:
  git diff --stat {BASE_SHA}..{HEAD_SHA}
  git diff {BASE_SHA}..{HEAD_SHA}

Also read: {PROJECT_CLAUDE_MD} and project test commands if present.

Run the full test suite. Stress-test edge cases for changed code. Do not approve
unless all tests pass and edge coverage is adequate for the diff.

Output per the skill's format. Do not modify code.
```

## After review (implementer)

- Fix **Critical** before proceeding
- Fix **Important** before merge (or document why deferred)
- **Add tests** for each reported gap; **re-run full suite until all pass**
- Stress edge cases yourself before re-requesting review — do not rely on reviewer
  to discover every bug
- **Minor** — backlog or follow-up
- Push back with technical reasoning if the reviewer is wrong; show tests/code

For **receiving** review feedback: verify each item against the codebase before
implementing; clarify unclear items before partial fixes; no performative agreement —
state the fix or ask a technical question.

## Integration

- Request review after substantive edits; before PR merge.
- Pair with **code-writing** and **code-testing** for implement → test → review loop.
- Repo `CLAUDE.md` for stack-specific gates (JAX, GPU limits, etc.).
- Paper-bound changes: also run **results-check** / **vlm-figure-audit** where figures changed.
