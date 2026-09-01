# Operator Sprite Sheet Runtime Record

- Asset family: `CHAR-*-SHEET`
- Generation mode: built-in image generation, using each v2 runtime sheet as the identity/style reference
- Runtime state: `Integrated` leak-safe v3 replacement
- Canvas: 1120 × 1400 px, 4 columns × 5 rows, 280 × 280 px cells
- Alpha: validated RGBA source outputs, normalized to binary alpha
- Grid safety: the main connected component of every cell is isolated and fitted inside a 20 px protected gutter
- Runtime filtering: nearest neighbor; atlas frames retain an additional 8 px sampling inset
- Animation contract: row 0 idle, row 1 run, row 2 attack, row 3 dash, row 4 hurt/recovery
- Runtime cadence: idle 6 fps, run 10 fps, attack 16 fps, dash 16 fps
- Localization impact: none

| Operator ID | Runtime file | SHA-256 |
|---|---|---|
| `tonkla` | `tonkla_sprite_sheet_generated_v3.png` | `FFB787993C53C5AF36D0FB2A7F81E7453899C24CD3CBFF28B94DF7A9B24B174D` |
| `rin` | `rin_sprite_sheet_generated_v3.png` | `47AA6930D27BC601DE29B2F5E7E9BE208D2C6B620D80EDE2D919B349A566B0E0` |
| `khem` | `khem_sprite_sheet_generated_v3.png` | `33C580E758096AAD5375D792070392A35E494B13C2CFA6BB3DE954619232DDB9` |
| `t800` | `t800_sprite_sheet_generated_v3.png` | `BBAADF1F88BFCF5805DA705A77F94CBF48BEB0287613EEDF611197B14E28DA50` |

## Prompt set

Each operator used the same production structure with identity-specific invariants:

- regenerate the same operator from the supplied sheet reference;
- create an exact 4-column × 5-row grid;
- provide progressive idle, run, attack, dash, and hurt/recovery poses;
- preserve face/body, outfit, equipment, proportions, palette, and silhouette;
- use polished painterly pixel art with crisp edges;
- transparent background; no grid lines, labels, text, logos, or watermark.

Only the simple phrase `transparent background` was used for alpha behavior.
Two rejected RGB/checkerboard drafts were not integrated.

## Grid QA

`tools/normalize_operator_grid.ps1` and
`tools/operator_sheet_grid_processor.cs` crop the validated 1122 × 1402
generator result by one outer pixel per side, isolate each cell, preserve the
largest connected artwork component, fit it to the 240 × 240 safe area, and
fail if any nontransparent pixel enters a protected gutter.

Human-readable proofs are stored in `validation/sprite_grids/`. Magenta lines
mark the exact 280 px dividers and green rectangles mark the protected gutters.
`tools/validate_operator_sprite_grids.ps1` repeats the alpha/dimension/gutter
gate without regenerating the sheets.


## v4 subject-preserving grid correction (2026-09-01)

- Built-in ImageGen source sheets reused from the v3 generation pass; no new identity redesign.
- Runtime outputs: `tonkla_sprite_sheet_generated_v4.png`, `rin_sprite_sheet_generated_v4.png`, `khem_sprite_sheet_generated_v4.png`, `t800_sprite_sheet_generated_v4.png`.
- Processor change: retain the main body plus nearby meaningful disconnected components (boots, tools, rifle, backpack parts); reject edge-touching spill fragments; fit complete subject into a 240 x 240 safe area in each 280 x 280 cell.
- Grid remains exact 4 columns x 5 rows at 1120 x 1400 with 20 px protected gutters; runtime frame inset is 0 px.
- SHA-256: Tonkla `FBD0164C487D009FA5B10C707794B55C926920FE4648126990AAC9027F659B25`; Rin `A0B006F85FFAA9A647A1F05F1194BC5ED10270EA87FDF8A3D58796B3BF83C281`; Khem `1735F962F9429B55BD5AA6DE0B3CC8AFCBABFD622B89DE5ACFE5FD9D8C46F05E`; T-800 `9438B945AF37BF2562599E15BF826BF48B6E6CFD8F99864E083696EA3212A1C7`.
