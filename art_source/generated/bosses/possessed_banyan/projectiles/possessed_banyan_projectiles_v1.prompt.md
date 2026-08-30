# BOSS-POSSESSED-BANYAN projectile, hazard and death-VFX source set v1

**State:** Review (not integrated)

**Generation mode:** Built-in image generation

**Fruit identity:** Jackfruit + banyan fig / ขนุน + ลูกไทร

This package supplies the detached gameplay assets required by the Level 3
boss body animations: falling seed columns with ground warning and impact,
diagonal fig-root lines, sticky jackfruit latex and the final Capsule-heart
break overlay.

## Animation contract

| Asset | Frames | Alignment | Runtime intent |
|---|---:|---|---|
| Jackfruit seed fall | 4 | Center | Tumbling vertical-column projectile |
| Jackfruit seed impact | 4 | Center | Contact, crack flash, fragment ring and fade |
| Seed-column ground tell | 4 | Ground | Harmless countdown ring for safe-lane reading |
| Diagonal root line | 4 | Center | Guide, growth, active thorn line and recovery |
| Sticky sap pool | 4 | Ground | Splash, spreading slow zone, active and recovery |
| Heart-break VFX | 4 | Center | Heart crack, seed/fiber ring, collapse and ember |

Raw outputs are retained as `*_strip_v1.png`. Normalized review strips use a
strict 4 columns x 1 row grid at 3200 x 800 pixels:

- Cell size: 800 x 800 pixels
- Centered projectile/effect pivot: x = 400, y = 400
- Ground warning/hazard pivot: x = 400; baseline y = 760
- Solid-alpha threshold: 128
- Output: 32-bit RGBA PNG with transparent corners
- No rescaling or interpolation during normalization

Grid-cell normalization preserves intentional droplets, fibers, seeds and
fragments. The long diagonal root uses connected-component isolation so
neighboring-cell spill is removed without shortening the authored root.

## Validation hashes

| Candidate | SHA-256 |
|---|---|
| `jackfruit_seed_fall_strip_normalized_v1.png` | `ED6FEF1C5E315EEBF061D55817306E238D730FB04C45153665616CF98F43D941` |
| `jackfruit_seed_impact_strip_normalized_v1.png` | `1E4C4E7EDC4281282FB75222016DAB6B060CAB5DDDA18EA499F1434697699914` |
| `seed_column_ground_tell_strip_normalized_v1.png` | `F5650B6FD888205765FFDBD997CD19C5795FAE374EBB4B1DCA6748B52F425794` |
| `diagonal_root_line_strip_normalized_v1.png` | `82F6AD8EB9775BCB41188943FAD6D0E91792B7006F7FFE36BB9D2D684E755A3E` |
| `sticky_sap_pool_strip_normalized_v1.png` | `58836A03C0066685D8A63F201672F76F12159F067DD007FCB643D591ACD26BDA` |
| `heart_break_vfx_strip_normalized_v1.png` | `C43712C960EDA0B0DCE5B0405ED68E9932E610B7F11F9696977F76BCEF3F34D0` |

All normalized strips are 3200 x 800, `Format32bppArgb`, and have transparent
corner pixels. Visual review confirmed distinct seed/tell/impact silhouettes,
clear harmless versus active root-line states, separate circular warning and
irregular sap-pool reads, isolated cells and a non-gory death overlay. Runtime
integration still requires logical downscale review, nearest-neighbor imports,
pooling, collision and slow-zone timing, deterministic safe-lane tests,
background contrast tests and Web memory validation.

## Built-in source provenance

| Asset | Preserved built-in output |
|---|---|
| Jackfruit seed fall | `exec-11ffcde3-a4d6-4a41-af32-2a57f9983698.png` |
| Jackfruit seed impact | `exec-54777433-b9c5-42e1-a3f5-baa10dcacd1e.png` |
| Seed-column ground tell | `exec-5eb0aa2f-9568-445a-8619-e4a58effc2cd.png` |
| Diagonal root line | `exec-b24786e7-f655-440a-8cdf-578436788114.png` |
| Sticky sap pool | `exec-31b3e7a9-3517-4f47-9377-86b196a3da92.png` |
| Heart-break VFX | `exec-c7ffcaec-efa7-4136-9459-b22cb7775191.png` |

## Prompts

### Jackfruit seed fall

> Use case: stylized-concept
>
> Asset type: game boss projectile animation strip
>
> Input images: Image 1 establishes the Possessed Banyan's jackfruit seed
> sockets, golden fibers, violet Capsule membrane, detailed high-resolution
> pixel art, palette, and lighting.
>
> Create a four-frame horizontal falling jackfruit-seed projectile animation.
> The projectile is one heavy glossy brown oval jackfruit seed wrapped by two
> narrow golden fibrous fins, with a small green hexagonal rind cap and one
> thin violet alien seam. Animate one tumbling fall cycle with the violet seam
> pulsing. Use a compact heavy silhouette suitable for vertical seed columns
> and clearly different from the Maw Sovereign's white-finned seed bullet. No
> boss, trail, impact, floor, scenery, text, labels, or watermark.
>
> Exactly four equal cells in one horizontal row, one complete centered seed
> per cell, fixed scale, generous transparent separation, no overlap, no grid
> lines.
>
> Transparent background.

