# ENEMY-SPITTER makrut-lime animation source set v1

**State:** Review (not integrated)

**Generation mode:** Built-in image generation plus lossless orientation fix

**Fruit identity:** Makrut lime / มะกรูด

**Visual source:** Integrated Spitter gameplay-scale reference plus the
five-biome campaign anchor

The redesign preserves the ranged-support silhouette while making makrut-lime
anatomy explicit. Dimpled citrus rind forms the pressure sac, pale pith forms
the cannon rim, glowing juice vesicles feed the barrel, cream seeds fill the
loading chamber, and double-lobed makrut leaves protect the root legs.

The initial generated anchor inherited the integrated sprite's left-facing
orientation. `spitter_makrut_anchor_source_v1.png` preserves that built-in
output. `spitter_makrut_anchor_v1.png` is a lossless horizontal mirror used as
the accepted right-facing animation reference; no resampling occurred.

## Animation contract

| Action | Frames | Loop | Runtime intent |
|---|---:|---|---|
| Idle | 4 | Yes | Pressure-sac swell, juice pulse and settle |
| Walk | 4 | Yes | Stable three-root-leg repositioning |
| Pressure tell | 4 | No | Brace, sac inflation and queued visible seeds |
| Seed burst | 4 | No | Level shot, sharp recoil and recovery |
| Juice lob | 4 | No | Upward cannon angle, lob recoil and recovery |
| Hurt | 4 | No | Leaf/rind compression, cannon droop and recovery |
| Death | 4 | No | Pressure leak, rind split and inert pith/seed husk |

Raw built-in outputs are retained as `spitter_*_strip_v1.png`. Normalized
review strips use a strict 4 columns x 1 row grid at 2800 x 800 pixels:

- Cell size: 700 x 800 pixels
- Pivot guide: x = 350 within each cell
- Ground baseline: y = 740 within each cell
- Solid-alpha threshold: 128
- Output: 32-bit RGBA PNG with transparent corners
- No rescaling or interpolation during normalization

## Validation hashes

| Candidate | SHA-256 |
|---|---|
| `spitter_makrut_anchor_source_v1.png` | `21EE48782738CEEE5A630647EE0753F686D761C5279129DBD75C845BC44A9704` |
| `spitter_makrut_anchor_v1.png` | `7AEA62DE313D27B9B36E9EE0D10E8DF2989367191F8FF6CB9183EEE94D123F70` |
| `spitter_idle_strip_normalized_v1.png` | `FF7CF702A696EF877D2C9CC459287A68ECCB00EEF33472164C492F13C4A60B4B` |
| `spitter_walk_strip_normalized_v1.png` | `5A1192AC4919B23FB014D965136D076FF5BDE0370225AA75845FFE922B838173` |
| `spitter_pressure_tell_strip_normalized_v1.png` | `EAC871A15FDA2726B5C38EE32B7EBE557184B155F7F82E13A6F03812690C999D` |
| `spitter_seed_burst_strip_normalized_v1.png` | `95AD5F483FC38AD14E8A4FB66B4A3ED3030D922D81C4D065C4C0F749EEEFBC85` |
| `spitter_juice_lob_strip_normalized_v1.png` | `3D5846669B56838AD5089D62AFDEC540169F437CD8A291D1AFCAA47186D8C99A` |
| `spitter_hurt_strip_normalized_v1.png` | `9540CBA96438881095DBEB0A4B24881D8BD109CD841551B32BA22CF04ADBBFA4` |
| `spitter_death_strip_normalized_v1.png` | `8F7B67B5D87EAA61F87200E4E098CCE1C97C9E6BE412CA9713B36075F073765A` |

All normalized strips are 2800 x 800, `Format32bppArgb`, with corner alpha
`0,0,0,0`. All detected poses fit the 700-pixel cell width; the widest is the
650-pixel seed-burst firing frame. Visual review covered every action and
confirmed isolated poses and the shared baseline. The raw death output
contained faint ambient haze; the alpha-128 normalization removed it without
resampling the solid sprite pixels. Runtime integration still requires
logical downscale review, nearest-neighbor import settings, attack timing, and
separate seed, juice-glob, impact and splash VFX assets.

## Built-in source provenance

| Asset | Preserved built-in output |
|---|---|
| Makrut design anchor | `exec-1273be54-df48-46f9-963c-52127f863951.png` |
| Idle | `exec-8b01c29d-218d-4c6c-8f90-6e0fc082dbd5.png` |
| Walk | `exec-8fa324ff-6ea4-4be8-96f9-980066d6794b.png` |
| Pressure tell | `exec-7526f77f-22b8-41fc-8c53-452a79902669.png` |
| Seed burst | `exec-b9990011-b7c0-47b8-bea3-9b721191fda7.png` |
| Juice lob | `exec-47250d76-49db-4699-95f6-8532c5245747.png` |
| Hurt | `exec-c5871287-811c-4613-a1b3-286a5097b95f.png` |
| Death | `exec-8ec91587-b656-4889-8820-21c2f6eee8e4.png` |

