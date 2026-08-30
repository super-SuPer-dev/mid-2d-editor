# ENEMY-THORNLING rambutan animation source set v1

**State:** Review (not integrated)

**Generation mode:** Built-in image generation

**Fruit identity:** Rambutan / เงาะ

**Visual source:** Integrated Thornling gameplay-scale reference plus the
five-biome campaign anchor

The redesign keeps the low melee-pursuer role while replacing generic thorn
growth with readable rambutan anatomy. A red-yellow hairy rind forms the body,
green-tipped fruit hairs harden into contact hooks, pale flesh forms the jaw,
and a glossy dark seed becomes the inert death-state core.

## Animation contract

| Action | Frames | Loop | Runtime intent |
|---|---:|---|---|
| Idle | 4 | Yes | Alert breathing, hair flex and restrained node pulse |
| Run | 4 | Yes | Fast four-root-leg pursuit loop |
| Attack tell | 4 | No | Braced crouch, aligned hook hairs and bright nodes |
| Attack | 4 | No | Low launch, maximum bite/hook reach and recoil |
| Hurt | 4 | No | Compression, dimmed nodes and stance recovery |
| Death | 4 | No | Root failure, rind collapse and exposed inert seed |

Raw built-in outputs are retained as `thornling_*_strip_v1.png`. Normalized
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
| `thornling_rambutan_anchor_v1.png` | `00516E8BBEB6A491A0926CA2A34C9EC347A9425E7680C697A28F59C7158C2240` |
| `thornling_idle_strip_normalized_v1.png` | `A0E68FD648482CAC1E6BE09800AE03FFCEB1553311D1CF48EDE2633D6F2F19F6` |
| `thornling_run_strip_normalized_v1.png` | `BEECE73BCBED17146883FE669549A3BA5FBE0EB02FCC65866DBCA7FA44515817` |
| `thornling_attack_tell_strip_normalized_v1.png` | `4A84B6AEADED1C1B10E4119E038E3CA97A8A44CFEF00A51E6648DFC330C2ED63` |
| `thornling_attack_strip_normalized_v1.png` | `DFFAAE6D98E23F1B88F07256E977D0F736756A615031CA451F0A12E3676F70AC` |
| `thornling_hurt_strip_normalized_v1.png` | `DE759DD82FF1461AA205F1D358D672962DAC77B7C9914B28A79ED3810C9E19B8` |
| `thornling_death_strip_normalized_v1.png` | `FDA2772FEDEA212BB49C5269A290D54D164741638213770220AD3212E879693D` |

All normalized strips are 2800 x 800, `Format32bppArgb`, with corner alpha
`0,0,0,0`. All detected poses fit the 700-pixel cell width; the widest is the
638-pixel maximum-reach attack frame. Visual review covered every action and
confirmed isolated poses and the shared baseline. Runtime integration still
requires logical downscale review against the existing smaller idle anchor,
nearest-neighbor import settings, playback timing, collision and attack-hitbox
timing, and a separate contact-hit VFX asset.

## Built-in source provenance

| Asset | Preserved built-in output |
|---|---|
| Rambutan design anchor | `exec-b25f1788-e191-4b1e-aacd-1ec38b6f59e2.png` |
| Idle | `exec-cda9692d-1994-48a4-9804-2df338521313.png` |
| Run | `exec-ee85b746-10b1-457f-b728-1bf794d7909b.png` |
| Attack tell | `exec-58996617-bfb4-453e-8266-46e162f6f686.png` |
| Attack | `exec-8fb35bb4-9aeb-4dfe-a95c-fb8e93a0e792.png` |
| Hurt | `exec-d4f48c28-cae8-421e-bca9-55eb899e7b20.png` |
| Death | `exec-9655fa52-2f4a-4055-b4dd-c3c5af77aec6.png` |

## Prompts

### Rambutan design anchor

> Redesign the Thornling as a Thai rambutan-fruit mutation for a detailed
> high-resolution pixel-art side-scrolling action-platformer. Preserve the
> compact low melee-pursuer role, four root legs, snapping forward mouth,
> hooked thorn crown, crisp pixel density, strong outline weight, and
> upper-left lighting. Make rambutan identity immediately readable: a
> red-to-yellow oval rind body covered in flexible green-tipped hair-spines,
> several longer forward hairs hardened into hooked contact thorns, pale
> translucent rambutan flesh forming the inner jaw, a glossy dark seed inside
> the mouth, and a small green calyx merging into the root legs. Keep
> restrained toxic-lime and violet alien nodes as secondary accents. Side view
> facing right. It is a small standard enemy, clearly less massive than the
> Maw and Thorn Matriarch. One neutral alert pose. No text, numbers, or
> projectile.
>
> Transparent background.

### Idle

> Create a four-frame horizontal idle animation. Keep the same red-yellow
> rambutan hair-rind body, green-tipped flexible spines, four root legs, pale
> flesh jaw, glossy dark seed mouth, hooked woody crown, toxic-lime nodes, side
> view facing right, scale, pixel density, palette, and lighting. Animate a low
> alert loop: neutral stance, mouth and rind hairs flex, lime nodes pulse while
> the body breathes, then return toward neutral.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and ground baseline, no overlap, no text or grid
> lines.
>
> Transparent background.

### Run

> Create a four-frame horizontal pursuit-run animation. Keep the same rambutan
> design, colors, side view facing right, scale, pixel density, and lighting.
> Animate a quick four-root-leg chase: front contact, passing pose, rear
> contact, passing pose. The body stays low and aggressive; rambutan hairs
> stream backward and the mouth bobs without biting.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and ground baseline, no overlap, no text or grid
> lines.
>
> Transparent background.

### Attack tell

> Create a four-frame horizontal melee-attack anticipation animation. Keep the
> same rambutan design, colors, side view facing right, scale, pixel density,
> and lighting. Animate a clear non-damaging tell: alert stance, four root legs
> brace, mouth draws back while forward rambutan hairs align into hooked
> thorns, then a final held crouch with lime nodes bright immediately before
> lunging. Do not show the actual attack.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and ground baseline, no overlap, no text or grid
> lines.
>
> Transparent background.

### Attack

> Create a four-frame horizontal melee attack animation. Keep the same
> rambutan design, colors, side view facing right, scale, pixel density, and
> lighting. Continue from the crouched tell: launch low and forward, snap the
> pale-flesh jaw at maximum reach while hardened rambutan hairs hook forward,
> hold the damaging contact silhouette briefly, then recoil toward the
> original position. Make damaging frames two and three and the recovery frame
> visually distinct.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and ground baseline, no overlap, no text or grid
> lines.
>
> Transparent background.

### Hurt

> Create a four-frame horizontal hurt animation. Keep the same rambutan design,
> colors, side view facing right, scale, pixel density, and lighting. Animate
> impact recoil, root legs and flexible fruit hairs compressing backward while
> lime nodes dim, the mouth clamping around the glossy dark seed, then
> regaining the alert stance. No hit effect or projectile.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and ground baseline, no overlap, no text or grid
> lines.
>
> Transparent background.

### Death

> Create a four-frame horizontal death animation. Keep the same rambutan
> design, colors, side view facing right, scale, pixel density, and lighting.
> Animate a non-gory defeat: root legs buckle and hooked hairs lose tension,
> the red-yellow rind body collapses while pale flesh folds inward, toxic nodes
> and the dark seed go inert, then a final split rambutan-root husk rests on the
> ground with wilted hairs. The last frame must clearly read as dead.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and ground baseline, no overlap, no text or grid
> lines.
>
> Transparent background.
