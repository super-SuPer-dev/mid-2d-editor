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
- The `banyan_seed_columns` and `banyan_diagonal_roots` telegraphs select the
  matching seed-column and diagonal-root cast strips. Casts use the same
  4 × 1000 × 900 grid and are driven by the existing pattern signal callbacks.
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
| `art_source/generated/bosses/possessed_banyan/possessed_banyan_seed_column_cast_strip_v1.png` | `A78D47BF9D01405DFBD0BBED513E2E93342CF0EA60BBFA31F9C4CD67BE6CF987` |
| `art_source/generated/bosses/possessed_banyan/possessed_banyan_diagonal_root_cast_strip_v1.png` | `42DBC89BB0ADD4814FFC26B71ECA899188ED604D85E321AE6E4017AB1E1090EE` |
| `assets/enemies/bosses/possessed_banyan/possessed_banyan_seed_column_cast_strip_normalized_v2.png` | `108D72873A574300815193D523FE00DE56E317DA03780536DB71F99E4934EA8F` |
| `assets/enemies/bosses/possessed_banyan/possessed_banyan_diagonal_root_cast_strip_normalized_v2.png` | `AA3C04A14D85318F84DB2835E8CB4125D3B18CFB407FF7108785B0ECE25C99BC` |

## Acceptance status

Technical decode, 4-frame grid, binary-alpha, runtime import, baseline,
phase-state and cast-binding checks pass. The package remains below `Verified`
until human review confirms jackfruit/banyan identity, boss scale, phase
readability and contrast against the Level 3 Capsule 07 chamber.
