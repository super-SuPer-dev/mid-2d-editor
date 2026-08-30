# ENEMY-CAPSULE-HUSK santol animation source set v1

**State:** Review (not integrated)  
**Generation mode:** Built-in image generation  
**Fruit identity:** Santol / กระท้อน  
**Visual source:** Detailed first-version Capsule Husk plus the five-biome
campaign anchor

The redesign preserves the approved detailed armored-pod language while making
santol anatomy explicit through golden-brown rind plates, pale fibrous flesh,
a dark seed weak core and muted green calyx structures.

## Animation contract

| Action | Frames | Loop | Runtime intent |
|---|---:|---|---|
| Idle | 4 | Yes | Armored settling loop and restrained core pulse |
| Move | 4 | Yes | Heavy four-leg scuttle |
| Charge tell | 4 | No | Roots brace, rind plates lock and seams brighten |
| Charge | 4 | No | Launch, maximum reach, skid and recovery |
| Exposed-core attack | 4 | No | Rind opens, flesh parts, seed charges and pulses |
| Hurt | 4 | No | Compression, dimmed core and return toward idle |
| Death | 4 | No | Shell breaks, flesh collapses and core goes inert |

Raw generated strips are retained as `capsule_husk_*_strip_v1.png`.
Normalized strips use a strict 4 columns x 1 row grid at 2800 x 800 pixels:

- Cell size: 700 x 800 pixels
- Pivot guide: x = 350 within each cell
- Ground baseline: y = 740 within each cell
- Solid-alpha threshold: 128
- Output: 32-bit RGBA PNG with transparent corners
- No rescaling or interpolation during normalization

## Validation hashes

| Candidate | SHA-256 |
|---|---|
| `capsule_husk_santol_anchor_v1.png` | `7A620011193866863BE4A8AB3EAE5386CA18247DDE5B3E643D8CEC0A0C6B838D` |
| `capsule_husk_idle_strip_normalized_v1.png` | `C67864452C3510A8B100F40D9C791133BD5896CBBEF8E659BF1C82D160DB189A` |
| `capsule_husk_move_strip_normalized_v1.png` | `B28F46AD3768ED99AF048132BC2D459201546B7F4E1A7199C4810A49E5219354` |
| `capsule_husk_charge_tell_strip_normalized_v1.png` | `F5F9DC295F5C5DA45E727D64EB50FDD8C6982417CBC3EE789FE23E4A935774A3` |
| `capsule_husk_charge_strip_normalized_v1.png` | `C6E52B804415B4C9AB2CB86E6A942A36383BD915684315DE98F989B4AF9C9412` |
| `capsule_husk_core_attack_strip_normalized_v1.png` | `1684E173AA9E609F418E02B2E42101B2FB6B80207AD48E83F1FFC24235DBBC3A` |
| `capsule_husk_hurt_strip_normalized_v1.png` | `5AF055A24C77EE82676E90D8D25D458A78A37C2A6BC1FAB7F8275FF45D438E3C` |
| `capsule_husk_death_strip_normalized_v1.png` | `6E89732FDE3C4590B922D8132B1A98F3984938712283A26AFAFC31ECE7119A0A` |

All normalized strips are 2800 x 800, Format32bppArgb, with corner alpha
`0,0,0,0`. Visual review covered idle, charge tell, charge, exposed-core
attack, hurt and death. Integration still requires logical downscale review,
nearest-neighbor import settings, playback timing, collision/hitbox timing and
the separate emitted core projectile/VFX asset.

One rejected hurt generation used a flattened brown background. It was not
retained. A fresh concise generation produced the accepted true-alpha strip.

## Prompts

### Santol design anchor

> Redesign this detailed Capsule Husk as a santol-fruit mutation for a
> high-resolution pixel-art action-platformer.
>
> Preserve the detailed side-view armored pod silhouette, four root legs,
> opening shell construction, crisp pixel density, outline weight, and
> upper-left lighting. Make the Thai santol identity readable through a thick
> golden-brown rind, pale fibrous segmented flesh visible between armor plates,
> dark seed-like weak core inside, and a few muted green calyx shapes merging
> with the metal-organic shell. Keep restrained violet alien energy in the
> exposed core. It faces right and remains a compact standard enemy, not a
> boss. One neutral idle pose. No text or numbers.
>
> Transparent background.