### Jackfruit seed impact

> Use case: stylized-concept
>
> Asset type: game boss projectile impact VFX strip
>
> Input images: Image 1 establishes the exact Possessed Banyan falling
> jackfruit seed. Preserve its glossy brown seed, golden fibrous fins, green
> hexagonal rind cap, violet seam, detailed high-resolution pixel art, palette,
> and lighting.
>
> Create a four-frame horizontal ground-impact animation: the heavy seed
> contacts and compresses; a compact amber-violet crack flash; golden fibers,
> two green rind chips, and brown seed fragments flare in a bounded ring; then
> a fast-fading violet-amber glint with no seed remaining. Keep it centered,
> non-gory, and readable over the dark Capsule root chamber. No boss, floor
> tile, scenery, text, labels, or watermark.
>
> Exactly four equal cells in one horizontal row, one complete effect state
> per cell, fixed centered pivot, generous transparent separation, no overlap,
> no grid lines.
>
> Transparent background.

### Seed-column ground tell

> Use case: stylized-concept
>
> Asset type: game boss ground-warning animation strip
>
> Input images: Image 1 establishes the Possessed Banyan seed's green
> hexagonal rind, golden fiber, violet seam, detailed high-resolution pixel
> art, palette, and lighting.
>
> Create a four-frame horizontal ground tell for an incoming falling seed
> column. The warning is a low flat oval made of a faint brown shadow, a thin
> ring of small green jackfruit hexagons, two golden fiber arcs, and a violet
> Capsule pulse. Animate a harmless dim oval, a wider violet pulse, hexagonal
> segments lighting in sequence, then a bright compact imminent-impact ring.
> It must remain visibly non-damaging and much lower than the seed impact. No
> falling seed, explosion, root, floor tile, boss, scenery, text, labels, or
> watermark.
>
> Exactly four equal cells in one horizontal row, one complete warning state
> per cell, fixed ground baseline, generous transparent separation, no
> overlap, no grid lines.
>
> Transparent background.

### Diagonal root line

> Use case: stylized-concept
>
> Asset type: game boss diagonal hazard animation strip
>
> Input images: Image 1 establishes the Possessed Banyan's fig-bearing aerial
> roots, golden jackfruit fibers, violet Capsule membrane, detailed
> high-resolution pixel art, palette, and lighting.
>
> Create a four-frame horizontal strip for one diagonal root-line hazard,
> drawn from lower left to upper right inside every cell. Animate: a thin
> harmless violet guide thread with two dim red-purple banyan-fig nodes; golden
> fibers beginning to grow along the guide while still harmless; a thick
> active thorny brown root with bright fig nodes and violet membrane seam; then
> a dim cracking recovery root. Keep the root narrow enough to leave dodge
> space and make harmless versus active states unmistakable. No boss, floor,
> scenery, extra lines, text, labels, or watermark.
>
> Exactly four equal square cells in one horizontal row, one complete diagonal
> line per cell, fixed centered pivot and angle, generous transparent
> separation, no overlap, no grid lines.
>
> Transparent background.

### Sticky sap pool

> Use case: stylized-concept
>
> Asset type: game boss ground-hazard animation strip
>
> Input images: Image 1 establishes the Possessed Banyan's amber jackfruit
> latex, golden fibers, green rind chips, violet Capsule membrane, detailed
> high-resolution pixel art, palette, and lighting.
>
> Create a four-frame horizontal sticky-sap pool animation. Animate a compact
> amber-violet latex splash touching ground; a low oval pool spreading with two
> green jackfruit rind chips and golden fiber strands; a bounded active pool
> bubbling with a bright violet slowing seam; then a dimmer sticky
> hold/recovery state. Keep the final hazard low, flat, and clearly different
> from the circular seed-column warning. No boss, falling seed, floor tile,
> scenery, text, labels, or watermark.
>
> Exactly four equal cells in one horizontal row, one complete hazard state per
> cell, fixed ground baseline, generous transparent separation, no overlap, no
> grid lines.
>
> Transparent background.

### Heart-break VFX

> Use case: stylized-concept
>
> Asset type: game boss death VFX animation strip
>
> Input images: Image 1 establishes the exposed Possessed Banyan heart, glossy
> brown jackfruit seeds, golden fibers, violet Capsule energy, detailed
> high-resolution pixel art, palette, and lighting.
>
> Create a four-frame centered non-gory heart-break VFX strip used over the
> collapsing boss. Animate a narrow violet heart cracking with a white-gold
> flash; a compact oval shock ring of glossy brown seeds and golden fibers; the
> ring folding inward as violet energy threads snap; then a fast-fading cluster
> of dark seeds, dim amber fiber, and one tiny violet ember. No boss body,
> explosion cloud, floor, scenery, text, labels, or watermark.
>
> Exactly four equal cells in one horizontal row, one complete centered effect
> state per cell, fixed scale and pivot, generous transparent separation, no
> overlap, no grid lines.
>
> Transparent background.
