---
name: code-testing
description: >-
  Test-driven workflow: write failing tests first, verify red/green, cover edge cases,
  and keep the full suite green before merge. Use when implementing features, fixing
  bugs, or refactoring — before and alongside production code.
---

# Code testing

How to **test code correctly** — test-first when possible, always verify tests catch
real failures, and stress edge cases until the suite is green. Complements
**code-writing** (how to implement) and **code-reviewer** (pre-merge review).

Test commands and fixtures live in the repo's `CLAUDE.md` (e.g. `pytest`, `npm test`).

**Core principle:** If you did not see the test **fail for the right reason**, you do
not know it tests the right thing.

## When to use

**Default (test-first):**
- New features and behavior changes
- Bug fixes
- Refactors that must preserve behavior

**Ask before skipping test-first:**
- Throwaway prototypes or spikes (explore, then **discard** and re-implement with tests)
- Generated or vendored code you will not maintain
- Pure config / docs-only changes

**Never skip tests entirely** for production paths — at minimum add or extend tests
before calling work done.

## The cycle: Red → verify → Green → verify → Refactor

```
RED        Write one minimal failing test (one behavior)
  ↓
VERIFY RED Run targeted test — must fail for expected reason (not typo/import error)
  ↓
GREEN      Minimal production code to pass
  ↓
VERIFY GREEN Run targeted test + full suite — all green
  ↓
REFACTOR   Clean up (no new behavior); stay green
  ↓
REPEAT     Next behavior or edge case
```

### RED — write a failing test

One test, one behavior. Name states **what should happen**.

**Good:** clear name, asserts real behavior, minimal setup, uses real code paths.

**Bad:** vague name (`test1`), tests mock call counts instead of outcome, multiple
unrelated assertions, "and" in the name (split tests).

Prefer testing **observable behavior** (return value, raised error, side effect on
real objects) over implementation details.

For numerical / research code, also assert: shapes, `finfinite`, known limits,
regressions against a reference value when available.

### VERIFY RED — mandatory

Run the **single test** (or smallest file):

```bash
pytest path/to/test_module.py::test_name -q
# or project equivalent from CLAUDE.md
```

Confirm:
- **Fails** (assertion failure), not an accidental setup error — fix setup if needed
- Failure message matches missing/wrong behavior
- Would have **passed** if the bug were already fixed? → test is wrong; fix the test

Skipping VERIFY RED is the most common way to ship useless tests.

### GREEN — minimal code

Write the **simplest** code that passes. No extra features, config knobs, or refactors
outside scope (**code-writing** §3). Complexity is allowed when tests or requirements
prove the simple version fails — document why.

### VERIFY GREEN — mandatory

- Target test passes
- **Full relevant suite** passes (not only the new file)
- No new warnings you should fix (project-dependent)

If other tests break, fix before moving on.

### REFACTOR

Only after green: rename, dedupe, extract helpers. **No new behavior** without a new
RED test.

## Edge cases and stress (required before done)

After happy path, add tests for behavior your change touches:

| Category | Examples |
|----------|----------|
| Empty / minimal | zero length, `None` where allowed, single element |
| Boundaries | min/max, off-by-one, saturation |
| Invalid input | wrong type, out of range, malformed config |
| Failure modes | I/O error, missing file, timeout |
| Numerics | NaN, Inf, denormal, dtype/shape mismatch |

Loop: add test → verify red (if bug exists) or green (regression guard) → fix → full
suite green. **code-reviewer** expects this coverage for changed code.

## Bug fixes

1. Write a test that **reproduces the bug** (must fail on current code).
2. VERIFY RED — see the failure you expect.
3. Fix with minimal change.
4. VERIFY GREEN — test passes; full suite green.

**Do not fix bugs without a regression test** unless the user explicitly waives it.

## Good vs bad tests

| Quality | Good | Bad |
|---------|------|-----|
| Scope | One behavior per test | Kitchen-sink test |
| Name | Describes expected behavior | `test_foo`, `test_works` |
| Subject | Real code path | Mock interaction only |
| Proof | Saw it fail, then pass | Written after code; passed first run |
| Edges | Explicit cases listed | Happy path only |

## Anti-patterns

- **Testing mocks** — `mock.assert_called()` without checking outcome
- **Test-only hooks in production** — prefer public API or test doubles in test code
- **Over-mocking** — if everything is mocked, test design or coupling may be wrong
- **Flaky tests** — random without seed, timing races, float without tolerance
- **Tests that pass immediately** on new behavior — proves nothing; fix test or code order

## Tests-after code (legacy or spike)

Ideal: test-first. When code already exists:

- For **new behavior:** still write failing test first, then implement (or delete spike
  and rewrite from tests if the spike was exploratory).
- For **legacy without tests:** add characterization tests before risky edits; add
  failing test before each bug fix.

Tests-after that pass on first run **do not prove** they catch regressions — add a
deliberate break or mutation check when unsure.

## Verification checklist (before review / merge)

- [ ] New/changed behavior has tests (happy path + relevant edges)
- [ ] Saw each new test **fail** before fix (or documented why already green)
- [ ] Failure was for the **right reason**
- [ ] Minimal code to pass; refactor only with suite green
- [ ] **Full** project test suite green (command + count recorded)
- [ ] Tests use real behavior; mocks only where unavoidable
- [ ] Ready for **code-reviewer**

## When stuck

| Problem | Try |
|---------|-----|
| Don't know how to test | Write desired API/assertion first; ask user; simplify interface |
| Test setup huge | Extract fixtures; simplify design |
| Must mock everything | Reduce coupling; inject dependencies |
| Numerical test unstable | Tight tolerances with justification; fixed seeds; reference values |

## Common rationalizations (reject)

| Excuse | Reality |
|--------|---------|
| "Too simple to test" | Simple code breaks; test is cheap |
| "I'll test after" | Pass-on-first-run proves nothing |
| "I manually tested" | Not repeatable; no regression net |
| "Keep code as reference" | You'll adapt it; that's tests-after |
| "Deleting work is wasteful" | Unverified code is debt |

## Integration

| Skill | Role |
|-------|------|
| **code-writing** | Surgical impl; simplicity vs needed complexity |
| **code-reviewer** | Confirms suite green + edge coverage on diff |
| Repo `CLAUDE.md` | `pytest` paths, markers (`slow`), GPU fixtures |

**Workflow:** **code-testing** (this skill) while implementing → full green suite →
**code-reviewer** before merge.
