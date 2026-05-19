---
name: flamingo-halo-catalogues
description: >-
  FLAMINGO SOAP halo catalogues and HBT-HERONS subhalo outputs: directory layout,
  halo definitions (bound, spheres, projected apertures, spherical overdensity),
  and cross-simulation matching. Use when selecting clusters or galaxies from
  released catalogues.
---

# FLAMINGO halo catalogues

**Source of truth:** [Halo catalogues (SOAP)](https://dataweb.cosma.dur.ac.uk:8443/flamingo/soap/index.html)

Pipeline: **HBT-HERONS** finds self-bound subhaloes (centrals + satellites, merger
trees) → **SOAP** computes properties under many halo/aperture definitions.

## Directory layout (separate trees)

```
<run>/<run>/SOAP-HBT/
    halo_properties_<NNNN>.hdf5    # one file per snapshot number

<run>/<run>/HBT-HERONS/
    OrderedSubSnap_<NNN>.hdf5       # subhalo finder output per snapshot
```

`<NNNN>` / `<NNN>` follow **snapshot numbering** (see **flamingo-snapshots**
redshift tables). Example: `/FLAMINGO/L1_m9/L1_m9/SOAP-HBT/`.

SOAP version is recorded in file metadata (`/Code` attributes). Pin this when
reproducing published numbers.

## Terminology

- **Halo** — 3D Friends-of-Friends group.
- **Subhalo** — bound set inside a halo (HBT-HERONS).
- **Central** — one per halo (centre = most-bound particle); **satellite** — others.

## SOAP halo definition groups (HDF5)

| Group pattern | Meaning |
|---------------|---------|
| `bound_subhalo` | All particles bound to the subhalo |
| `exclusive_sphere_<R>kpc` | Bound particles within physical radius R |
| `inclusive_sphere_<R>kpc` | All particles within R (bound or not) |
| `projected_aperture_<R>kpc_projP` | Bound particles in cylinder along axis P (x, y, z) |
| `spherical_overdensity_<label>` | Sphere from density profile (centrals only) |

**Sphere radii (exclusive/inclusive):** 10, 30, 50, 100, 300, 500, 1000, 3000 kpc
(physical).

**Projected apertures:** 10, 30, 50, 100 kpc only; three projection axes each.

**Spherical overdensity labels:** include 50_crit, 100_crit, 200_crit, 500_crit,
1000_crit, 2500_crit, 200_mean, 5xR_500_crit (see portal for calculation
details). SO quantities are for **central** haloes only.

## Choosing a definition

- Cluster masses / Y_X-style work: SO 200_crit or 500_crit.
- Galaxy stellar mass in aperture: exclusive_sphere_30kpc (typical).
- Photometric aperture mimic: projected_aperture.
- Total subhalo: bound_subhalo.

Exclusive vs inclusive sphere: whether unbound/s satellite material inside R is
included — stay consistent within a study.

## Properties and filters

Hundreds of fields per definition (masses, radii, kinematics, gas/star/BH splits,
Compton-y, X-ray proxies, etc.). The portal **SOAP properties table** and
**property filters** list what exists for each definition.

Preferred reader: **swiftsimio** (units from metadata) — see portal page
*Reading SOAP halo catalogues with swiftsimio*.

## Cross-simulation matching

Portal documents matching subhaloes between paired runs (hydro vs _DMO, variation
vs fiducial) via particle IDs / most-bound particle. Use released match files
instead of rematching by position.

## Merger trees

HBT-HERONS merger trees: portal section *HBT-HERONS merger trees* and files under
`HBT-HERONS/`.

## Related skills

- **flamingo-snapshots** — particles SOAP ingests; custom finder reruns
- **flamingo-lightcones** — `halo_lightcone/` catalogues on the past lightcone
- **flamingo-simulations** — which run variant to open