### Idle

> Create a four-frame horizontal idle animation strip for this detailed santol
> Capsule Husk enemy.
>
> Keep the same design, golden rind armor, pale segmented flesh, dark violet
> seed core, root legs, side view, facing right, pixel detail, scale, and
> lighting. Animate a subtle armored idle loop: neutral, shell settles inward,
> faint seam-and-core pulse, return toward neutral.
>
> Exactly 4 equal cells in one horizontal row, one complete creature per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Move

> Create a four-frame horizontal walk animation strip for this detailed santol
> Capsule Husk enemy.
>
> Keep the same design, golden rind armor, pale segmented flesh, dark violet
> seed core, root legs, side view, facing right, pixel detail, scale, and
> lighting. Animate a heavy four-legged armored scuttle: front contact, passing
> pose, rear contact, passing pose. Keep the shell weight visible with a small
> body bob while every foot remains readable.
>
> Exactly 4 equal cells in one horizontal row, one complete creature per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Charge tell

> Create a four-frame horizontal armored-charge anticipation strip for this
> detailed santol Capsule Husk enemy.
>
> Keep the same design, golden rind armor, pale segmented flesh, dark violet
> seed core, root legs, side view, facing right, pixel detail, scale, and
> lighting. Animate a clear non-damaging tell: alert idle, roots spread and
> brace, shell plates lock forward over the core, final crouched hold with
> green seams and the hidden core glowing before the charge. Do not show
> forward movement or impact.
>
> Exactly 4 equal cells in one horizontal row, one complete creature per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Charge

> Create a four-frame horizontal armored-charge attack strip for this detailed
> santol Capsule Husk enemy.
>
> Keep the same design, golden rind armor, pale segmented flesh, dark violet
> seed core, root legs, side view, facing right, pixel detail, scale, and
> lighting. Continue from the locked-shell tell: launch forward low, maximum
> armored forward reach, hard skid with the shell still closed, recoil and
> begin recovery. Make the damaging front edge and recovery timing obvious.
>
> Exactly 4 equal cells in one horizontal row, one complete creature per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Exposed-core attack

> Create a four-frame horizontal exposed-core attack strip for this detailed
> santol Capsule Husk enemy.
>
> Keep the same design, golden rind armor, pale segmented flesh, dark violet
> seed core, root legs, side view, facing right, pixel detail, scale, and
> lighting. Animate the vulnerable attack state: shell plates begin opening,
> pale santol flesh segments peel back, the dark seed core becomes fully
> exposed and charges violet energy, then releases a short forward energy pulse
> while remaining open. The weak core must be clearly readable in frames 3 and
> 4. Do not draw a detached projectile.
>
> Exactly 4 equal cells in one horizontal row, one complete creature per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Hurt

> Create a four-frame horizontal hurt animation strip for this detailed santol
> Capsule Husk.
>
> The creature faces right. Keep its golden rind armor, pale santol flesh, dark
> violet seed core, four root legs, crisp high-resolution pixel detail, scale,
> and lighting. Show impact recoil, compressed shell and dim core, regaining
> balance, then returning toward idle. No hit effect and no text.
>
> Four separated poses in one horizontal row.
>
> Transparent background.

### Death

> Create a four-frame horizontal death animation strip for this detailed
> santol Capsule Husk enemy.
>
> Keep the same design, golden rind armor, pale segmented flesh, dark violet
> seed core, root legs, side view, facing right, pixel detail, scale, and
> lighting. Animate a non-gory defeat: legs buckle and shell cracks open, pale
> flesh collapses as the seed core flickers, rind plates fall inward and the
> core darkens, final inert split santol husk resting on the ground. The last
> frame must clearly read as dead and remain in place.
>
> Exactly 4 equal cells in one horizontal row, one complete creature per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.
