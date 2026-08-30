# BOSS-MAW-SOVEREIGN projectile and hazard source set v1

**State:** Review (not integrated)

**Generation mode:** Built-in image generation

**Fruit identity:** Durian crown + mangosteen anatomy / มงกุฎทุเรียน + กายมังคุด

This package supplies the detached gameplay assets required by the Maw Bloom
Sovereign body animations: falling spore pods and their puddles, rotating and
aimed seed bullets with impact feedback, and a rooted summon nest. The source
and gameplay mappings are recorded in
`../maw_sovereign_fruit_identity_v1.md`.

## Animation contract

| Asset | Frames | Alignment | Runtime intent |
|---|---:|---|---|
| Spore pod fall | 4 | Center | Tumbling projectile used by the spore-rain cast |
| Spore pod impact | 4 | Ground | Contact, splash, low toxic puddle and active hold |
| Seed bullet spin | 4 | Center | Looping five-way and aimed-volley projectile |
| Seed bullet impact | 4 | Center | Contact flash, fruit-fragment ring and fast fade |
| Summon root nest | 4 | Ground | Harmless tell, bud, opening and active spawn portal |

Raw outputs are retained as `*_strip_v1.png`. Normalized review strips use a
strict 4 columns x 1 row grid at 3200 x 800 pixels:

- Cell size: 800 x 800 pixels
- Centered projectile/effect pivot: x = 400, y = 400
- Ground hazard pivot: x = 400; baseline y = 760
- Solid-alpha threshold: 128
- Output: 32-bit RGBA PNG with transparent corners
- No rescaling or interpolation during normalization

Grid-cell normalization preserves intentional detached droplets and fruit
fragments inside their authored frame while isolating the four source cells.

## Validation hashes

| Candidate | SHA-256 |
|---|---|
| `spore_pod_fall_strip_normalized_v1.png` | `D2F71949D306837E101A82E802C2C7B771F67F2B57278F77CE05A8EE3ED55607` |
| `spore_pod_impact_strip_normalized_v1.png` | `42F09E693775773F5F360E6F8B8B8DBFBB1614269F5ED2FB776920F4B9AF9C9B` |
| `seed_bullet_spin_strip_normalized_v1.png` | `B35B70CD5F2360ADCA6BF2814A7373965F25811F01FCEC3C69B9D42D92CFD07B` |
| `seed_bullet_impact_strip_normalized_v1.png` | `CACD85298F91E58EDE334EFBA227B5BEA0B35823F1B495E505C9B968F4DAAEBC` |
| `summon_root_nest_strip_normalized_v1.png` | `FB3E74DF3FFFE8514394D5C7048EB5BAC9DF49D6681D5DDFC6F784059AB04A38` |

All normalized strips are 3200 x 800, `Format32bppArgb`, and have transparent
corner pixels. Visual review confirmed isolated states, stable centered or
ground pivots, a low readable puddle, a distinct seed projectile silhouette,
and clear harmless-versus-active summon states. Runtime integration still
requires logical downscale review, nearest-neighbor imports, pooling,
collision radii, damage timing, pattern tests, bright/dark background contrast
tests and Web memory validation.

## Built-in source provenance

| Asset | Preserved built-in output |
|---|---|
| Spore pod fall | `exec-cb9a13a2-d75f-47e9-b067-41d4c11935bd.png` |
| Spore pod impact | `exec-7830ef11-34de-493d-99c6-55817a8b68d4.png` |
| Seed bullet spin | `exec-5d8d20f9-3b1c-4610-b33c-ab8cf3862257.png` |
| Seed bullet impact | `exec-5b130316-d114-48bf-a452-9451791d13ab.png` |
| Summon root nest | `exec-c9ec63cd-cfab-4b66-b675-5d8c4fa084d1.png` |

## Prompts

### Spore pod fall

