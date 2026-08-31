# Thorn Matriarch Runtime Pilot

**Asset ID:** BOSS-THORN-MATRIARCH  
**State:** Integrated (pilot; human boss-feel review pending)  
**Fruit identity:** Rambutan queen cluster  
**Source package:** `art_source/generated/bosses/thorn_matriarch/`  
**Promotion date:** 2026-08-31

## Promotion contract

- Armored and exposed idle strips are normalized to exactly 4 × 1000 × 900 px
  cells with the authored 840 px foot baseline.
- Alpha was quantized with threshold 128. Promoted strips contain only alpha 0
  or 255 and use nearest-neighbor filtering.
- The Level 1 boss starts with the armored strip and switches to exposed at
  phase 2. Both states advance at 3 fps; the existing fan/lane projectile
  patterns remain authoritative for combat behavior.
- The opening `thorn_fan_three_way` telegraph selects the fan-cast strip and
  the phase-2 `thorn_alternating_lanes` telegraph selects the mine-cast strip.
  Both cast strips use the same 4 × 1000 × 900 grid and are driven by the
  existing pattern signal callbacks.
- Sweep, tell, cast, hurt and death strips, detached projectile art and boss
  presentation frames remain source candidates for later integration.

## Provenance hashes

| File | SHA-256 |
|---|---|
| `art_source/generated/bosses/thorn_matriarch/thorn_matriarch_idle_armored_strip_v1.png` | `7EE664DF694ED003B3B1AC8F445891E479B9FF1B985BAD2384B6A498F011E0BA` |
| `art_source/generated/bosses/thorn_matriarch/thorn_matriarch_idle_exposed_strip_v1.png` | `8AAC6A36ED76F3CD012DB064E61BF654F0D5296444D818EE37EC8DABFCB06663` |
| `assets/enemies/bosses/thorn_matriarch/thorn_matriarch_idle_armored_strip_normalized_v2.png` | `0F286FE33EA2680246EC9DD6BB17A734BA0F7C6937C20E428722EB8DF00B1EF2` |
| `assets/enemies/bosses/thorn_matriarch/thorn_matriarch_idle_exposed_strip_normalized_v2.png` | `8E3D3A9B3EC8AA7A4D2519D3397675145B36D27BA5A55AA07D28113FC0058634` |
| `art_source/generated/bosses/thorn_matriarch/thorn_matriarch_fan_cast_strip_v1.png` | `239168537C9EB259525E2B2323C730C40AD3DB3B476E564764D5CAE7D0DF8AA3` |
| `art_source/generated/bosses/thorn_matriarch/thorn_matriarch_mine_cast_strip_v1.png` | `C0B158469EDA53230E33142E029A395DC83DF874AA15C35A275B11124E4822C7` |
| `assets/enemies/bosses/thorn_matriarch/thorn_matriarch_fan_cast_strip_normalized_v2.png` | `2BB30224EBC8D11215857543E9A0E96186C5043BF2D3E3B41FB66CBF958EF51E` |
| `assets/enemies/bosses/thorn_matriarch/thorn_matriarch_mine_cast_strip_normalized_v2.png` | `CE6EE4606F6E00F2955DC880EF613E5D66A061E629755ADD561DEA84970E53D3` |

## Death promotion

The 4800 × 900 four-frame death strip is promoted to runtime and plays during
the non-blocking defeat lifecycle. SHA-256:
F83DBC7BD057E4A9B437F014C22FB717F76A36C3F9EF93FB6213D2B4A83E6047.

## Acceptance status

Technical decode, 4-frame grid, binary-alpha, runtime import, baseline,
phase-state and fan/mine cast-binding checks pass. The package remains below
`Verified` until human review confirms rambutan identity, boss scale, phase
readability and contrast against the Level 1 grassland arena.
