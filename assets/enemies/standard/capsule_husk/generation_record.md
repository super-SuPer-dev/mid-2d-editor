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
- Charge-tell and core-attack strips are now promoted with a 0.45 second
  contact timer, a 0.17 second tell lead and deterministic 7 fps playback.
- The hurt strip is selected for a 0.2 second damage-reaction window. Charge
  and death strips are staged as validated candidates until their complete
  elite timing and cleanup presentation are authored.

## Provenance hashes

| File | SHA-256 |
|---|---|
| `art_source/generated/enemies/capsule_husk/capsule_husk_idle_strip_v1.png` | `E5D7FE30A98C019F5E037234ADEF6642940811ADA403A70EFB4A2A11E14F409D` |
| `art_source/generated/enemies/capsule_husk/capsule_husk_move_strip_v1.png` | `B0714168CCD025BF76B1426779CD98E505F056FBAA1554088D80DE4037A5251B` |
| `assets/enemies/standard/capsule_husk/capsule_husk_idle_strip_normalized_v2.png` | `3D03D8033F8B6F276E9D67B7E3428923E0FAFA9DB9F4634CF488450DCAFE005B` |
| `assets/enemies/standard/capsule_husk/capsule_husk_move_strip_normalized_v2.png` | `BC6F716BC10BB21D938689587DEACB045620DBE3A973A822241D72EA5794CFEE` |
| `assets/enemies/standard/capsule_husk/capsule_husk_charge_tell_strip_normalized_v2.png` | `73761B4A864FD1AD9B7E8E704F2C844F044321E3370333F78918E76148460874` |
| `assets/enemies/standard/capsule_husk/capsule_husk_charge_strip_normalized_v2.png` | `5B25997C79B78EC6262FFE1F1EA54633DA3FFD82D416FAE2BC25EE4FA0596C8A` |
| `assets/enemies/standard/capsule_husk/capsule_husk_core_attack_strip_normalized_v2.png` | `47C9EA61D318E63EFE8865F7FCA266BBB6AC3F156E108156E4D33DF2B3B312FA` |
| `assets/enemies/standard/capsule_husk/capsule_husk_hurt_strip_normalized_v2.png` | `C8997C882312F90031FA7394F3CE0E9E5B5032CB4B4B3BF1FE4696AE964E94D8` |
| `assets/enemies/standard/capsule_husk/capsule_husk_death_strip_normalized_v2.png` | `4C0E8BCBFFA3204D799515BE25E46B76FE7C816E7663B94E87D8049886CEA14C` |

## Acceptance status

Technical decode, 4-frame grid, binary-alpha, runtime import, baseline,
idle/move, charge-tell → core-attack and hurt state checks pass. The package
remains below `Verified` until human review confirms santol identity, grounded
silhouette, animation readability, staged charge/death presentation and
contrast against the Alien Eye Nexus background.
