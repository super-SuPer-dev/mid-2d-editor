# Capsule Husk Runtime Pilot

**Asset ID:** ENEMY-CAPSULE-HUSK-ELITE  
**State:** Integrated (pilot; human art review pending)  
**Fruit identity:** Santol capsule husk  
**Source package:** `art_source/generated/enemies/capsule_husk/`  
**Promotion date:** 2026-08-31

## Promotion contract

- Idle and move strips are normalized to exactly 4 × 700 × 800 px cells with
  the authored 740 px foot baseline.
- Alpha was quantized with threshold 128. Promoted strips contain only alpha 0
  or 255 and use nearest-neighbor filtering.
- Level 5 Capsule Husk elites select the idle strip while stationary and the
  move strip while grounded and moving. Both loops advance at deterministic
  3.5/5.5 fps.
- Charge, charge-tell, core-attack, hurt and death strips remain source
  candidates for later integration; collision geometry and elite tuning are
  unchanged.

## Provenance hashes

| File | SHA-256 |
|---|---|
| `art_source/generated/enemies/capsule_husk/capsule_husk_idle_strip_v1.png` | `E5D7FE30A98C019F5E037234ADEF6642940811ADA403A70EFB4A2A11E14F409D` |
| `art_source/generated/enemies/capsule_husk/capsule_husk_move_strip_v1.png` | `B0714168CCD025BF76B1426779CD98E505F056FBAA1554088D80DE4037A5251B` |
| `assets/enemies/standard/capsule_husk/capsule_husk_idle_strip_normalized_v2.png` | `3D03D8033F8B6F276E9D67B7E3428923E0FAFA9DB9F4634CF488450DCAFE005B` |
| `assets/enemies/standard/capsule_husk/capsule_husk_move_strip_normalized_v2.png` | `BC6F716BC10BB21D938689587DEACB045620DBE3A973A822241D72EA5794CFEE` |

## Acceptance status

Technical decode, 4-frame grid, binary-alpha, runtime import, baseline and
idle/move state checks pass. The package remains below `Verified` until human
review confirms santol identity, grounded silhouette, animation readability
and contrast against the Alien Eye Nexus background.
