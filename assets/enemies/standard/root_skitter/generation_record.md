# Root Skitter Runtime Pilot

**Asset ID:** ENEMY-ROOT-SKITTER  
**State:** Integrated (pilot; human art review pending)  
**Primary fruit identity:** Salak (snake fruit)  
**Source package:** `art_source/generated/enemies/root_skitter/`  
**Promotion date:** 2026-08-31

## Promotion contract

- Source strips are four-frame action sheets at approximately 2,172 × 724 px.
- Runtime strips are normalized to exactly 4 × 700 × 800 px cells.
- The bottom alignment baseline is 740 px; the runtime Sprite2D uses a -17 px
  local Y offset and 0.05 scale to keep the visible root on the floor.
- Alpha was quantized with threshold 128. The promoted pilot contains only
  alpha 0 or 255 and uses nearest-neighbor filtering.
- The runtime pilot now selects burrow-tell → burrow → emerge-attack from a
  0.5 second contact timer at 8 fps, with a 0.2 second hurt reaction. Idle and
  scuttle remain 5.5/8 fps. The death strip is staged for delayed cleanup.

## Provenance hashes

| File | SHA-256 |
|---|---|
| `art_source/generated/enemies/root_skitter/root_skitter_idle_strip_v1.png` | `FE34A1F522D787C8F327D65936478EFD04BF538014472544AF9D780F9FC84DE6` |
| `art_source/generated/enemies/root_skitter/root_skitter_scuttle_strip_v1.png` | `11232BDA4CE054D3CAB0DABC50C5DC5F09C34D5C4EE092D21EFE86C6A49C6A2A` |
| `assets/enemies/standard/root_skitter/root_skitter_idle_strip_normalized_v2.png` | `8FF0BB13CF186208ABC11ED23E5474BE45C9211B376617B2C75F51D05FBD8626` |
| `assets/enemies/standard/root_skitter/root_skitter_scuttle_strip_normalized_v2.png` | `73EEEFCB8BD22E746B73B05AF939D7FB811F948FBFAB1CFAC49419AA373F06F4` |
| `assets/enemies/standard/root_skitter/root_skitter_burrow_tell_strip_normalized_v2.png` | `384510957203E70AF05FEA9D71F63367C34A5274AFD2FA4D3A1650C91E6E2B67` |
| `assets/enemies/standard/root_skitter/root_skitter_burrow_strip_normalized_v2.png` | `4C6E44A854A70CED88DD72FFF9DDC752CC80C639717EBC65CF9F1485379C623B` |
| `assets/enemies/standard/root_skitter/root_skitter_emerge_attack_strip_normalized_v2.png` | `76FA845B64C56ADADCB15E9B673959E6A5EBFD7C9361FAB8506EAC117D6F07C3` |
| `assets/enemies/standard/root_skitter/root_skitter_hurt_strip_normalized_v2.png` | `F8FE4F7C9590B44605726845C0F1928CF267B38E591BFDE572645D086C3DF92A` |
| `assets/enemies/standard/root_skitter/root_skitter_death_strip_normalized_v2.png` | `238216DD067312104EDFF49557856AFE90411CACAA7FF700E679149ACB9D1D58` |

## Acceptance status

Technical decode, grid, binary-alpha, runtime import, baseline, burrow-tell →
emerge-attack and hurt state checks pass. The package remains below `Verified`
until human review confirms salak silhouette, foot placement, motion continuity,
death presentation, combat-scale readability and visual fit with the Level 4
marsh palette.
