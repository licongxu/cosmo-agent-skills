# CLAUDE.md

Guidance for Claude Code when working with **FLAMINGO** data (COSMA portal, scratch/RDS).
Use together with the six **`flamingo-*`** skills in this directory.

## Before you start

1. Read the project’s **`TASK.md`** or equivalent spec if the human has one — do not invent analysis scope.
2. If **`.context/current-focus.md`** exists in the project, read it next (session handoff).
3. Skim project **`docs/NOTES.md`** if present for recent iteration detail.
4. For FLAMINGO paths, runs, or HDF5 layout, read the relevant **`flamingo-*`** skill before guessing.
5. If the task uses halo models or cluster counts, skim the relevant **related repository** `CLAUDE.md` (below) — treat those repos as read-only unless the human widens scope.

Do **not** create `.context/current-focus.md` on the first iteration or when no substantive work has happened yet — only after a session where real progress was made.

## After every session

When ending a session, update **`.context/current-focus.md`** in the **project** (not necessarily this skills repo) with:

- **What we worked on**
- **Where things were left off**
- **What's coming next**

Overwrite each time. Skip on the very first iteration or if nothing worth recording.

## Layout (conventions for analysis projects)

| Path | Contents |
|------|----------|
| `.context/current-focus.md` | Session handoff |
| `code/` | Python modules, scripts |
| `data/` | Small **derived** products (binned spectra, cov matrices, etc.) |
| `data/maps/` | Local **tSZ HEALPix FITS** (NSIDE=4096), e.g. `tsz_lensed_rot_same_rot.fits` from portal yang26 |
| `catalogues/` | **Derived** halo/cluster tables from remote reads |
| `plots/` | Figures |
| `docs/` | `NOTES.md`, design notes |

**Do not** mirror FLAMINGO **raw** release data into the project “just in case”. **Do** save **derived** outputs (catalogues, binned \(D_\ell\), Cobaya chains, plots).

**Exception — tSZ Compton-\(y\) map:** use portal **yang26** integrated map at **NSIDE=4096** (`lensed_tSZ_rot_same_rot.hdf5` → local `data/maps/{run_id}/tsz_lensed_rot_same_rot.fits`), not per-shell `ComptonY` HDF5 alone. **Do not** mix lensed (yang26) and un-lensed (`ComptonY_rot_*.fits` on RDS) products across runs — see **`flamingo-lightcones`**.

## FLAMINGO data access

- **No local raw download required** for most products. HDF5 on COSMA is reachable via **`hdfstream`** (HTTP, slice-level reads) and **`swiftsimio`** — see **`flamingo-hdfstream`** and [service docs](https://dataweb.cosma.dur.ac.uk:8443/flamingo/service_docs/). Read remotely; pull only the arrays needed per query.
- **Store derived products locally** (cut catalogues, binned \(D_\ell^{yy}\), Cobaya inputs/outputs).
- **Run choice, paths, units:** use `flamingo-simulations`, `flamingo-snapshots`, `flamingo-halo-catalogues`, `flamingo-lightcones`, `flamingo-power-spectra` before guessing naming or layout.
- **Portal:** <https://dataweb.cosma.dur.ac.uk:8443/flamingo/> — verify field names when unsure; do not invent SOAP properties.
- **Read-only on the release tree:** never write to FLAMINGO data on COSMA.
- **Units:** P(k) from FLAMINGO text outputs is in Mpc / Mpc³ **without h**; coordinates are comoving Mpc unless a skill or header says otherwise.

## Skills in this pack

Read the relevant **skill** before a specialized task (checklists stay in each `SKILL.md`):

| Skill | Topic |
|-------|--------|
| [flamingo-simulations](simulations/SKILL.md) | Runs, naming, box sizes |
| [flamingo-power-spectra](power-spectra/SKILL.md) | Matter P(k) text files |
| [flamingo-snapshots](snapshots/SKILL.md) | Snapshot HDF5 |
| [flamingo-halo-catalogues](halo-catalogues/SKILL.md) | SOAP / HBT |
| [flamingo-lightcones](lightcones/SKILL.md) | Maps, integrated tSZ (yang26 / `ComptonY_rot_*`) |
| [flamingo-hdfstream](hdfstream/SKILL.md) | Remote streaming I/O |

When this pack is installed in a project (e.g. under `.claude/skills/`), the same names apply.

## Non-stop loop (optional)

If the **cosmo-agent-skills** plugin is enabled in a project, `/loop-on` and `/loop-off` use the plugin hooks and `loop-prompt.md`. That is project-local configuration — not required for using these FLAMINGO skills.

## Environment and hardware

Typical Python env on COSMA scratch (adjust per machine):

```bash
source /scratch/scratch-lxu/venv/cmbagent_env/bin/activate
```

**Check hardware before heavy jobs** — Cobaya MCMC, full-sky map FFTs, JAX/GPU hmfast, multi-GB reads:

- Inspect **GPU** (`nvidia-smi`), **CPU/RAM** (`free -h`), and **disk**.
- Prefer **pilot reads** (one snap, one bin) before full loops.
- If resources are insufficient, propose a smaller test before scaling up.

Large inputs may live under `/scratch/scratch-lxu/` or `/rds/` — use path constants in code.

## Working style

- **Small, verifiable steps** — one observable, script, or figure per iteration when possible.
- **Justify science** — units, cosmology, halo definition, run choice.
- **Remote-first data** — stream via `hdfstream`; persist derived products only.
- **Minimal diffs** — match existing project style.

## Related repositories

For **theory, emulators, and cluster statistics** alongside FLAMINGO data. Read freely; edit only when the human scopes work to that repo.

| Repository | Path | Role |
|------------|------|------|
| **hmfast** | `/scratch/scratch-lxu/agent_dev/auto_research_agent/hmfast` | JAX halo-model predictions (mass function, bias, profiles, tracers, emulators). |
| **cosmocnc_jax** | `/scratch/scratch-lxu/agent_dev/auto_research_agent/cosmocnc_jax` | JAX cluster number counts (CNC), Cobaya interfaces. |

Prefer **imports and thin drivers** in the analysis project — avoid vendoring their source.

Example FLAMINGO analysis pipeline (reference only):  
`/scratch/scratch-lxu/flamingo_data_analysis/catalogue_finding` — includes `compute_binned_dl_yy.py` and rotation-consistency tutorials.
