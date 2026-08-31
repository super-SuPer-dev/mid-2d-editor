# Operator Sprite Sheet Runtime Record

- Asset family: `CHAR-*-SHEET`
- Source package: `art_source/generated/character/`
- Runtime state: `Integrated` exact-grid replacement
- Canvas: 1120 × 1400 px, 4 columns × 5 rows, 280 × 280 px cells
- Alpha: binary thresholded runtime copies; nearest filtering; no neighboring-cell bleed
- Animation contract: row 0 idle, row 1 run, row 2 attack, row 3 dash; row 4 reserved for future hurt/death states
- Localization impact: none in raster assets; names, roles and descriptions remain localization keys

| Operator ID | Generated source | Runtime file | SHA-256 |
|---|---|---|---|
| `tonkla` | `art_source/generated/character/tonkla.png` | `tonkla_sprite_sheet_generated_v2.png` | `B1CC77A943190F12FBCBE39178601B290E81191454F033C4ECB587B834F586BF` |
| `rin` | `art_source/generated/character/jintana.png` | `rin_sprite_sheet_generated_v2.png` | `0E94D61D9EC98F0A3EE64F14E818131DD479AC6CAF129A5A32DB8659CFC20CB1` |
| `khem` | `art_source/generated/character/esan-farmer.png` | `khem_sprite_sheet_generated_v2.png` | `497619C24CF5B0AFB17E1A630B9470DEB55F2E49269690BA7F071D4FA63972C7` |
| `t800` | `art_source/generated/character/t800.png` | `t800_sprite_sheet_generated_v2.png` | `C0CB5A08013C4995A2FF00B9E59B5B25B3FDAABDF21FE4D0AEB6A1D8FCF34BC6` |

The 1122 × 1402 generated canvases are cropped from the top-left to the exact
1120 × 1400 grid before alpha thresholding. The former runtime copies are
preserved under `art_source/legacy/character/runtime_v1/` for rollback and are
not referenced by runtime code. Headless smoke checks enforce dimensions and
280 px atlas slicing; live Godot character-select review confirms all four
operators render without stretch or visible cell bleed. Full animation,
foot-baseline and human pixel-art review remain open before `Verified`.
