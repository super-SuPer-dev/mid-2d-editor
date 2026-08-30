# BOSS-THORN-MATRIARCH rambutan animation source set v1

**State:** Review (not integrated)

**Generation mode:** Built-in image generation

**Fruit identity:** Rambutan queen cluster / พวงราชินีเงาะ

**Visual source:** Existing integrated Thorn Matriarch silhouette, the detailed
rambutan Thornling fruit language, and the five-biome campaign style anchor

This source set redesigns the immobile Level 1 boss as a readable rambutan
queen cluster. Flexible fruit hairs form the Phase 1 armor and attack fan,
pale flesh lobes open during the phase transition, and a glossy dark queen
seed becomes the Phase 2 weak point. Two outer fruit-jaw vines preserve the
existing broad arena-control silhouette.

## Animation contract

| Action | Frames | Loop | Runtime intent |
|---|---:|---|---|
| Armored idle | 4 | Yes | Closed Phase 1 breathing and restrained armor ripple |
| Phase break | 4 | No | Rind and hair armor open to expose the queen seed |
| Exposed idle | 4 | Yes | Open Phase 2 weak-point pulse |
| Sweep tell | 4 | No | Non-damaging vine pullback and lane alignment |
| Sweep attack | 4 | No | Low lash, high follow-up, maximum reach and recoil |
| Mine cast | 4 | No | Attached rambutan buds swell before mine release |
| Fan cast | 4 | No | Exposed seed charge and radial hair-thorn flare |
| Hurt | 4 | No | Seed dim, crown compression and rooted recovery |
| Death | 4 | No | Progressive wilt and collapse to an inert root pile |

Raw built-in outputs are retained as `thorn_matriarch_*_strip_v1.png`.
Normalized review strips use a strict 4 columns x 1 row grid at 4800 x 900
pixels:

- Cell size: 1200 x 900 pixels
- Pivot guide: x = 600 within each cell
- Ground baseline: y = 840 within each cell
- Solid-alpha threshold: 128
- Output: 32-bit RGBA PNG with transparent corners
- No rescaling or interpolation during normalization

The 1200-pixel cell width is intentional. It preserves the complete extended
vine-sweep silhouette without cropping the generated art or borrowing pixels
from an adjacent animation cell.

## Validation hashes

| Candidate | SHA-256 |
|---|---|
| `thorn_matriarch_rambutan_anchor_v1.png` | `A3F18C9E150D2DFC4CD483C2A5091ABE48A743250ECAD87BF6A1507914C72EDB` |
| `thorn_matriarch_idle_armored_strip_normalized_v1.png` | `154EF76409CDDE0586FC649BDDD8EFC54ADF9C998F14CB7E97D1524CAA1751F7` |
| `thorn_matriarch_phase_break_strip_normalized_v1.png` | `9295E8976DF2297BD943FE14CED826F255156E9246D0CB8940B8426773F6C977` |
| `thorn_matriarch_idle_exposed_strip_normalized_v1.png` | `F4F8AA7809CDF840C29F48E477E19ED8E799D1B18E1A4F39BBEF054E03AED075` |
| `thorn_matriarch_sweep_tell_strip_normalized_v1.png` | `F634C81649FBF4F7046557AEF8F141A7E47B39B125B91DA561D5E17D3CAFF079` |
| `thorn_matriarch_sweep_attack_strip_normalized_v1.png` | `E8DA160EC5A835C5F4F52BD84BFE54730E0C88FE581AEE2F330E89A849DEB9A5` |
| `thorn_matriarch_mine_cast_strip_normalized_v1.png` | `0FC6D4E77189F088D2E04E03788BAAE5E726F7B6E7DDE43A543453F550954BEF` |
| `thorn_matriarch_fan_cast_strip_normalized_v1.png` | `F9E1DA99E0E8F09DF9F45C4669B10EF550CAF0901A493C00B30FE8A903075658` |
| `thorn_matriarch_hurt_strip_normalized_v1.png` | `7FEA4AC6F08A48ADAC66E78B5E946E47E13E5F1954F0948CA571E388120A754E` |
| `thorn_matriarch_death_strip_normalized_v1.png` | `F83DBC7BD057E4A9B437F014C22FB717F76A36C3F9EF93FB6213D2B4A83E6047` |

