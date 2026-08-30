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
- Attack, tell, hurt and death strips remain source candidates for later
  integration; combat behavior and collision geometry are unchanged.

## Provenance hashes

| File | SHA-256 |
|---|---|
| `art_source/generated/enemies/thornling/thornling_idle_strip_v1.png` | `338ACCC2668B10E6B3786D3A97BD135F69801F4902B938C61F5E86C0C75BED3F` |
| `art_source/generated/enemies/thornling/thornling_run_strip_v1.png` | `1883DCC39AADB8419842CDE29640999C1569FA8CF667253A0DDC3E644230BB21` |
| `assets/enemies/standard/thornling/thornling_idle_strip_normalized_v2.png` | `21FAF484B2F5819D56BBD84C55F35DDCE87ADE7BD102C36C83C05FF0E3ECC545` |
| `assets/enemies/standard/thornling/thornling_run_strip_normalized_v2.png` | `CD0DB525DE99F7777FC05D15F3F381C3D73A92C768E92B99C8219139113205A9` |

## Acceptance status

Technical decode, 4-frame grid, binary-alpha, runtime import, baseline and
idle/run state checks pass. The package remains below `Verified` until human
review confirms rambutan identity, grounded silhouette, animation readability
and contrast against the Level 1 grassland background.
