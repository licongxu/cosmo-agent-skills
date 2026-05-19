---
name: flamingo-power-spectra
description: >-
  FLAMINGO precomputed matter and component power spectra (ASCII P(k), 123
  redshift indices), units without h, and the FlamingoBaryonResponseEmulator.
  Use when loading FLAMINGO P(k), comparing to theory, or emulating baryonic
  suppression without full hydro.
---

# FLAMINGO power spectra

**Source of truth:** [Power spectra](https://dataweb.cosma.dur.ac.uk:8443/flamingo/power_spectra.html)

Each simulation run directory contains ASCII text files under `power_spectra/`
(e.g. `/FLAMINGO/L1_m9/L1_m9/power_spectra/`).

## File naming and columns

Pattern: `power_<type>_<index>.txt`

- **Index** `0000`–`0122` — 123 output redshifts from z ≈ 30 down to 0 (full
  table on the portal).
- **Columns (space-separated):** (0) redshift z, (1) wavenumber k in Mpc⁻¹
  **without h**, (2) shot-noise-subtracted P(k) in Mpc³ **without h³**.

Do not subtract shot noise again.

## Auto-spectra (5)

`matter`, `cdm`, `gas`, `starBH`, `pressure` (electron pressure P_e = n_e k_B T).

## Cross-spectra (9)

`cdm-gas`, `cdm-neutrino`, `cdm-starBH`, `gas-matter`, `gas-neutrino`,
`gas-starBH`, `matter-pressure`, `starBH-neutrino`, `neutrino0-neutrino1`
(neutrino cross used for shot-noise suppression).

## Gotchas

- **Units:** file k and P(k) omit factors of h; many observables use h Mpc⁻¹ —
  convert consistently before comparing to external data or the emulator.
- **Artifacts:** portal notes small fold-related features in some lines (e.g.
  mid-k bump at z ≈ 2 for L1_m9); these are numerical, not physical.
- **tSZ / pressure work:** use the `pressure` auto-spectrum, not gas density alone.
- **Snapshot vs P(k) index:** power-spectrum indices 0000–0122 are **not** the
  same numbering as snapshot or SOAP catalogue indices.

## Baryonic response emulator

Documented under [Baryonic response emulator](https://dataweb.cosma.dur.ac.uk:8443/flamingo/power_spectra.html#baryonic-response-emulator).

- Python package: `FlamingoBaryonResponseEmulator` (pip; GitHub:
  FLAMINGOproject/FlamingoBaryonResponseEmulator).
- Returns P_hydro / P_DMO as a function of k, z, and three calibration knobs:
  cluster gas-fraction offset, stellar-mass-function offset, and jet vs thermal
  AGN fraction.
- Stated accuracy: better than 1% for z < 2 and k ≤ 10 h Mpc⁻¹ (~1 ms per model
  on one CPU core).

Use paired hydro and _DMO runs when you need the full simulation P(k) rather
than the emulator.

## Related skills

- **flamingo-simulations** — which hydro/_DMO pair to load
- **flamingo-snapshots** — compute P(k) offline from particles if needed

For loading examples, use the portal **Python examples** page rather than
inventing parsers in chat.
