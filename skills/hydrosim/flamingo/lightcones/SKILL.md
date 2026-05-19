---
name: flamingo-lightcones
description: >-
  FLAMINGO past-lightcone products: virtual observers, particle lightcones,
  HEALPix shell maps, integrated_maps, and halo lightcones. Use when building
  mock surveys, stacking Compton-y or lensing maps, or cross-correlating with
  observations.
---

# FLAMINGO lightcones

**Source of truth:** [Lightcone outputs](https://dataweb.cosma.dur.ac.uk:8443/flamingo/lightcones/index.html)

During the run, SWIFT records particles (and derived maps) as they cross each
virtual observer’s past lightcone. Products are **not** recoverable by post-processing
snapshots alone.

## Product families

Under each run directory (see **flamingo-simulations** layout):

| Subdirectory | Content |
|--------------|---------|
| `particle_lightcones/` | Particles at crossing with lightcone time/position |
| `healpix_maps/` | Full-sky HEALPix maps in redshift shells |
| `integrated_maps/` | Post-processed redshift-integrated HEALPix maps |
| `halo_lightcone/` | Haloes placed on the lightcone (minimal properties + indices to SOAP/HBT) |

Portal subpages cover directory layout, file format, shell redshifts, and IO for
each family.

## Virtual observers

- **1 Gpc boxes:** 2 observers (halfway from box centre to two opposite corners).
- **2.8 Gpc and larger:** 8 observers (halfway from centre toward corners).

Exact comoving Mpc coordinates are tabulated on
[Observer positions](https://dataweb.cosma.dur.ac.uk:8443/flamingo/lightcones/observers.html).

Larger boxes extend single-observer reach; 1 Gpc runs need periodic replication
to reach high redshift (correlated copies, not new realisations).

## HEALPix shell maps

Maps are built in spherical redshift shells. Quantities include (among others):
ComptonY (tSZ), DopplerB (kSZ), DarkMatterMass, gas/stellar/BH/neutrino maps,
X-ray-related fields — each with documented units and whether SPH smoothing was
applied. Full list:
[Map descriptions](https://dataweb.cosma.dur.ac.uk:8443/flamingo/lightcones/healpix_map_descriptions.html).

Shell redshift edges: [Shell redshifts](https://dataweb.cosma.dur.ac.uk:8443/flamingo/lightcones/healpix_shell_redshifts.html).

**Shell maps vs integrated maps:** at high z, shell width can exceed the box;
periodic replication can correlate structure. **Integrated** products in
`integrated_maps/` apply a documented rotation scheme so integrated observables
are mutually consistent; **shell** maps are not rotated the same way. Read
[Integrated lightcones](https://dataweb.cosma.dur.ac.uk:8443/flamingo/lightcones/integrated_lightcones.html)
before cross-correlating shell and integrated products.

## Particle lightcones

Per particle type and observer: crossing position, velocity, mass, ID, expansion
factor at crossing, plus type-specific fields (temperature, Compton-y weight,
etc.). Use when an observable is not provided as a HEALPix map.

## Halo lightcones

Per redshift shell HDF5 files; haloes traced with black holes, minimal properties
plus indices into HBT-HERONS and SOAP for full properties. Portal documents
format and the `lightcone_io` Python module for reading and sky cuts.

## When to use which product

- **Mock CMB secondaries / WL / X-ray maps:** start with `healpix_maps/` or
  `integrated_maps/` as appropriate to the analysis.
- **Cluster samples vs observations:** halo lightcones + map cutouts.
- **Custom observables:** particle lightcones.
- **Off-lightcone 3D work:** **flamingo-snapshots**, not lightcones.

## Gotchas

- Read units from HDF5 attributes per map (Compton-y dimensionless, kSZ as Doppler
  b, masses in documented units).
- Each observer is a different sky; do not mix observers as independent
  cosmological realisations without checking portal guidance.
- IO helpers (`lightcone_io`, healpy) are documented on the portal — follow those
  pages rather than guessing map pixelization.

## Related skills

- **flamingo-halo-catalogues** — SOAP/HBT definitions referenced by halo lightcones
- **flamingo-simulations** — box size and observer count
- **flamingo-power-spectra** — matter P(k) complementary to map statistics
