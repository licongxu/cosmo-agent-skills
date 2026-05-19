---
name: repo-hygiene
description: >-
  Audit and tidy a repo or working folder: fix layout drift, consolidate
  misplaced files, remove stale artifacts, align docs with disk. Use when
  organizing any project, scratch folder, or new repo — before release or
  after a refactor.
---

# Repo hygiene

Keep a tree **navigable, documented, and free of stale cruft** — without
breaking active work or deleting anything the user still needs.

Complements **code-writing** (implementation) and **code-reviewer** (diff quality).
**Do not prescribe a fixed layout.** Derive structure from the project type and
whatever the repo already documents (`README`, `CLAUDE.md`, package manifest,
framework defaults).

## When to apply

- Spinning up or cleaning a **new repo** or **scratch/test folder**
- After a refactor or merge that left duplicate or orphaned paths
- When docs reference paths that no longer exist
- Before a release, PR, or handoff
- Empty scaffolds, duplicate trees, or old results clutter the tree
- User asks to "organize", "consolidate", or "clean up"

## Workflow

### 1. Inventory (read-only first)

```bash
find . -maxdepth 4 -not -path './.git/*' | sort
git status 2>/dev/null || true
```

Read `README`, `CLAUDE.md`, `pyproject.toml` / `package.json` / `Cargo.toml` if
present. Compare **disk** vs **documented intent**. List issues:

| Issue type | Example |
|------------|---------|
| Path drift | README says `src/` but code lives at repo root |
| Duplicate trees | Old copy left after a move |
| Empty scaffolds | Placeholder dirs with no files |
| Stale outputs | Old run artifacts, caches, build dirs |
| Mixed concerns | Tests, scripts, and results all in one flat folder |
| Local-only files | Editor config, large data that should be gitignored |

### 2. Propose a target layout (project-specific)

**Start from what the repo is**, not a template from another project:

| Context | Typical anchors (adapt, don't copy blindly) |
|---------|---------------------------------------------|
| **Library / package** | `src/` or `<pkg>/`, `tests/`, `docs/`, root README |
| **App / service** | app code, config, `tests/`, deploy/infra if any |
| **Research / scratch** | `scripts/`, `notebooks/` or `doc/`, `results/` or `outputs/` (often gitignored) |
| **Monorepo** | one top-level dir per package; shared docs at root |
| **Pre-git experiment** | minimal: README stub, `.gitignore`, one clear output dir |

Principles (always):

- **One canonical home** per concern — source, tests, docs, generated output.
- **Separate generated from source** — outputs and caches not mixed with code.
- **Match ecosystem norms** — Python `src/` layout, Node `package.json` at root, etc.
- **Document the choice** — update README when you create or rename top-level dirs.
- **Scratch folders** — keep lightweight: README with purpose, `.gitignore` for junk,
  delete failed experiments rather than accumulating `old/`, `backup/`, `test2/`.

If the repo has no stated convention yet, propose the **smallest** layout that fits
the work — do not import structure from unrelated repos (plugins, monorepos, etc.).

### 3. Classify candidates for deletion

| Safe to delete (usually) | Confirm with user first |
|--------------------------|---------------------------|
| Empty directories | Anything under `results/`, `outputs/`, `benchmarks/`, `runs/` |
| `__pycache__/`, `.pytest_cache/`, `*.egg-info/`, `node_modules/` (reinstallable) | Plots, checkpoints, or logs that might be the only record of a run |
| Duplicate copies superseded by a move | WIP code still referenced in docs or scripts |
| Editor-local config not meant to be shared | Data files the user still needs |

**Never delete** without checking: uncommitted work, the only copy of a file, or
paths referenced in README, CI, imports, or scripts.

### 4. Execute surgically

1. **Move** misplaced files to canonical paths (`git mv` when tracked).
2. **Update** references: README, imports, CI, config paths, `.gitignore`.
3. **Delete** only after the inventory list is explicit.
4. **Gitignore** local-only or regenerable content; keep pointer READMEs when useful.

### 5. Verify

- Docs match disk (grep for old paths).
- Install / test commands in README still work.
- Project-specific validators (if any) still pass.
- `git status` is clean or changes are intentional.

## Output format

When reporting a hygiene pass:

```markdown
## Repo hygiene report

### Context
- Project type: ...
- Conventions read from: ...

### Layout (before → after)
- ...

### Removed
- ...

### Moved
- ...

### Docs updated
- ...

### Left alone (and why)
- ...

### Follow-ups
- ...
```

## Skill vs subagent

| Approach | Use when |
|----------|----------|
| **This skill** (`repo-hygiene`) | Inline cleanup; need a checklist |
| **repo-organizer subagent** | Large tree or many deletes; audit first, apply after confirmation |

Do **not** fold this into code-writing or code-reviewer — those focus on code diffs,
not tree structure.
