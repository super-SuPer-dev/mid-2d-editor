# BOSS-POSSESSED-BANYAN presentation source set v1

**State:** Review (not integrated)

**Generation mode:** Built-in image generation

**Fruit identity:** Jackfruit + banyan fig / ขนุน + ลูกไทร

**Localization contract:** All generated presentation art is text-free. Boss
name, warning, phase and accessibility text must be rendered at runtime from
localization keys. Portrait, title and health openings use true alpha; the
three small HUD phase sockets retain a dark backing for icon contrast.

## Package contract

| Asset | Grid / canvas | Runtime intent |
|---|---|---|
| Portrait states | 3 x 1, 900 x 900 cells | Armored, exposed/enraged and damaged/wilting crops |
| Boss-intro frame | 1800 x 1000 | Left portrait socket plus large title-safe opening |
| Boss-HUD frame | 2200 x 800 | Portrait socket, health opening and three phase sockets |
| Phase markers | 3 x 1, 900 x 900 cells | Closed rind, cracked fibers and exposed heart |

Normalized assets preserve the authored pixel detail without interpolation.
Grid-cell normalization isolates the three portrait/icon states and preserves
detached leaves, roots and glow inside each authored cell.

## Validation hashes

| Candidate | SHA-256 |
|---|---|
| `possessed_banyan_portrait_states_normalized_v1.png` | `1E15775A63E94CA00512B20387B6CACFB63CF3DC373D25FA571FC597C48AAD57` |
| `possessed_banyan_intro_frame_normalized_v1.png` | `4286254ABBBA25D3AA9A766818C57A12B1F9AF48A21A86FA34C6CA1999D07E4A` |
| `possessed_banyan_boss_hud_frame_normalized_v2.png` | `F8E73F8C45BAE4509F0509DB86263A136FA65855667C08B16BA40ACC471AA35D` |
| `possessed_banyan_phase_markers_normalized_v1.png` | `84AF997D8361A5189E8044128D1CD16E370BFE02B8FACF1585DF39C2BDE07B47` |

All accepted normalized outputs are `Format32bppArgb` with transparent corner
pixels. Direct alpha sampling confirmed transparent intro portrait/title
openings and transparent HUD portrait/health openings. Visual review confirmed
stable portrait crops, distinct phase states, empty runtime-text regions and no
baked English or Thai text. Integration still requires a 1280 x 720 layout
pass, logical downscale, nearest-neighbor imports, localized label fitting,
contrast checks and Windows/Web validation.

## Built-in source provenance

| Asset | Preserved built-in output |
|---|---|
| Portrait states | `exec-16f5667b-1413-4eac-a80b-0faa9677839b.png` |
| Intro frame | `exec-f8d4d3ef-7f97-465c-ba44-ed8607713a4c.png` |
| Boss-HUD frame, accepted transparent retry | `exec-9070fc2a-1031-437f-ab07-c1787a592e10.png` |
| Phase markers | `exec-5e32b6d0-6eae-4155-bf5a-8774f74fbe6b.png` |

The initial HUD candidate retained an opaque checkerboard matte and its first
transparency-only edit produced a gradient matte. Both were rejected. The
accepted v2 HUD was regenerated from the validated Thorn Matriarch HUD layout
and transparency structure while applying the Possessed Banyan materials.

## Prompts

### Portrait states

> Use case: stylized-concept
>
> Asset type: game boss portrait-state strip
>
> Input images: Image 1 is the authoritative armored Possessed Banyan; Image 2
> is the authoritative exposed-heart phase. Preserve their exact jackfruit
> chest, hexagonal rind, golden fibers, glossy seed ring, violet Capsule heart,
> gnarled banyan bark, red-purple fig sensors, leaves, detailed high-resolution
> pixel-art density, palette, and upper-left lighting.
>
> Create a three-frame horizontal portrait strip for boss introduction and HUD.
> Use one consistent close crop of the leafy crown, fig-bearing aerial roots,
> vertical jackfruit chest, and upper trunk without the root feet. States:
> armored ancient menace with closed rind; exposed enraged heart framed by
> golden fiber and glossy seeds; damaged wilting exposed form with dim heart,
> drooping leaves, and uneven fibers, non-gory. Use a slight three-quarter angle
> facing toward the viewer. No frame, text, symbols, scenery, projectiles,
> floor, labels, or watermark.
>
> Exactly three equal cells in one horizontal row, one complete portrait per
> cell, identical crop and scale, generous transparent separation, no overlap,
> no grid lines.
>
> Transparent background.

### Boss-intro frame

> Use case: stylized-concept
>
> Asset type: wide game boss introduction frame
>
> Input image: authoritative Possessed Banyan portrait states. Match its
> detailed high-resolution original pixel-art density, palette, upper-left
> lighting, gnarled banyan bark, green jackfruit hexagonal rind, golden fibers,
> glossy dark seeds, red-purple fig sensors, violet alien heart glow, and leafy
> Thai forest character.
>
> Create one wide ornamental boss-introduction UI frame for a dark Thai sci-fi
> action-platformer inspired by Gothic metroidvania presentation. Text-free UI
> asset only. Dark charcoal ACO containment metal fused with ancient banyan
> roots, aged brass braces, green jackfruit rind plates, golden fibrous veins,
> sparse red-purple fig nodes, and restrained violet alien-heart seams. Include
> a large circular fully transparent portrait socket on the left and a large
> clean fully transparent title-safe opening across the center and right. Keep
> decoration around the outer perimeter and a few corner root flourishes;
> openings must be genuinely empty alpha, not black or translucent fill. Strong
> readable pixel-art silhouette, finely detailed but not photorealistic. No
> character portrait, no text, no letters, no numbers, no logos, no symbols, no
> scenery, no watermark.
>
> Single complete frame centered on canvas with generous transparent margin and
> no cropped edges.
>
> Transparent background.

### Boss-HUD frame, accepted retry

> Create a compact long shallow Possessed Banyan boss HUD frame using Image 1
> for the exact layout and Image 2 for the detailed high-resolution pixel-art
> style.
>
> Keep the left circular portrait opening, long central health-bar opening, and
> three phase sockets on the right. Decorate the slim frame with gnarled banyan
> roots, charcoal ACO metal, aged brass, green jackfruit rind plates, golden
> fibers, red-purple fig nodes, violet heart seams, and a few leaves. Text-free.
> No portrait, health fill, phase icons, labels, scenery, or watermark. One
> complete uncropped HUD asset.
>
> Transparent background.

### Phase markers

> Use case: stylized-concept
>
> Asset type: game boss phase-marker icon strip
>
> Input image: authoritative Possessed Banyan portrait states. Preserve its
> exact jackfruit rind, golden fibers, glossy seeds, violet heart, banyan bark,
> palette, detailed high-resolution original pixel-art density, and upper-left
> lighting.
>
> Create exactly three matching circular phase-marker icons in one horizontal
> row for the Possessed Banyan boss HUD. Icon 1: tightly closed green jackfruit
> hexagonal rind bud with a small banyan-root clasp. Icon 2: cracked jackfruit
> rind opening through radiant golden fibers. Icon 3: exposed faceted violet
> alien heart surrounded by a ring of glossy dark jackfruit seeds. Each icon
> sits in the same compact charcoal-metal and aged-brass circular socket rim
> with tiny root accents. Strong silhouettes readable at small HUD size. No
> text, letters, numbers, labels, scenery, watermark, or loose objects.
>
> Exactly three equal cells in one horizontal row, one complete centered icon
> per cell, identical scale, generous transparent separation, no overlap, no
> grid lines, no cropped edges.
>
> Transparent background.
