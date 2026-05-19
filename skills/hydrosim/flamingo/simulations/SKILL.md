---
name: flamingo-simulations
description: >-
  FLAMINGO simulation suite inventory: naming (L box, m resolution, variations,
  _DMO), fiducial and variation runs, directory layout under /FLAMINGO/. Use when
  choosing a run, locating data on the COSMA portal, or citing the simulation.
---

# FLAMINGO simulations

**Source of truth:** [FLAMINGO data release — Simulations](https://dataweb.cosma.dur.ac.uk:8443/flamingo/simulations/index.html)

FLAMINGO is a large suite of cosmological hydrodynamical simulations (SWIFT +
SWIFT-EAGLE subgrid physics) with matching dark-matter-only (_DMO) counterparts.
The public release includes snapshots, halo catalogues, lightcones, and power
spectra (Helly et al. 2026 data release paper).

## Naming convention

`L<box>_m<res>[_<variation>][_DMO]`

- **L\<box\>** — comoving box side length in Gpc (`L1` = 1, `L2p8` = 2.8,
  `L5p6` = 5.6, `L11p2` = 11.2). Runs without an `L` prefix use a 1 Gpc box.
- **m\<res\>** — approximately log10 of the mean **gas** particle mass in M☉
  (fiducial hydro: m8 ≈ 1.3×10⁸, m9 ≈ 1.1×10⁹, m10 ≈ 8.6×10⁹). Exact masses
  depend slightly on cosmology; CDM masses in _DMO runs include baryon mass.
- **Variation suffix** — subgrid or cosmology label (e.g. `fgas-4sigma`, `Jet`,
  `Planck`, `Mstar-1sigma`). Applied to 1 Gpc / m9 unless noted.
- **_DMO** — gravity-only counterpart with matched initial conditions.

## Fiducial hydro runs (portal table)

| Run | Box (Gpc) | Role |
|-----|-----------|------|
| L1_m8 | 1.0 | Highest resolution fiducial |
| L1_m9 | 1.0 | Intermediate resolution fiducial |
| L1_m10 | 1.0 | Lowest resolution fiducial |
| L2p8_m9 | 2.8 | Flagship large volume |

Large DMO-only boxes include L5p6_m10_DMO and L11p2_m11_DMO (see portal DMO page).

## Model variations (1 Gpc, m9 unless noted)

**Feedback / calibration:** `fgas+2sigma`, `fgas-2sigma`, `fgas-4sigma`,
`fgas-8sigma`, `Mstar-1sigma`, `Mstar-1sigma_fgas-4sigma`, `Jet`,
`Jet_fgas-4sigma`.

**Cosmology:** `Planck`, `PlanckNu0p24Var`, `PlanckNu0p24Fix`, `PlanckNu0p48Fix`,
`LS8`. Subgrid parameters for variations: Kugel et al. 2023 (portal links to
parameter table).

## Directory layout

Browse under `/FLAMINGO/<box_res>/` then **`<run_name>/<run_name>/`** for each
simulation. Typical product subdirectories (see [layout](https://dataweb.cosma.dur.ac.uk:8443/flamingo/simulations/layout.html)):

- `snapshots/`, `snapshots_downsampled/`, `snapshots_reduced/`
- `SOAP-HBT/` — SOAP halo properties per snapshot
- `HBT-HERONS/` — subhalo finder outputs
- `power_spectra/` — ASCII P(k) files
- `particle_lightcones/`, `healpix_maps/`, `halo_lightcone/`, `integrated_maps/`

Hydrodynamical and _DMO siblings are parallel run trees (e.g. `L1_m9` vs
`L1_m9_DMO`).

## When to use which run

- **Large-scale / rare clusters:** L2p8_m9
- **Resolution convergence:** L1_m8 vs L1_m9 vs L1_m10
- **Baryonic uncertainty:** fgas and Mstar calibration variants, Jet vs thermal AGN
- **Cosmology:** Planck*, LS8, neutrino-mass variants
- **Hydro vs DMO:** paired run + _DMO for baryonic response

## Citations

Cite Schaye et al. 2023 for the suite, Kugel et al. 2023 for calibration, and
the data-release paper / portal acknowledgements when using released products.

## Related skills

- **flamingo-power-spectra** — precomputed P(k) in `power_spectra/`
- **flamingo-snapshots** — particle HDF5 in `snapshots/`
- **flamingo-halo-catalogues** — SOAP-HBT and HBT-HERONS
- **flamingo-lightcones** — mock skies and lightcone particles
