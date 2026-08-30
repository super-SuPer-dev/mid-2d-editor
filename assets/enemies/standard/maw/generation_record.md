# Maw Runtime Pilot

**Asset ID:** ENEMY-MAW  
**State:** Integrated (pilot; human art review pending)  
**Fruit identity:** Mangosteen maw  
**Source package:** `art_source/generated/enemies/maw/`  
**Promotion date:** 2026-08-31

## Promotion contract

- Idle and move strips are normalized to exactly 4 × 700 × 800 px cells with
  the authored 740 px foot baseline.
- Alpha was quantized with threshold 128. Promoted strips contain only alpha 0
  or 255 and use nearest-neighbor filtering.
- Level 2–3 Maws select the idle strip while stationary and the move strip while
  grounded and moving. Both loops advance at deterministic 3.5/6 fps.
- Anticipation, attack, hurt and death strips remain source candidates for later
  integration; collision geometry and contact behavior are unchanged.

## Provenance hashes

| File | SHA-256 |
|---|---|
| `art_source/generated/enemies/maw/maw_idle_strip_v1.png` | `7DC794B78161DCC723B012AC07A4F9F20FE90B0445381172B2161514865200D0` |
| `art_source/generated/enemies/maw/maw_move_strip_v1.png` | `FA6063D566C3FC1DB788E4BD57A5ABD6D94ECD7E9288F80C6718893B0D843B28` |
| `assets/enemies/standard/maw/maw_idle_strip_normalized_v2.png` | `9E82E5A379E5D049D7597919DD936AF7764C36F2373C50419092965609B9F20C` |
| `assets/enemies/standard/maw/maw_move_strip_normalized_v2.png` | `89ABD450B2224E0770D875C838ED0E8191BE113461616BAC15209D7B198B4F79` |

## Acceptance status

Technical decode, 4-frame grid, binary-alpha, runtime import, baseline and
idle/move state checks pass. The package remains below `Verified` until human
review confirms mangosteen identity, grounded silhouette, animation readability
and contrast against the forest and Capsule 07 backgrounds.