All normalized strips are 4800 x 900, `Format32bppArgb`, with transparent
corner pixels. Visual review confirmed four isolated poses per strip, a shared
ground baseline, readable phase states, and a progressively lower death
silhouette. Runtime integration still requires logical downscale review,
nearest-neighbor import settings, animation timing, collision and hitbox
timing, plus the separate projectile, hazard, portrait, VFX and SFX packages.

## Built-in source provenance

| Asset | Preserved built-in output |
|---|---|
| Rambutan queen design anchor | `exec-526afa4b-1071-43f0-a97e-818bbfe3955f.png` |
| Armored idle | `exec-a271d3d9-3e7d-49bd-aed2-bc4d63e459eb.png` |
| Phase break | `exec-eaea7e5c-37d7-4454-82dd-d7b04dd21160.png` |
| Exposed idle | `exec-8db3e756-9e96-428e-8115-e07eab291e66.png` |
| Sweep tell | `exec-a272d82d-9ad0-49b2-b6de-694347f04425.png` |
| Sweep attack | `exec-0d7b06e7-6ff1-4ae1-ace9-1c471e56e470.png` |
| Mine cast | `exec-e84e80d9-2095-4b67-bbd7-209cd0647f59.png` |
| Fan cast | `exec-7c898192-041a-44b9-adc7-285e2a4c3734.png` |
| Hurt | `exec-5931d02e-158a-4b12-ba1e-9202de43c2fb.png` |
| Death | `exec-47abeecc-ef43-4b1f-a40b-3de7258aba7c.png` |

## Prompts

### Rambutan queen design anchor

> Redesign the Thorn Matriarch as a rambutan queen-cluster boss for a detailed
> high-resolution pixel-art side-scrolling action-platformer. Preserve the
> broad immobile rooted base, two long thorny striking vines, large
> phase-readable central body, crisp pixel density, strong outline weight,
> and upper-left lighting. Replace the generic flower with a layered cluster
> of enormous red-to-yellow rambutan fruits: flexible green-tipped hairs form
> sweeping armor, two outer fruits merge into vine-head jaws, and closed rind
> plates conceal pale translucent flesh surrounding a glossy dark queen seed
> weak point. Add woody orchard branches, green calyx armor, restrained
> toxic-lime sap nodes, and violet alien root seams. Show the armored Phase 1
> neutral pose with the central weak point mostly closed but its pale flesh
> seams visible. Side-view gameplay silhouette facing right, significantly
> larger and more complex than a Thornling. One complete boss only. No
> projectiles, text, numbers, floor, or scenery.
>
> Transparent background.

### Armored idle

> Create a four-frame horizontal Phase 1 idle animation. Keep the same rooted
> queen-cluster body, two vine-head jaws, red-yellow rambutan hair armor,
> woody thorn branches, closed pale flesh seams, hidden dark queen seed,
> toxic-lime sap nodes, violet roots, side-view gameplay silhouette, scale,
> pixel density, palette, and lighting. Animate a restrained boss idle:
> neutral rooted stance, outer hair-spines ripple, both vine heads breathe and
> shift, sap nodes pulse while the central rind remains closed, then return
> toward neutral.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Phase break

> Create a four-frame horizontal Phase 1-to-Phase 2 armor-break transition.
> Keep the same boss design, scale, pixel density, palette, lighting, rooted
> base, and two vine heads. Animate the central rambutan cluster cracking
> under pressure, outer hair-rind plates peeling apart, pale translucent flesh
> opening in segmented lobes, then the glossy dark queen seed weak point
> becoming fully visible inside an aggressive open crown. Make the final
> exposed state clear and stable. No detached debris, projectile, or hit
> effect.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Exposed idle

