# BOSS-MAW-SOVEREIGN presentation source set v1

**State:** Review (not integrated)

**Generation mode:** Built-in image generation

**Fruit identity:** Durian crown + mangosteen anatomy / มงกุฎทุเรียน + กายมังคุด

**Localization contract:** All generated presentation art is text-free. Boss
name, warning, phase and accessibility text must be rendered at runtime from
localization keys. Portrait and title/health openings are transparent; the
three small HUD phase sockets retain a dark backing for icon contrast.

## Package contract

| Asset | Grid / canvas | Runtime intent |
|---|---|---|
| Portrait states | 3 x 1, 800 x 800 cells | Armored, enraged/exposed and damaged/wilting crops |
| Boss-intro frame | 1800 x 1000 | Left portrait socket plus large title-safe opening |
| Boss-HUD frame | 2200 x 800 | Portrait socket, health opening and three phase sockets |
| Phase markers | 3 x 1, 800 x 800 cells | Closed armor, cracking bloom and exposed seed |

Normalized assets preserve the built-in pixel detail without rescaling or
interpolation. Grid-cell normalization isolates the three portrait/icon states
and preserves all alpha inside each authored cell.

## Validation hashes

| Candidate | SHA-256 |
|---|---|
| `maw_sovereign_portrait_states_normalized_v1.png` | `0EEB715E29E90AA1BB91EBC8B48CD9D4B1F3AFCF0DEEC1DE44FA9E53E190F941` |
| `maw_sovereign_intro_frame_normalized_v1.png` | `9A699732DA1D6B722C9C6454EB9B4DA61C0E541AE0903B8C7FC36CA824568AE8` |
| `maw_sovereign_boss_hud_frame_normalized_v1.png` | `D7C656B1F8543246EB901D9B8D917B6DC7DD048B23FF4954FA6A6630FB62C636` |
| `maw_sovereign_phase_markers_normalized_v1.png` | `891DC4FBC7F1843AEF9E1999C43B5B8DBE42F3FA126E949458F3EE65734617B0` |

All normalized outputs are `Format32bppArgb` with transparent corner pixels.
Direct alpha sampling confirmed transparent intro portrait/title openings and
transparent HUD portrait/health openings. Visual review confirmed stable
portrait crops, distinct phase states, empty runtime-text regions, and no
baked English or Thai text. Integration still requires a 1280 x 720 layout
pass, logical downscale, nearest-neighbor imports, localized label fitting,
contrast checks and Windows/Web validation.

## Built-in source provenance

| Asset | Preserved built-in output |
|---|---|
| Portrait states | `exec-22806dcf-6ceb-4bda-a72e-3164977b4c8d.png` |
| Intro frame | `exec-d1cedae6-f751-4ab0-8186-0de3f67622ba.png` |
| Boss-HUD frame, accepted transparent-layout retry | `exec-ac24a9cc-bd55-4058-8979-0ebbc5b7582d.png` |
| Phase markers | `exec-3ab3b50c-7dbc-44d5-ae25-99f1f63cb4a7.png` |

The initial HUD candidate and two background-extraction retries retained a
semi-opaque matte and were rejected rather than packaged. The accepted HUD was
regenerated from the already validated Thorn Matriarch HUD transparency/layout
structure while replacing only the biological art language.

## Prompts

### Portrait states

> Use case: stylized-concept
>
> Asset type: game boss portrait-state strip
>
> Input images: Image 1 is the authoritative armored Maw Bloom Sovereign;
> Image 2 is the authoritative exposed-bloom phase. Preserve their exact
> durian-crown, mangosteen-jaw, white segmented flesh, glossy dark seed, purple
> spore nodes, green-gold rind, detailed high-resolution pixel-art density,
> palette, and upper-left lighting.
>
> Create a three-frame horizontal portrait strip for boss introductions,
> warnings, and the boss HUD. Show a consistent close portrait crop of the
> crown, jaw/bloom, central seed area, and upper rooted body without the feet.
> States: armored royal menace with the durian jaw partly closed; enraged
> exposed bloom with white flesh ring and glossy dark seed fully visible;
> damaged wilting exposed bloom with uneven rind petals and a dim
> cracked-looking seed, non-gory. Use a slight three-quarter view facing toward
> the viewer. No frame, text, symbols, scenery, projectiles, floor, labels, or
> watermark.
>
> Exactly three equal cells in one horizontal row, one complete portrait per
> cell, identical crop and scale, generous transparent separation, no overlap,
> no grid lines.
>
> Transparent background.

### Boss-intro frame

> Use case: stylized-concept
>
> Asset type: game boss-introduction overlay frame
>
> Input images: Image 1 establishes the Maw Bloom Sovereign's detailed
> high-resolution pixel-art material language: green-gold durian armor, purple
> mangosteen rind, white flesh, dark glossy seed, brown roots, violet energy,
> and toxic-lime spores.
>
> Create one wide horizontal pixel-art overlay frame for a boss introduction
> at 1280x720. Build a thin asymmetrical border combining dark charcoal ACO
> field metal, restrained antique brass joints, curling brown-gold roots,
> green-gold durian thorns, purple mangosteen rind plates, small white flesh
> accents, violet seams, and sparse toxic-lime spores. Place one circular
> transparent portrait socket on the left and a large clean transparent
> title-safe opening across the center and right for runtime English or Thai
> text. Keep decoration around the edges only, with a strong readable
> silhouette and no opaque background fill. No boss portrait inside the
> socket, no words, letters, numbers, logos, health fill, scenery, screen
> mockup, labels, or watermark.
>
> One isolated complete frame, wide landscape composition.
>
> Transparent background.

### Boss-HUD frame, accepted retry

> Use case: style-transfer
>
> Asset type: game boss HUD frame
>
> Input images: Image 1 is the required compact HUD layout and transparency
> structure. Image 2 supplies the Maw Bloom Sovereign fruit materials and
> detailed high-resolution pixel-art style.
>
> Create the Maw Sovereign version of Image 1. Keep its long shallow
> silhouette, left portrait socket, central health opening, three right phase
> sockets, compact proportions, and transparent surrounding canvas. Replace
> the rambutan decoration with green-gold durian thorn plates, purple
> mangosteen rind, white flesh accents, brown roots, violet filaments, and
> sparse toxic-lime spores from Image 2. No portrait, health fill, text,
> numbers, logos, scenery, screen mockup, or watermark.
>
> Transparent background.

### Phase markers

> Use case: stylized-concept
>
> Asset type: game boss phase-icon strip
>
> Input images: Image 1 establishes the exact Maw Bloom Sovereign fruit
> identity, detailed high-resolution pixel-art density, palette, outline
> weight, and lighting.
>
> Create a three-cell horizontal strip of compact circular boss phase icons.
> Icon one: closed green-gold durian armor enclosing a purple mangosteen jaw.
> Icon two: cracked durian crown with purple rind opening and white mangosteen
> flesh beginning to show. Icon three: fully exposed glossy dark mangosteen
> seed surrounded by a clean white segmented flesh ring and open purple-green
> rind petals. Give all three icons the same thin dark-charcoal and
> antique-brass circular socket rim, scale, pixel density, outline weight, and
> upper-left lighting. Make each phase readable at small HUD size. No words,
> numbers, boss body, scenery, labels, extra symbols, or watermark.
>
> Exactly three equal cells in one horizontal row, one complete centered icon
> per cell, generous transparent separation, no overlap, no grid lines.
>
> Transparent background.
