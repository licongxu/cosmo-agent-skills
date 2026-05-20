---
name: flamingo-hdfstream
description: >-
  Remote, slice-level access to FLAMINGO HDF5 files on COSMA via the
  `hdfstream` Python module — no need to download whole snapshots. Covers
  install, server connection, navigation, dataset slicing, multi-slice
  batched reads, and integration with swiftsimio. Use when reading any
  FLAMINGO data product remotely.
---

# FLAMINGO remote access via hdfstream

The FLAMINGO data portal exposes every HDF5 file on COSMA through a
streaming HTTP API. The `hdfstream` Python module gives an h5py-like
interface so you can read **specific datasets or even slices** without
downloading the file. This is the default access path for FLAMINGO —
prefer it over bulk downloading.

Portal viewer: <https://dataweb.cosma.dur.ac.uk:8443/flamingo/viewer.html>
Service docs: <https://dataweb.cosma.dur.ac.uk:8443/flamingo/service_docs/>

## Install

```bash
pip install hdfstream
# optional, for snapshot / catalogue convenience:
pip install swiftsimio
```

## Open the server

```python
import hdfstream
root = hdfstream.open("cosma", "/")          # "cosma" is an alias
print(list(root))                             # list top-level entries
```

`root` behaves like a dict of remote directories.

## Navigate

```python
sub  = root["FLAMINGO/L1_m10/L1_m10_DMO/snapshots/flamingo_0077"]
file = root["FLAMINGO/L1_m10/L1_m10_DMO/snapshots/flamingo_0077/flamingo_0077.0.hdf5"]
print(list(file))                             # HDF5 groups
print(file["Header"].attrs)                   # attributes
```

Subscripting traverses both filesystem and HDF5 hierarchies transparently.

## Read datasets (h5py-style slicing)

```python
all_dm  = file["PartType1/Coordinates"][...]          # entire dataset
first   = file["PartType1/Coordinates"][:100, :]      # only first 100 rows
masses  = file["PartType0/Masses"][1000:2000]
```

Only the bytes for the requested slice are sent over the wire.

## Batched multi-slice reads

When you need several disjoint chunks of the same dataset, fold them into
one round-trip:

```python
import numpy as np
slices = [np.s_[10:20, :], np.s_[50:60, :]]
chunk  = file["PartType1/Coordinates"].request_slices(slices)
# returns rows 10–19 and 50–59 concatenated along axis 0
```

Rules: first-axis slices must be **ascending and non-overlapping**, and
indices in other dimensions must be identical across slices.

## Use with swiftsimio (recommended for snapshots / SOAP)

`swiftsimio` accepts an hdfstream remote-file handle directly, giving
units, cosmology, and spatial masking on top of streaming I/O:

```python
import hdfstream, swiftsimio as sw
root   = hdfstream.open("cosma", "/")
remote = root["FLAMINGO/L1_m10/L1_m10/snapshots/flamingo_0077/flamingo_0077.hdf5"]
snap   = sw.load(remote)
print(snap.metadata.z, snap.metadata.boxsize)
pos    = snap.dark_matter.coordinates       # streamed, with units
```

The same pattern works for SOAP catalogues
(`SOAP-HBT/halo_properties_<NNNN>.hdf5`) and lightcone HEALPix shells.

## When to apply

- Any FLAMINGO analysis that does **not** need the whole snapshot — almost
  every analysis qualifies.
- Quickly inspecting headers, attributes, particle counts, or field lists
  before deciding what to compute.
- Pulling targeted regions (halo neighbourhoods, sub-volumes) via
  swiftsimio's spatial mask layered on top of hdfstream.
- CI / cluster-side scripts where the full data are too large to copy.

## Gotchas

- The COSMA endpoint is HTTPS on port 8443; firewalls / proxies may need
  configuration.
- Slice rules (ascending, non-overlapping, consistent secondary indices)
  are enforced — violating them raises rather than silently truncating.
- Virtual files (`flamingo_<NNNN>.hdf5`) are the right entry point for
  snapshots, not the per-rank shards (`*.<rank>.hdf5`). Open the virtual
  file via swiftsimio and let it dispatch.
- Network reads add latency per request — prefer **one big slice** or
  **`request_slices`** over many small `[i:i+1]` reads in a loop.
- **Exception — full-sky tSZ \(D_\ell^{yy}\):** stream the integrated map **once**
  from portal  
  `.../integrated_maps/yang26/lightcone0_shells/lensed_tSZ_rot_same_rot.hdf5`
  (dataset `data`, NSIDE=4096), cache locally as FITS — not per-shell `ComptonY`
  slab reads. See **flamingo-lightcones** → full-sky tSZ. Legacy
  `/rds/flamingo/.../ComptonY_rot_0.fits` is optional when yang26 is missing.

## Related skills

- **flamingo-snapshots** — particle layout; open virtual snapshot files
- **flamingo-halo-catalogues** — SOAP HDF5 catalogues
- **flamingo-lightcones** — HEALPix shells and particle lightcones
- **flamingo-simulations** — run naming and paths under `/FLAMINGO/`
- **flamingo-power-spectra** — ASCII P(k) text files (not HDF5 / not hdfstream)
