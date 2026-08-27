# BOSS-THORN-MATRIARCH projectile and hazard source set v1

**State:** Review (not integrated)

**Generation mode:** Built-in image generation

**Fruit identity:** Rambutan queen cluster / พวงราชินีเงาะ

This package supplies the detached gameplay assets required by the boss body
animations: a rolling fruit mine and burst, a rotating hair-thorn bullet and
impact, and a ground-lane thorn with harmless tell frames before activation.

## Animation contract

| Asset | Frames | Alignment | Runtime intent |
|---|---:|---|---|
| Rambutan mine roll | 4 | Center | Looping ground projectile rotation |
| Rambutan mine burst | 4 | Center | Compression, flare and compact fruit-sap burst |
| Hair-thorn spin | 4 | Center | Looping radial-fan and aimed bullet |
| Hair-thorn impact | 4 | Center | Contact flash, ring and fast fade |
| Lane-thorn emerge | 4 | Ground | Two tell frames followed by two damaging frames |

Raw outputs are retained as `*_strip_v1.png`. Normalized review strips use a
strict 4 columns x 1 row grid at 3200 x 800 pixels:

- Cell size: 800 x 800 pixels
- Centered projectile/effect pivot: x = 400, y = 400
- Ground-hazard pivot: x = 400; baseline y = 760
- Solid-alpha threshold: 128
- Output: 32-bit RGBA PNG with transparent corners
- No rescaling or interpolation during normalization

Projectile and multi-part VFX strips use grid-cell normalization so intentional
detached sparks remain inside their authored frame. The rooted lane hazard uses
connected-component normalization to discard isolated generation artifacts.

## Validation hashes

| Candidate | SHA-256 |
|---|---|
| `rambutan_mine_roll_strip_normalized_v1.png` | `CD2A94E138C00D7CBD7C070CAE06E4D3BEB1D703A86DDD3DF2F64F233A5251EC` |
| `rambutan_mine_burst_strip_normalized_v1.png` | `BB3D129C287A3A5D6217464A38B81255A6AA4F7937FA1C89054598F377C9B208` |
| `hair_thorn_spin_strip_normalized_v1.png` | `D5E734E7A8CE7C51B6A18BB720E7AB72F487B9D77BAD065405FF1437A31E8C5F` |
| `hair_thorn_impact_strip_normalized_v1.png` | `B8FE687CDEC0F4F8B12BCB4063CD7843B3630C2CBB257DDFD1E1CA4E17B1AB80` |
| `lane_thorn_emerge_strip_normalized_v1.png` | `2B4AD4BA0FF9519B78E5EF3F18111BCA3F7908EAD335E3B4A932AEFFDC65DAD8` |

All normalized strips are 3200 x 800, `Format32bppArgb`, and have transparent
corner pixels. Visual review confirmed isolated frames, centered projectile
pivots, a fixed ground baseline for the lane hazard, and clear harmless versus
damaging states. Runtime integration still requires logical downscale review,
nearest-neighbor imports, pooling, collision radii, damage timing, deterministic
pattern tests, bright-background contrast tests and Web memory validation.

## Built-in source provenance

| Asset | Preserved built-in output |
|---|---|
| Rambutan mine roll | `exec-0745a549-0f95-4b4b-b59a-4828dddfbdff.png` |
| Rambutan mine burst | `exec-3dfd54c3-2370-49c8-ac35-d77ff6bef79f.png` |
| Hair-thorn spin | `exec-64e23224-e828-4536-bc4b-b66346263de3.png` |
| Lane-thorn emerge | `exec-283163c4-b2e1-4a9a-8e81-ba56a87878b2.png` |
| Hair-thorn impact | `exec-8201145e-f247-445b-859b-b4fdd545eaa4.png` |

## Prompts

### Rambutan mine roll

> Create a four-frame horizontal rolling rambutan mine animation for a
> high-resolution pixel-art side-scrolling action-platformer. The mine is a
> compact red-to-yellow rambutan fruit bud with flexible green-tipped
> hair-spines, a dark woody calyx, small toxic-lime glow nodes, and restrained
> violet alien seams. Animate one complete rotation cycle with the hair-spines
> bending against motion. It must read clearly as a dangerous ground
> projectile and remain much smaller than the boss. No boss, explosion, floor,
> text, or scenery.
>
> Exactly four equal cells in one horizontal row, one complete mine per cell,
> fixed camera scale, centered pivot, generous transparent separation, no
> overlap, no text or grid lines.
>
> Transparent background.

### Rambutan mine burst

> Create a four-frame horizontal mine-burst animation for that exact rambutan
> mine. Preserve its red-yellow rind, green-tipped hairs, ivory thorns, dark
> woody calyx, toxic-lime nodes, violet seams, pixel density, palette, and
> lighting. Animate a readable non-gory hazard burst: mine compresses, rind
> seams glow, hair-spines flare outward, then a compact circular toxic-lime and
> violet fruit-sap burst with the mine gone. Keep the effect compact for fair
> collision timing. No boss, floor, text, or scenery.
>
> Exactly four equal cells in one horizontal row, one complete effect state
> per cell, fixed camera scale, centered pivot, generous transparent
> separation, no overlap, no text or grid lines.
>
> Transparent background.

### Hair-thorn spin

> Create a four-frame horizontal spinning hair-thorn projectile animation for
> a high-resolution pixel-art side-scrolling action-platformer. The projectile
> is one sharp curved ivory thorn wrapped by two red rambutan hairs with green
> tips, a bright toxic-lime core at the base, and a thin violet alien seam.
> Animate a complete readable spin around a centered pivot. Use a narrow
> arrow-like silhouette suitable for radial fans and aimed bullet patterns. It
> must remain much smaller than the rolling fruit mine. No boss, explosion,
> floor, text, or scenery.
>
> Exactly four equal cells in one horizontal row, one complete projectile per
> cell, fixed camera scale, centered pivot, generous transparent separation,
> no overlap, no text or grid lines.
>
> Transparent background.

### Lane-thorn emerge

> Create a four-frame horizontal ground-thorn emergence animation for a
> high-resolution pixel-art side-scrolling action-platformer. The hazard is a
> small patch of violet alien roots and red rambutan hairs that telegraphs with
> pulsing toxic-lime nodes before three tall curved ivory orchard thorns erupt
> upward. Animate: low harmless root tell, brighter swelling tell, full thorn
> eruption, held active thorn cluster. Make the harmless tell visibly lower
> and the damaging final two frames unmistakable. No boss, floor tile, text,
> or scenery.
>
> Exactly four equal cells in one horizontal row, one complete hazard state
> per cell, fixed camera scale and ground baseline, generous transparent
> separation, no overlap, no text or grid lines.
>
> Transparent background.

### Hair-thorn impact

> Create a four-frame horizontal impact animation for that projectile.
> Preserve its ivory, red-rambutan, toxic-lime, and violet color language and
> crisp high-resolution pixel-art density. Animate a tiny contact spark, a
> sharp star-shaped lime flash, red hair fragments curling into a compact
> violet ring, then a rapidly fading final sparkle. Keep the effect small,
> centered, non-gory, and readable over bright farm backgrounds. No projectile
> remaining in the final frame, boss, floor, text, or scenery.
>
> Exactly four equal cells in one horizontal row, one complete effect state
> per cell, fixed camera scale, centered pivot, generous transparent
> separation, no overlap, no text or grid lines.
>
> Transparent background.
