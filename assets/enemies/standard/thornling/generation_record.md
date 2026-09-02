# Thornling Runtime Pilot

**Asset ID:** ENEMY-THORNLING  
**State:** Integrated (pilot; human art review pending)  
**Fruit identity:** Rambutan thornling  
**Source package:** `art_source/generated/enemies/thornling/`  
**Promotion date:** 2026-08-31

## Promotion contract

- Idle and run strips are normalized to exactly 4 × 700 × 800 px cells with
  the authored 740 px foot baseline.
- Alpha was quantized with threshold 128. Promoted strips contain only alpha 0
  or 255 and use nearest-neighbor filtering.
- Level 1 Thornlings select the idle strip while stationary and the run strip
  while grounded and moving. Both loops advance at deterministic 4/7 fps.
- The generated attack-tell strip leads the existing 0.35 second contact attack
  timer for 0.13 seconds before handing off to the attack strip; both use 8 fps.
- The generated hurt strip is selected for a 0.2 second damage-reaction window;
  the generated rambutan contact-hit VFX strip is bound to the same enemy.
- The death strip is promoted as a validated runtime candidate but remains staged
  until death presentation can delay cleanup without changing quota behavior.

## Provenance hashes

| File | SHA-256 |
|---|---|
| `art_source/generated/enemies/thornling/thornling_idle_strip_v1.png` | `338ACCC2668B10E6B3786D3A97BD135F69801F4902B938C61F5E86C0C75BED3F` |
| `art_source/generated/enemies/thornling/thornling_run_strip_v1.png` | `1883DCC39AADB8419842CDE29640999C1569FA8CF667253A0DDC3E644230BB21` |
| `assets/enemies/standard/thornling/thornling_idle_strip_normalized_v2.png` | `21FAF484B2F5819D56BBD84C55F35DDCE87ADE7BD102C36C83C05FF0E3ECC545` |
| `assets/enemies/standard/thornling/thornling_run_strip_normalized_v2.png` | `CD0DB525DE99F7777FC05D15F3F381C3D73A92C768E92B99C8219139113205A9` |
| `art_source/generated/enemies/thornling/thornling_attack_strip_v1.png` | `BF20F5E295278A651AE067433C507F9DC791062D697B8E916B78FBC0F482BFFA` |
| `assets/enemies/standard/thornling/thornling_attack_strip_normalized_v2.png` | `4A31CB00C240E7181E0EEB478C6247C56D3AA9568FAA4C2C18004FEA7307AD5C` |
| `art_source/generated/enemies/thornling/thornling_attack_tell_strip_normalized_v1.png` | `4A84B6AEADED1C1B10E4119E038E3CA97A8A44CFEF00A51E6648DFC330C2ED63` |
| `assets/enemies/standard/thornling/thornling_attack_tell_strip_normalized_v2.png` | `90DE588874F0204F4D1FD614AFF5C5FBF0920E6422E6A950BCAE4F6444FD6DED` |
| `art_source/generated/enemies/thornling/thornling_hurt_strip_normalized_v1.png` | `DE759DD82FF1461AA205F1D358D672962DAC77B7C9914B28A79ED3810C9E19B8` |
| `assets/enemies/standard/thornling/thornling_hurt_strip_normalized_v2.png` | `7A87619000C182EF95589A97B5E06B919072B82B4E674652CD88A8A498A7B7D9` |
| `art_source/generated/enemies/thornling/thornling_death_strip_normalized_v1.png` | `FDA2772FEDEA212BB49C5269A290D54D164741638213770220AD3212E879693D` |
| `assets/enemies/standard/thornling/thornling_death_strip_normalized_v2.png` | `86795DE17222A2FF16516D50E8A93C765043EF8ABC6B14F908140DC19B69EE80` |
| `assets/vfx/damage/thornling_contact_hit_normalized_v2.png` | `54F49F3E373C695F914CC577C85E1B460CB7CA071C211A827033A3DF313DCA6B` |

## Acceptance status

Technical decode, 4-frame grid, binary-alpha, runtime import, baseline,
idle/run, attack-tell → attack, hurt and contact-hit state checks pass. The package remains below
`Verified` until human review confirms rambutan identity, grounded silhouette,
attack/hurt readability, death presentation and contrast against the Level 1
grassland background.
