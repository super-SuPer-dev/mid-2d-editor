# BOSS-ROOT-CORE-EYE body animation source set v1

**State:** Review (complete source body contract; not integrated)

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
| `beam_tell` | `exec-b52e4433-290c-42d1-a05c-a1ae071c4983.png` | `8142256ACEE8D15FC53E08AE8E02C9E63B8A846B07E7BF19B0448CA45BE0B4AC` |
| `beam_attack` | `exec-a8e5d01e-04ff-46ee-a71e-b876c7f56ebb.png` | `A24745592AE607DB1ECCE26F37259D2021ACE039DB95A21D115C947743326FD2` |
| `phase_break` | `exec-a958febd-e164-47a4-8a6b-20e7a14c7e25.png` | `03EFA25D36FFD802C9B0C7835738D27696B393796836B2DBDC387277FBED59B4` |
| `idle_exposed` | `exec-f4a03d6e-ba41-4c39-9d99-409c3cedad89.png` | `CF7B48D14A92ADA6E3525C3DAF08D8DC719167984774513E34E2BC4BA2F485C1` |
| `core_attack` | `exec-b15235f7-a5b0-4f5b-938e-5902acea25a6.png` | `FD8B958833D20312B5EC03BCEB89340C7D8556AFBB0E93887829CCFF3B7D8235` |
| `hurt` | `exec-d467630d-f1f3-4ead-8ca3-b3e867f6d3ff.png` | `580AE31DF0E62F82C42A59823DD7ED9C370F28A6B9AC01971ABF24212FDAC6FF` |
| `death` | `exec-20a5f25d-f3ec-4a4f-8feb-12e4fbcb8378.png` | `5095F98C83913CE71EB6FE14E984C0526A8F9A543462D55C6623AF13BF01D106` |

All thirteen normalized outputs are 32-bit ARGB PNGs with transparent corner
pixels, one complete connected boss per cell, a planted baseline and no baked
detached projectile bodies or language-specific text. Visual review confirms
that the permanent death pose remains grounded and does not float.

## Prompt contracts

All prompts used the sealed idle strip or pixel identity board as the
authoritative design reference and ended with `Transparent background.`

- `idle_sealed`: root pedestal flex, closed bract breathing, staggered blinks
  across five crown eyes and a dim-medium-dim cyan-vein pulse.
- `awaken_tell`: bracts tighten, split along pale flesh, reveal the huge glossy
  black central seed, then hold the fully open eye without firing.
- `aimed_seed_cast`: five pupils track screen-left, alternating eye-pods glow,
  then flash at separate muzzle origins.
- `spiral_cast`: central pupil opens, five eye-pods rotate clockwise, their
  pupils flash as a spiral and recoil counterclockwise.
- `bract_curtain_cast`: outer bracts spread into paired blade fans, alternate
  downward/upward lane directions, mirror, then sweep inward.
- `radial_ring_cast`: central seed opens, five eye-pods spread into an even
  crown, flash and relax at staggered timing.
- `beam_tell`: smaller pupils close while the central longan seed tracks left,
  gathers violet light, forms a narrow crosshair and holds before firing.
- `beam_attack`: the central seed releases a short attached muzzle lance,
  contracts, recoils through its flesh ring and returns to combat posture.
- `phase_break`: the seed cracks, pale flesh swells, bract armor peels away and
  settles into a readable exposed-core state without detached debris.
- `idle_exposed`: the cracked seed pulses while pale flesh, peeled bracts,
  dimmer eye-pods and cyan root veins move without shifting the pedestal.
- `core_attack`: the flesh ring clamps, charges the fractures, snaps open with
  an attached shockwave rim and recoils without detached radial bullets.
- `hurt`: the cracked seed flashes, smaller pupils shut, pale flesh partly
  clamps over the core and the roots compress before recovery.
- `death`: the seed overloads, the flesh ring collapses, bracts wilt, the crown
  folds and the boss ends as a permanent low grounded husk.

Every prompt required four equal horizontal cells, identical scale, no
floating, no detached projectiles, no scenery/floor/UI/text/watermarks/grid
lines, generous transparent separation, no cropped roots or bracts, and ended
with `Transparent background.` The complete body source contract contains
thirteen actions and 52 frames. Runtime timing, collision shapes, emissions,
final VFX/SFX and engine validation remain separate integration work.
