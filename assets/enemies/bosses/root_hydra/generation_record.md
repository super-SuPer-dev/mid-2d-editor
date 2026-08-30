# Root Hydra Runtime Pilot

**Asset ID:** BOSS-ROOT-HYDRA  
**State:** Integrated (pilot; human art and boss-feel review pending)  
**Primary fruit identity:** Nipa-palm fruit cluster  
**Source package:** `art_source/generated/bosses/root_hydra/body/`  
**Promotion date:** 2026-08-31

## Promotion contract

- The source body strip is normalized to exactly 4 × 1000 × 900 px cells.
- The authored bottom alignment baseline is 840 px. Runtime uses a -105 px
  local Y offset and 0.12 visual scale inside the existing 2.25 boss body scale.
- Alpha was quantized with threshold 128. The promoted pilot contains only
  alpha 0 or 255 and uses nearest-neighbor filtering.
- The armored idle strip advances at 3 fps and switches to the exposed idle
  strip at phase 2. During telegraph, the pattern IDs `hydra_head_crossfire`,
  `hydra_offset_rings` and `hydra_water_lane_walls` select the matching
  crossfire, radial-ring and lane-wall cast strips at 8 fps. The existing
  multi-origin projectile pattern runner remains authoritative for combat
  behavior.
- The three cast strips use the same 4 × 1000 × 900 grid, baseline and binary
  alpha contract as the idle states. Remaining death, projectile and
  presentation assets remain source candidates until their runtime contracts
  are wired and reviewed.

## Provenance hashes

| File | SHA-256 |
|---|---|
| `art_source/generated/bosses/root_hydra/body/root_hydra_idle_v1.png` | `D91D3B2A41594D21A2F989A79702E28F3FA0D540D81DA53CDEF6B4F614D529B3` |
| `assets/enemies/bosses/root_hydra/root_hydra_idle_strip_normalized_v2.png` | `2BFEA89E33EF338DD9A8F8A3CF12A55DD1A9C810C6AB2FEA8520866D296C00BC` |
| `art_source/generated/bosses/root_hydra/body/root_hydra_idle_exposed_v1.png` | `5D7F3E1A61008CD419EBBBE9530E0326346E92B5CB438635F912445DFB9C2EAA` |
| `assets/enemies/bosses/root_hydra/root_hydra_idle_exposed_strip_normalized_v2.png` | `8D65E7B26744F28EEDB81FEB0D715B6EDAA8097AFB760BC77A868A91F2CD0610` |
| `art_source/generated/bosses/root_hydra/body/root_hydra_crossfire_attack_v1.png` | `35F288496479742674DCBD76347157A2EC7D1BA0E7FBDA462EAF49029A8A7F83` |
| `assets/enemies/bosses/root_hydra/root_hydra_crossfire_cast_strip_normalized_v2.png` | `E23DE8F06070A3BB97619C964DE1E66390B41E952985EFDFEE4D250BD3EC2A24` |
| `art_source/generated/bosses/root_hydra/body/root_hydra_radial_ring_cast_v1.png` | `5F4E3D59DF6793D3D8FA0BB0900EEC123DD3B5409CD18157CAA3BEDE44F977EE` |
| `assets/enemies/bosses/root_hydra/root_hydra_radial_ring_cast_strip_normalized_v2.png` | `B13FE9320F6B251603F1F8646CDD646DCECD240CF588E32016885002D4ACC6E9` |
| `art_source/generated/bosses/root_hydra/body/root_hydra_lane_wall_cast_v1.png` | `308108475D24CE28F966489344FAA44A45E0EDF743CB32B520DA3858D98F5587` |
| `assets/enemies/bosses/root_hydra/root_hydra_lane_wall_cast_strip_normalized_v2.png` | `7E9BA7A5DA15E55F164923D151501DF144D6159098477EF7A63DB3426FA479CB` |

## Acceptance status

Technical decode, 4-frame grid, binary-alpha, runtime import, baseline,
phase-state and pattern-signal cast-binding checks pass. The package remains
below `Verified` until human review confirms the four-head nipa silhouette,
readable boss scale, projectile contrast, cast readability and phase
presentation in the Level 4 marsh scene.
