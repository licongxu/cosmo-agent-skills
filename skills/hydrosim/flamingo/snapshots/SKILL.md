---
name: flamingo-snapshots
description: >-
  FLAMINGO SWIFT particle snapshots: virtual HDF5 files, particle types, 78/79
  output redshifts, downsampled and reduced variants. Use when reading gas, DM,
  stars, BHs, or neutrinos from a FLAMINGO run.
---

# FLAMINGO snapshots

**Source of truth:** [Snapshots](https://dataweb.cosma.dur.ac.uk:8443/flamingo/snapshots/index.html)

Particle snapshots are SWIFT HDF5 outputs at fixed output redshifts. Each
snapshot is sharded per rank but exposed as one **virtual file**
`flamingo_<NNNN>.hdf5` — always open that file (portal: **Reading with swiftsimio**).

## Layout

```
<run>/<run>/snapshots/flamingo_<NNNN>/
    flamingo_<NNNN>.hdf5           # virtual file (entry point)
    flamingo_<NNNN>.<rank>.hdf5    # shards — do not iterate by hand
```

Sibling directories: `snapshots_downsampled/`, `snapshots_reduced/` (see below).

## Output schedule

- **L1_m8** and **L2p8_m9:** 79 snapshot redshifts.
- **L1_m9** variations and **L1_m10:** 78 snapshot redshifts.

SOAP catalogues exist at all listed outputs; **full particle data** is available
for every output of L1_m9, L1_m9_DMO, L1_m10, and L1_m10_DMO only. For other
runs, check the portal snapshot-redshift table (third column: particle data
available or not).

Snapshot number `<NNNN>` maps to redshift via the portal tables — do not assume
the same index as power-spectrum files (0000–0122).

## Particle types (hydro runs)

| SWIFT group | Content |
|-------------|---------|
| PartType0 | SPH gas |
| PartType1 | CDM |
| PartType4 | Stars |
| PartType5 | Black holes |
| PartType6 | Massive neutrinos (δf method) |

_DMO runs: PartType1 (+ PartType6); CDM particles carry baryon mass.

## Partial snapshots

**Downsampled:** random 1% of particles per output (not the same 1% each time);
all BHs kept; most masses rescaled ×100 to conserve total mass (BH masses
excepted). Subset of fields — see portal field list.

**Reduced:** full particle count but only a subset of properties; haloes sampled
in M200c bins (≥200 halos per 0.05 dex bin, else all). **Not shipped** for
L1_m9, L1_m9_DMO, L1_m10, L1_m10_DMO (full snapshots exist for all outputs).

Same HDF5 format; readable with swiftsimio.

## Usage notes

- Coordinates are **comoving**; use scale factor from snapshot metadata for
  physical lengths.
- Neutrino δf: treat masses as weights; see portal particle-properties page.
- Remote/subvolume access: portal documents swiftsimio, hdfstream, and spatial
  masks — follow those pages for IO patterns.

## Related skills

- **flamingo-halo-catalogues** — precomputed SOAP / HBT properties
- **flamingo-lightcones** — on-the-fly lightcone products (not reproducible from
  snapshots alone)
- **flamingo-power-spectra** — precomputed P(k) without loading particles
