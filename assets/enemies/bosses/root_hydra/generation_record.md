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
  strip at phase 2; the existing multi-origin projectile pattern runner remains
  authoritative for combat behavior.
- Other authored body phases, projectile strips and presentation assets remain
  source candidates until their runtime contracts are wired and reviewed.

## Provenance hashes

| File | SHA-256 |
|---|---|
| `art_source/generated/bosses/root_hydra/body/root_hydra_idle_v1.png` | `D91D3B2A41594D21A2F989A79702E28F3FA0D540D81DA53CDEF6B4F614D529B3` |
| `assets/enemies/bosses/root_hydra/root_hydra_idle_strip_normalized_v2.png` | `2BFEA89E33EF338DD9A8F8A3CF12A55DD1A9C810C6AB2FEA8520866D296C00BC` |
| `art_source/generated/bosses/root_hydra/body/root_hydra_idle_exposed_v1.png` | `5D7F3E1A61008CD419EBBBE9530E0326346E92B5CB438635F912445DFB9C2EAA` |
| `assets/enemies/bosses/root_hydra/root_hydra_idle_exposed_strip_normalized_v2.png` | `8D65E7B26744F28EEDB81FEB0D715B6EDAA8097AFB760BC77A868A91F2CD0610` |

## Acceptance status

Technical decode, 4-frame grid, binary-alpha, runtime import, baseline and
phase-state checks pass. The package remains below `Verified` until human review
confirms the four-head nipa silhouette, readable boss scale, projectile contrast
and phase presentation in the Level 4 marsh scene.
