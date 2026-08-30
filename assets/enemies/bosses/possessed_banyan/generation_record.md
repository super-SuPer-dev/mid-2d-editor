# Possessed Banyan Runtime Pilot

**Asset ID:** BOSS-POSSESSED-BANYAN  
**State:** Integrated (pilot; human boss-feel review pending)  
**Fruit identity:** Jackfruit fused with banyan fig  
**Source package:** `art_source/generated/bosses/possessed_banyan/`  
**Promotion date:** 2026-08-31

## Promotion contract

- Armored and exposed idle strips are normalized to exactly 4 × 1000 × 900 px
  cells with the authored 840 px foot baseline.
- Alpha was quantized with threshold 128. Promoted strips contain only alpha 0
  or 255 and use nearest-neighbor filtering.
- The Level 3 boss starts with the armored strip and switches to exposed at
  phase 2. Both states advance at 3 fps; the existing seed-column/diagonal
  pattern set remains authoritative for combat behavior.
- Root-line casts, attack, hurt, death and phase-break strips, detached
  projectile/VFX art and presentation frames remain source candidates for later
  integration.

## Provenance hashes

| File | SHA-256 |
|---|---|
| `art_source/generated/bosses/possessed_banyan/possessed_banyan_idle_armored_strip_v1.png` | `666D46CB8DB4744168BF66C248E27D5570FCD3A8AC4C5E8A35EB119B25100F1A` |
| `art_source/generated/bosses/possessed_banyan/possessed_banyan_idle_exposed_strip_v1.png` | `E910C1766A85E527DD7484BCC44732A6CE72CA781A3438E4828DCFC82D37D4C4` |
| `assets/enemies/bosses/possessed_banyan/possessed_banyan_idle_armored_strip_normalized_v2.png` | `00160B7330A5BA15CBFABDCB2E3D088919784A3DE5ADAC7CEB157863415CCA78` |
| `assets/enemies/bosses/possessed_banyan/possessed_banyan_idle_exposed_strip_normalized_v2.png` | `A30F3655B200C2043F77C6E6EF3476DD5B67074403559917754C5EA8572A5AD9` |

## Acceptance status

Technical decode, 4-frame grid, binary-alpha, runtime import, baseline and
phase-state checks pass. The package remains below `Verified` until human review
confirms jackfruit/banyan identity, boss scale, phase readability and contrast
against the Level 3 Capsule 07 chamber.