## Prompts

### Makrut-lime design anchor

> Redesign the Spitter as a Thai makrut-lime mutation for a detailed
> high-resolution pixel-art side-scrolling action-platformer. Preserve the
> squat ranged-support role, three rooted legs, horizontal organic cannon,
> folded thorn leaves, swollen rear pressure sac, crisp pixel density, strong
> outline weight, and upper-left lighting. Make makrut-lime identity
> immediately readable: dark green heavily dimpled citrus rind forms the
> pressure sac and body armor, pale pith lines the cannon rim, translucent
> yellow-green juice vesicles glow inside, several cream citrus seeds sit in a
> loading chamber, and distinctive double-lobed makrut leaves fold around the
> legs and barrel. Keep restrained violet mutation seams and toxic yellow-green
> energy as secondary accents. Side view facing right. It is a medium standard
> enemy, not a boss. One neutral alert pose. No projectile, text, or numbers.
>
> Transparent background.

### Idle

> Create a four-frame horizontal idle animation. Keep the same dimpled
> dark-green citrus rind, pale pith cannon rim, translucent yellow-green juice
> vesicles, cream seed loading chamber, double-lobed makrut leaves, three root
> legs, violet seams, side view facing right, scale, pixel density, palette,
> and lighting. Animate a restrained pressure idle: neutral stance, rear lime
> sac swells, cannon juice channels pulse, then pressure settles toward
> neutral.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and ground baseline, no overlap, no text or grid
> lines.
>
> Transparent background.

### Walk

> Create a four-frame horizontal rooted-walk animation. Keep the same
> makrut-lime design, colors, side view facing right, scale, pixel density, and
> lighting. Animate a slow stable three-leg reposition: front contact, center
> passing pose, rear contact, center passing pose. The heavy pressure sac
> countersways while the citrus cannon remains aimed forward.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and ground baseline, no overlap, no text or grid
> lines.
>
> Transparent background.

### Pressure tell

> Create a four-frame horizontal ranged-attack pressure tell. Keep the same
> makrut-lime design, colors, side view facing right, scale, pixel density, and
> lighting. Animate a clear non-damaging telegraph: alert idle, root legs brace
> and double-lobed leaves fold in, rear dimpled lime sac inflates while juice
> vesicles brighten, then the cannon pith opens with visible cream seeds queued
> at maximum pressure. Do not fire a projectile.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and ground baseline, no overlap, no text or grid
> lines.
>
> Transparent background.

### Seed burst

> Create a four-frame horizontal seed-burst attack animation. Keep the same
> makrut-lime design, colors, side view facing right, scale, pixel density, and
> lighting. Continue from maximum pressure: cannon pith contracts around queued
> seeds, the barrel snaps forward at the firing moment, the rear lime sac
> sharply deflates in recoil, then the body begins recovery. Make the firing
> frame obvious but do not draw detached projectiles.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and ground baseline, no overlap, no text or grid
> lines.
>
> Transparent background.

### Juice lob

> Create a four-frame horizontal arcing juice-lob attack animation. Keep the
> same makrut-lime design, colors, side view facing right, scale, pixel density,
> and lighting. Animate the root legs leaning back, the citrus cannon tilting
> diagonally upward, translucent juice vesicles surging to the rim at the
> firing moment, then a heavy recoil and return toward level aim. Do not draw a
> detached glob.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and ground baseline, no overlap, no text or grid
> lines.
>
> Transparent background.

### Hurt

> Create a four-frame horizontal hurt animation. Keep the same makrut-lime
> design, colors, side view facing right, scale, pixel density, and lighting.
> Animate impact recoil, dimpled lime sac and leaf armor compressing while
> juice vesicles dim, the cannon drooping as roots regain balance, then return
> toward alert idle. No hit effect or projectile.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and ground baseline, no overlap, no text or grid
> lines.
>
> Transparent background.

### Death

> Create a four-frame horizontal death animation. Keep the same makrut-lime
> design, colors, side view facing right, scale, pixel density, and lighting.
> Animate a non-gory defeat: root legs buckle and pressure leaks from the sac,
> double-lobed leaves and cannon collapse, the dimpled rind splits as juice
> light goes dark, then a final inert makrut-lime husk with pale pith and loose
> cream seeds rests on the ground.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and ground baseline, no overlap, no text or grid
> lines.
>
> Transparent background.
