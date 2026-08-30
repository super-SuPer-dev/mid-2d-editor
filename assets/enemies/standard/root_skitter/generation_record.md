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
- The runtime pilot currently animates idle at 5.5 fps and scuttle at 8 fps;
  other action strips are retained for the next animation pass.

## Provenance hashes

| File | SHA-256 |
|---|---|
| `art_source/generated/enemies/root_skitter/root_skitter_idle_strip_v1.png` | `FE34A1F522D787C8F327D65936478EFD04BF538014472544AF9D780F9FC84DE6` |
| `art_source/generated/enemies/root_skitter/root_skitter_scuttle_strip_v1.png` | `11232BDA4CE054D3CAB0DABC50C5DC5F09C34D5C4EE092D21EFE86C6A49C6A2A` |
| `assets/enemies/standard/root_skitter/root_skitter_idle_strip_normalized_v2.png` | `8FF0BB13CF186208ABC11ED23E5474BE45C9211B376617B2C75F51D05FBD8626` |
| `assets/enemies/standard/root_skitter/root_skitter_scuttle_strip_normalized_v2.png` | `73EEEFCB8BD22E746B73B05AF939D7FB811F948FBFAB1CFAC49419AA373F06F4` |

## Acceptance status

Technical decode, grid, binary-alpha, runtime import and animation-state checks
pass. The package remains below `Verified` until human review confirms salak
silhouette, foot placement, motion continuity, combat-scale readability and
visual fit with the Level 4 marsh palette.
