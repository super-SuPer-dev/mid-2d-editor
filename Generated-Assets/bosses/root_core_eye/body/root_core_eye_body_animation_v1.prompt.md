# BOSS-ROOT-CORE-EYE body animation source set v1

**State:** Review (first batch; beam, exposed-core, hurt and death remain)

**Grid contract:** Every accepted animation is a four-frame horizontal strip
normalized to 4000 x 900: four 1000 x 900 cells with baseline 840. Connected
silhouette normalization removes neighboring-cell contamination while
preserving the root pedestal and attached bracts.

## Accepted actions and hashes

| Action | Built-in source | SHA-256 of normalized output |
|---|---|---|
| `idle_sealed` | `exec-e4663eaa-0957-4be6-992d-1f73551d06de.png` | `E09B1B95157E803D3BFD7C4BD5D3C2F92FDE78EA1191221C45F0122571D1B01E` |
| `awaken_tell` | `exec-7bb07307-e777-40d4-9c0e-1140e9ba0c6f.png` | `8BB87CA0A9238496E83C1BCB770F1064A529FB70F83307BC949191342913B852` |
| `aimed_seed_cast` | `exec-34a09fb4-3f88-4f2e-87cb-28bcf8c1215c.png` | `152AA1650F94DF84B90BAF3D74C2794C8D8C6F90A0C69AC99099F362BFCDACAE` |
| `spiral_cast` | `exec-19be708b-a489-4413-98d3-5a9265f8af94.png` | `8CFA004FD123AC0D471BBC7CF631457219AC484228E3059A42CA7A45C3A7D67D` |
| `bract_curtain_cast` | `exec-6af21b93-82d2-43e5-90bf-3be3ade02484.png` | `0BD451ED6BC10EC981B56ABDDBFF66C65D8DBAA02815148DFABBC02265C9B177` |
| `radial_ring_cast` | `exec-c29882fb-68e7-452c-b76d-4cc600e4009e.png` | `B823C8C12832288DCBDDCC38084B8F174EC2C5BD6D8E783DD135F7FE2878733B` |

All normalized outputs have transparent corners, one complete connected boss
per cell, a planted baseline and no baked projectile bodies or text.

## Prompt contracts

All prompts used the sealed idle strip or pixel identity board as the
authoritative design reference and ended with `Transparent background.`

- `idle_sealed`: root pedestal flex, closed bract breathing, staggered blinks
  across eight longan eyes and a dim-medium-dim cyan-vein pulse.
- `awaken_tell`: bracts tighten, split along pale flesh, reveal the huge glossy
  black central seed, then hold the fully open eye without firing.
- `aimed_seed_cast`: eight pupils track screen-left, alternating eye-pods glow,
  then two groups of four flash at separate muzzle origins.
- `spiral_cast`: central pupil opens, eye-pods rotate clockwise, eight pupils
  flash as a spiral and recoil counterclockwise.
- `bract_curtain_cast`: outer bracts spread into paired blade fans, alternate
  downward/upward lane directions, mirror, then sweep inward.
- `radial_ring_cast`: central seed opens, eye-pods spread into an even crown,
  eight ring origins flash and relax at staggered timing.

Every prompt required four equal horizontal cells, identical scale, no
floating, no detached projectiles, no scenery/floor/UI/text/watermarks/grid
lines, generous transparent separation and no cropped roots or bracts.

Remaining body actions: `beam_tell`, `beam_attack`, `phase_break`,
`idle_exposed`, `core_attack`, `hurt` and `death`.