> Use case: stylized-concept
>
> Asset type: game boss projectile animation strip
>
> Input images: Image 1 establishes the Maw Bloom Sovereign spore-sac design.
>
> Create a four-frame horizontal falling spore-pod animation. The projectile
> is one small purple mangosteen-like spore sac with a green calyx cap,
> toxic-lime pores and one short dripping tail. Animate a tumbling fall cycle
> with the lime pores pulsing. Keep a compact rounded silhouette distinct from
> the sharp seed bullet. No boss, rain trail, explosion, floor, scenery, or
> text.
>
> Exactly four equal cells in one horizontal row, one complete centered pod
> per cell, fixed scale, generous transparent separation, no overlap or grid
> lines.
>
> Transparent background.

### Spore pod impact

> Use case: stylized-concept
>
> Asset type: game boss projectile impact and hazard strip
>
> Input images: Image 1 establishes the Maw Sovereign falling spore pod.
>
> Create a four-frame horizontal ground-impact animation for that pod.
> Preserve its purple mangosteen skin, green-gold calyx, toxic-lime pores,
> detailed pixel art, palette, and lighting. Animate the pod contacting and
> compressing, splitting into a compact lime spore splash, settling into a low
> circular toxic puddle with purple rind fragments, then a dim active puddle
> hold. Keep the final hazard low and clearly bounded. No boss, floor tile,
> scenery, text, or extra projectiles.
>
> Exactly four equal cells in one horizontal row, one complete state per cell,
> fixed ground baseline, generous transparent separation, no overlap or grid
> lines.
>
> Transparent background.

### Seed bullet spin

> Use case: stylized-concept
>
> Asset type: game boss projectile animation strip
>
> Input images: Image 1 establishes the exposed Maw Sovereign seed and fruit
> materials.
>
> Create a four-frame horizontal spinning seed-bullet animation. The bullet is
> a small glossy dark mangosteen seed shaped like a tapered oval, wrapped by
> two white flesh fins and a thin purple energy seam, with a tiny green-gold
> durian barb at the rear. Animate one centered rotation cycle. Use a sharp
> narrow silhouette readable in rotating five-way volleys and aimed bursts.
> No boss, trail, impact, floor, scenery, or text.
>
> Exactly four equal cells in one horizontal row, one complete centered bullet
> per cell, fixed scale, generous transparent separation, no overlap or grid
> lines.
>
> Transparent background.

### Seed bullet impact

> Use case: stylized-concept
>
> Asset type: game boss projectile impact VFX strip
>
> Input images: Image 1 establishes the Maw Sovereign seed bullet.
>
> Create a four-frame horizontal impact animation for that seed bullet.
> Preserve the dark purple seed, white mangosteen flesh, green-gold durian
> barb, violet seam, detailed pixel art, palette, and lighting. Animate a small
> white contact spark, a sharp violet seed-shaped flash, a compact ring of
> white flesh fragments and green-gold barbs, then a fast-fading purple glint.
> Keep it centered, non-gory, compact, and readable over dark forest
> backgrounds. No boss, floor, scenery, or text.
>
> Exactly four equal cells in one horizontal row, one complete effect state
> per cell, fixed scale and centered pivot, generous transparent separation,
> no overlap or grid lines.
>
> Transparent background.

### Summon root nest

> Use case: stylized-concept
>
> Asset type: game boss summon-hazard animation strip
>
> Input images: Image 1 is the authoritative exposed Maw Bloom Sovereign
> reference; preserve its detailed high-resolution pixel-art rendering, purple
> mangosteen rind, white segmented flesh, brown-gold roots, green spores,
> magenta-violet energy, palette, material detail, and lighting.
>
> Create a four-frame horizontal ground summon-nest animation. A low ring of
> six brown-gold roots with purple mangosteen rind plates and small green
> spores begins as a harmless dim violet ground pulse, rises into a closed
> fruit bud, splits open to reveal white segmented flesh, then holds as a dark
> root opening from which a standard Maw can spawn. The first tell must look
> clearly non-damaging; the final active opening must remain low, bounded, and
> visibly different from a toxic puddle. No summoned creature, no boss body,
> no floor tile, no scenery, no text, no labels, no watermark.
>
> Exactly four equal cells in one horizontal row, one complete state per cell,
> fixed scale, fixed ground baseline, generous transparent separation, no
> overlap, no grid lines.
>
> Transparent background.
