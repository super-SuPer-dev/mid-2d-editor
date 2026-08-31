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
- Anticipation and attack strips are now promoted with a 0.4 second contact
  timer, a 0.16 second anticipation lead and deterministic 7 fps playback.
- The hurt strip is selected for a 0.2 second damage-reaction window. The death
  strip is staged as a validated candidate until cleanup can be delayed without
  changing quota behavior.

## Provenance hashes

| File | SHA-256 |
|---|---|
| `art_source/generated/enemies/maw/maw_idle_strip_v1.png` | `7DC794B78161DCC723B012AC07A4F9F20FE90B0445381172B2161514865200D0` |
| `art_source/generated/enemies/maw/maw_move_strip_v1.png` | `FA6063D566C3FC1DB788E4BD57A5ABD6D94ECD7E9288F80C6718893B0D843B28` |
| `assets/enemies/standard/maw/maw_idle_strip_normalized_v2.png` | `9E82E5A379E5D049D7597919DD936AF7764C36F2373C50419092965609B9F20C` |
| `assets/enemies/standard/maw/maw_move_strip_normalized_v2.png` | `89ABD450B2224E0770D875C838ED0E8191BE113461616BAC15209D7B198B4F79` |
| `assets/enemies/standard/maw/maw_anticipation_strip_normalized_v2.png` | `A9EDDA2BD17442DADD948B052B391820E3FF9B2063B73CB4E2E4F126783480BF` |
| `assets/enemies/standard/maw/maw_attack_strip_normalized_v2.png` | `8862CA342E81E0C6955E34F7E97E269974B50819DE1343BD9C2383AA8D3D1268` |
| `assets/enemies/standard/maw/maw_hurt_strip_normalized_v2.png` | `C0163BF7563163C4BA293614EA6EC7B0AEB9D282759BE761CC6629397660F6C8` |
| `assets/enemies/standard/maw/maw_death_strip_normalized_v2.png` | `2C024D1933ED4933506831D12B16238F6D75CF7FC8DD8C4E3CE61FF74A6993F0` |

## Acceptance status

Technical decode, 4-frame grid, binary-alpha, runtime import, baseline,
idle/move, anticipation → attack and hurt state checks pass. The package remains
below `Verified` until human review confirms mangosteen identity, grounded
silhouette, animation readability, staged death presentation and contrast
against the forest and Capsule 07 backgrounds.
