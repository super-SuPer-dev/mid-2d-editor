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


## Pixel-art v3 parallax and terrain pass (2026-09-01)

Tool: built-in ImageGen, generated one layer at a time and visually validated before continuing. Local-file edit ingestion was blocked by the Windows ACL helper, so the validated gameplay capture and preceding accepted layer were used as visual references.

Shared prompt direction: authentic 16-bit side-scroller pixel art; deliberate hard-edged 4 x 4 pixel clusters; limited indexed-color feel; crisp stepped silhouettes; consistent pixel density; horizontally repeatable; no blur, antialiasing, smooth gradients, painterly brushwork, text, logo, or watermark. Transparent layers used the simple phrase `transparent background`.

Layer prompts:
- Sky: opaque teal contaminated sky, low distant Thai rice-field mountains, sparse trees, quiet lower half.
- Fields: distant Thai rice paddies, irrigation banks, fence posts, rural trees, restrained purple sprouts; transparent upper sky.
- Corruption: irrigation structures, broken fences, black root towers, thorn vines, purple alien growths; transparent background.
- Near roots: sparse close rice stalks, root arches, posts, thorn vines along lower third and sides; transparent center.
- Foreground: very sparse rice leaves, root tips, spores, and stakes along the bottom edge/corners; at least 75% transparent.
- Terrain tile: seamless side-view platform with uneven grass lip, layered reddish soil, stones, roots, purple contamination veins, and lower-edge shadow; transparent background.

Normalization: nearest-neighbor crop/resize to 1280 x 720 for parallax layers and 576 x 192 for the platform tile. SHA-256: sky `5183F1EA05139BD599FCAE4B512B002EE59B533586C530A08F06358E772CC37C`; fields `A1029A47BE7B7F55343B09D4520425CD41DF30E13062D897FB72711DE5330A69`; corruption `396A637CCFB5208943B1B155B32D50FC5AB46AAFCA8975B0E2847BC79578C12D`; near roots `B4A90035BB8489B0076B97C5CA2EA13B4F9AEDBEAC07D5875FB1B77E050E9B8E`; foreground `AFB07D992B5FA00364A846C3F84E6D931B29175B7F556D97216477BDE21C1383`; terrain `D7F434B9D78D9129D35240FC888D4CC42C48A63B92C8AAEFEDE94137275462BD`.


## Dense floor wall v3 (2026-09-01)

Tool: built-in ImageGen. Image 1 (the reported gameplay screenshot) was used as a style/reference image only. The generated output was visually reviewed before integration, then normalized with nearest-neighbor sampling to a 512 x 512 opaque runtime texture.

Final prompt: seamless pixel-art underground wall/floor texture for the contaminated grassland; densely packed tangled roots, layered reddish-brown soil, small stones, buried irrigation fragments, and restrained purple contamination veins; authentic crisp 16-bit art with hard 4 x 4 pixel clusters and indexed-palette feel; straight-on side view; evenly distributed detail; tileable on all four edges; no grass top, text, logo, watermark, blur, antialiasing, gradients, painterly rendering, empty flat regions, obvious square seams, or large focal objects.

Runtime file: `assets/world/grassland/dense_floor_wall_pixel_v3.png`. SHA-256: `00486D5124CB8D637A3E38D8775710D2610EE22268F8BDE84AFC5BA3C8D5B4DF`.