> Create a four-frame horizontal Phase 2 exposed idle animation. Preserve the
> same rooted base, two vine-head jaws, rambutan hair armor, woody thorns, pale
> opened flesh lobes, fully visible glossy dark queen seed, toxic-lime nodes,
> violet roots, scale, pixel density, palette, and lighting. Keep the final
> open-crown design consistent. Animate a tense loop: exposed seed neutral,
> pale flesh flexes outward, dark seed and sap nodes pulse while vine heads
> lift, then return toward neutral. The weak seed remains visible in every
> frame.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Sweep tell

> Create a four-frame horizontal vine-sweep anticipation animation for this
> detailed rambutan Thorn Matriarch. Preserve the same boss design, rooted
> base, two fruit-jaw vines, red-yellow rambutan hair armor, woody thorns,
> closed pale flesh seams, toxic-lime nodes, violet roots, scale, crisp
> high-resolution pixel detail, palette, and upper-left lighting. Animate a
> clearly non-damaging telegraph: neutral rooted stance, both vine heads pull
> back to opposite sides, base braces and hair-thorns align along the arena
> lane, then a strong held anticipation pose. Do not show the actual sweep or
> any detached projectile.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Sweep attack

> Create a four-frame horizontal vine-sweep attack animation continuing from
> the anticipation. Preserve the rooted rambutan queen design, two fruit-jaw
> vines, armor, scale, detailed high-resolution pixel style, palette, and
> lighting. Animate a low vine lash, a high diagonal follow-up, maximum
> damaging extension, and recoil. Keep the central rooted body fully visible.
> Keep each complete pose compact inside its own quarter of the strip with a
> generous transparent gap separating it from adjacent poses. No detached
> projectiles or hit effects.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Mine cast

> Create a four-frame horizontal fruit-mine casting animation. Preserve the
> same rooted queen-cluster design, two fruit-jaw vines, red-yellow rambutan
> hair armor, woody thorns, closed central flesh seams, hidden queen seed,
> toxic-lime nodes, violet roots, scale, crisp high-resolution pixel detail,
> palette, and lighting. Animate the armored central cluster contracting,
> small side calyx pods swelling into round rambutan buds, both vine mouths
> opening upward, then a forceful release recoil. Keep every mine attached to
> the boss during this body animation; do not draw detached mines,
> projectiles, or impact effects.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Fan cast

> Create a four-frame horizontal thorn-fan casting animation. Preserve the
> same rooted queen-cluster design, two fruit-jaw vines, red-yellow rambutan
> hair armor, woody thorns, opened pale flesh lobes, fully visible glossy dark
> queen seed, toxic-lime nodes, violet roots, scale, crisp high-resolution
> pixel detail, palette, and lighting. Animate the exposed seed charging
> bright violet, pale flesh tightening, flexible hair-spines flaring radially
> into a clear firing fan, both vine heads aiming outward, then firing recoil.
> The seed remains visible in every frame. Do not draw detached thorn
> projectiles or impact effects.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Hurt

> Create a four-frame horizontal hurt and stagger animation. Preserve the same
> rooted queen-cluster design, two fruit-jaw vines, red-yellow rambutan hair
> armor, woody thorns, opened pale flesh lobes, visible glossy dark queen seed,
> toxic-lime nodes, violet roots, scale, crisp high-resolution pixel detail,
> palette, and lighting. Animate a readable non-gory reaction: the exposed
> seed dims and tilts from impact, pale flesh lobes compress inward, both vine
> heads recoil and wilt, the rooted base bends without moving, then the boss
> begins recovering toward exposed idle. Do not draw weapons, attackers,
> detached debris, hit flashes, or text.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Death

> Create a four-frame horizontal non-gory death animation. Preserve the same
> boss identity, red-yellow rambutan cluster, two fruit-jaw vines, opened pale
> flesh, dark queen seed, woody thorn anatomy, violet alien roots, scale,
> crisp high-resolution pixel detail, palette, and lighting. Animate the vine
> heads losing strength and wilting, rooted trunk splitting and sinking, hair
> armor collapsing around the dim dark seed, then a final inert low pile of
> split rambutan rind, pale flesh, and dead roots. The sequence must clearly
> lose height from frame to frame while the ground baseline remains fixed. No
> explosion, detached debris, gore, attacker, text, or scenery.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.
