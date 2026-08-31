# Level 1 Contaminated Grassland Parallax Runtime Record

- Asset family: `WORLD-L1-GRASSLAND-PARALLAX`
- Generation mode: built-in image generation using the former grassland backdrop as the art-direction reference
- Runtime state: `Integrated` five-layer v2 parallax replacement
- Runtime scene: `scenes/backgrounds/grassland_generated_parallax.tscn`
- Canvas: every runtime layer is 1280 × 720 px
- Filtering: nearest neighbor in Godot
- Gameplay impact: presentation only; collision, encounter, quota, boss, and extraction contracts are unchanged
- Localization impact: none

| Depth | Runtime file | Alpha | Scroll scale | SHA-256 |
|---|---|---:|---:|---|
| Far sky | `grassland_sky_far_v2.png` | Opaque | `(0.018, 0.01)` | `3A1C8969D2235304315DB3D7D9159DAA2C82E865842702FCD7DC1F5C8CF12246` |
| Distant fields | `grassland_fields_far_v2.png` | RGBA | `(0.07, 0.03)` | `6657ED37E25218211FEF42F6813ECC4870DEC691208C7840C767AB3961CBF585` |
| Corruption mid | `grassland_corruption_mid_v2.png` | RGBA | `(0.16, 0.06)` | `C8806AC975C17040F71D6349A64CCDFA625432EC97CEB5D482318B57082CEF8B` |
| Roots near | `grassland_roots_near_v2.png` | RGBA | `(0.34, 0.12)` | `7069E0CC19FC60B3420B759B9AE3A5ED7F94339057376655BA0E9A96BBEC3ABF` |
| Foreground frame | `grassland_foreground_frame_v2.png` | RGBA | `(0.48, 0.16)` | `FAA545DEC16A65FDCCFF4E06D11F9D74B264F63010CA5191F488F11587208FAA` |

## Prompt set

The five generation prompts shared the original contaminated Thai rice-field
palette and painterly pixel-art direction. Individual prompts requested:

1. an opaque far sky and mountain horizon;
2. transparent distant paddies and irrigation lines;
3. transparent corrupted root towers, fence fragments, and purple accents;
4. transparent near rice stalks and root arches;
5. a transparent extreme-foreground foliage/root frame.

All layers were requested as wide 16:9, horizontally repeatable compositions
with no characters, text, logos, or watermark. Transparent layers used only the
simple phrase `transparent background`; each output was visually reviewed and
then verified as `Format32bppArgb` with a zero-alpha corner before promotion.

`tools/normalize_parallax_layer.ps1` performs the aspect-safe crop and
high-quality downscale to the exact 1280 × 720 runtime contract.
