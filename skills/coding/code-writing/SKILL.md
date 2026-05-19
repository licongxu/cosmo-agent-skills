---
name: code-writing
description: >-
  Guidelines for implementing code changes: think first, keep diffs minimal and
  simple, surface assumptions, and verify with tests including edge cases. Use when
  writing new code, fixing bugs, or refactoring — before and during implementation.
---

# Code writing

Behavioral guidelines for **implementing** code well — complementary to
**code-reviewer** (review after you write). Inspired by [Karpathy's LLM coding
notes](https://x.com/karpathy/status/2015883857489522876); stack-specific rules
belong in the repo's `CLAUDE.md`.

**Tradeoff:** These bias toward caution and small diffs over speed. For trivial,
one-line fixes, use judgment — still run relevant tests.

## When to apply

- Before writing or editing non-trivial code
- When a task is ambiguous, multi-step, or touches shared modules
- When fixing bugs or doing numerical / library-boundary work
- After review feedback — implement fixes surgically, re-verify

## 1. Understand before editing

Trace the call path and boundaries (I/O, JIT, config, public API) **before** changing
code. Do not move heavy initialization, network, or disk access into hot inner loops
without an explicit reason.

- Read callers and tests that exercise the code you will touch.
- Note what must stay stable (API shape, units, dtypes, seeds).

## 2. Think before coding

**Do not assume. Do not hide confusion. Surface tradeoffs.**

Before implementing:

- State assumptions explicitly; ask if uncertain.
- If multiple interpretations exist, present them — do not pick silently.
- If a simpler approach exists, say so; push back when warranted.
- If requirements are unclear, stop and name what is confusing.

## 3. Simplicity first

**Default:** minimum code that solves the problem. Avoid speculative generality.

- No features beyond what was asked.
- No abstractions for single-use code.
- No extra configurability unless requested.
- No error handling for scenarios that cannot happen given stated constraints.

Ask: "Would a senior engineer call this overcomplicated?" If yes, simplify.

**When simple is not enough:** Some problems genuinely need more code — numerical
stability, concurrency, performance, correctness under edge cases, or matching an
existing architecture. **Complexity is allowed** when a simpler approach fails or
would be wrong. Prefer the simplest thing that **works**, not the simplest thing
that almost works.

If you add complexity:
- Say **why** the naive version is insufficient (bug, benchmark, API contract, review).
- Keep it localized — do not spread complexity across unrelated modules.
- Prove it with tests (especially edges the simple version missed).

**Balance with verification:** Simplicity is not an excuse to skip tests. A minimal
**repro test** or edge-case check is often the *simplest* correct fix for a bug —
that extra code is justified when it defines success. Likewise, a more elaborate
implementation is justified when tests or requirements show the minimal one cannot.

## 4. Surgical changes

**Touch only what you must.**

When editing existing code:

- Do not "improve" adjacent code, comments, or formatting unprompted.
- Do not refactor unrelated modules.
- Match existing naming, imports, and style.
- Unrelated dead code: mention it; do not delete unless asked.

When **your** changes create orphans:

- Remove imports, variables, or helpers **your** diff made unused.
- Do not remove pre-existing dead code unless requested.

**Test:** Every changed line should trace to the user's request (or to a test that
proves the fix).

## 5. Goal-driven execution

Turn tasks into **verifiable** outcomes:

| Task | Success criteria |
|------|------------------|
| Add validation | Tests for invalid inputs pass; valid path unchanged |
| Fix a bug | Test reproduces bug, then passes after fix |
| Refactor | Full relevant suite green before and after |
| New feature | Acceptance cases + edge cases tested |

For multi-step work, state a short plan with checks:

```
1. [Step] → verify: [test or command]
2. [Step] → verify: [test or command]
```

Prefer criteria you can verify yourself (tests, scripts) over vague "make it work."
If criteria are weak, propose stronger ones before coding.

## 6. Justify and preserve

- **Non-trivial edits** need a clear reason (correctness, units, stability, API contract).
- **Preserve behavior** unless fixing a documented bug or an agreed change — no drive-by
  rewrites or mass reformatting.
- **Uncertainty:** say what is unclear; propose a **minimal** check (unit test, finite diff,
  reference limit, shape/finiteness assert).

## 7. Validate before done

After substantive edits:

1. Run the project's test command (e.g. `pytest` from repo root — see `CLAUDE.md`).
2. Add or extend tests: **happy path, edge cases, failure modes** for code you changed.
3. Loop until **all relevant tests pass** — fix failures before requesting review.
4. For numerical work: assert shapes, finiteness, and regressions where feasible.

Do not hand off "should work" without running tests you can run.

## Self-check before review

- [ ] Scope matches the request — no extra features?
- [ ] Diff surgical — no unrelated edits?
- [ ] Assumptions stated or validated?
- [ ] Tests added/updated for changed behavior and edges?
- [ ] Full relevant suite green?
- [ ] Ready for **code-reviewer** with description, plan, and git range?

## Integration

| Skill | When |
|-------|------|
| **code-testing** | Test-first cycle, verify red/green, edge cases, full suite |
| **code-reviewer** | After implementation; before merge or next plan task |
| Repo `CLAUDE.md` | Test commands, JIT rules, domain physics, env |

Write with **code-writing**; test with **code-testing**; review with **code-reviewer**.
