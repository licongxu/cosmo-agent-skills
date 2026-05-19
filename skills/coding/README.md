# Coding skills

Software engineering skills for agents: review, testing, debugging, refactoring, etc.

| Skill | Use when |
|-------|----------|
| [code-writing](code-writing/SKILL.md) | Implementing features, fixes, refactors — think, simplify, verify |
| [code-testing](code-testing/SKILL.md) | Test-first workflow, red/green verify, edge cases, full suite green |
| [code-reviewer](code-reviewer/SKILL.md) | Review a diff against plan/requirements before merge or next task |

## Typical workflow

1. Apply **code-writing** — plan, minimal diff.
2. Apply **code-testing** — failing test → verify red → fix → verify green → edges.
3. Run full suite until **all pass**.
4. Dispatch **code-reviewer** with description, plan, and `BASE_SHA`…`HEAD_SHA`.
5. Fix findings surgically; extend tests; re-run until green; re-review if the diff is large.

## Adding a skill

1. Create `skills/coding/<skill-name>/SKILL.md` with frontmatter (`name`, `description`).
2. Keep skills portable — project commands and domain rules stay in repo `CLAUDE.md`.
3. Add a row here and in the root [README](../README.md).
