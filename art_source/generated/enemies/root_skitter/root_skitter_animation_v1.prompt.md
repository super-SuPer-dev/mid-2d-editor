# ENEMY-ROOT-SKITTER salak animation source set v1

**State:** Review (not integrated)

**Generation mode:** Built-in image generation

**Fruit identity:** Salak / สละ

**Visual source:** Detailed first-version Root Skitter plus the five-biome
campaign anchor

The redesign preserves the approved low crab-insect silhouette while making
salak anatomy explicit through reddish-brown snake-fruit scales, palm-root
legs, cream flesh seams, seed-dark claws and a violet sensory node. Cyan marsh
moisture remains a restrained supporting accent.

## Animation contract

| Action | Frames | Loop | Runtime intent |
|---|---:|---|---|
| Idle | 4 | Yes | Foreclaw flex and restrained sensory-node pulse |
| Scuttle | 4 | Yes | Fast alternating six-leg locomotion |
| Burrow tell | 4 | No | Non-damaging crouch, digging brace and ground pulse |
| Burrow | 4 | No | Body sinks until only the disturbed mound remains |
| Emerge attack | 4 | No | Surface break, forward eruption, claw slash and landing |
| Hurt | 4 | No | Compression, dimmed node and balance recovery |
| Death | 4 | No | Shell failure, node dark and inert split husk |

Raw built-in outputs are retained as `root_skitter_*_strip_v1.png`.
Normalized review strips use a strict 4 columns x 1 row grid at 2800 x 800
pixels:

- Cell size: 700 x 800 pixels
- Pivot guide: x = 350 within each cell
- Ground baseline: y = 740 within each cell
- Solid-alpha threshold: 128
- Output: 32-bit RGBA PNG with transparent corners
- No rescaling or interpolation during normalization

Normalization detects the four largest solid-alpha pose components, removes
faint generated fringe, centers each pose and aligns its lowest solid pixel to
the shared baseline. Loose mud and moisture particles remain attached only
when they belong to the selected pose component.

## Validation hashes

| Candidate | SHA-256 |
|---|---|
| `root_skitter_salak_anchor_v1.png` | `B495DB8212680AF97CCAD55CE67FC836304C44437538CD069D4E307456728AC7` |
| `root_skitter_idle_strip_normalized_v1.png` | `6D4BB4221F4CAD7E608FB2CC356DE511B6EC1EDE38C3E139262C540D7F52106B` |
| `root_skitter_scuttle_strip_normalized_v1.png` | `6726226F5BC8EFF11FAAF2D9A8AB0B429750C38753E5A2D2F3A05527EADDD596` |
| `root_skitter_burrow_tell_strip_normalized_v1.png` | `01E5EDAABABF8634D5B97849934258CDBD860FB1FE50299D83DD2A54E9AAE130` |
| `root_skitter_burrow_strip_normalized_v1.png` | `1FBBB75D973F20274EF16C44A238BD46C553A8C94E1F724EEC5DF5F000ABAAA9` |
| `root_skitter_emerge_attack_strip_normalized_v1.png` | `C4910DEF1EA2D2B9A65B1DC78EF1072A60ED05E4C0F31E96F276F9270117E790` |
| `root_skitter_hurt_strip_normalized_v1.png` | `CD5341B78423233B78D141CBF763E10C4B6F4ADA23281539AE9B78312DD1E07A` |
| `root_skitter_death_strip_normalized_v1.png` | `948D6B7E3884289D669E8CB710839238A6E374F98D9ABD6662D0CD7A8A863E11` |

All normalized strips are 2800 x 800, `Format32bppArgb`, with corner alpha
`0,0,0,0`. Visual review covered idle, burrow tell, burrow, emerge attack and
death. Every detected pose fits the 700-pixel cell width; the widest is the
648-pixel maximum-reach emerge-attack frame. Runtime integration still needs
logical downscale review, nearest-neighbor import settings, playback timing,
burrow visibility/collision transitions and damage-frame hitbox timing.

## Built-in source provenance

| Asset | Preserved built-in output |
|---|---|
| Salak design anchor | `exec-3e00f858-8f21-4f14-85fa-0cbc8703e41f.png` |
| Idle | `exec-21e8c508-6e35-46d7-8d70-1a3e497aa49e.png` |
| Scuttle | `exec-1ecf4df4-d483-4654-8807-be377de4737e.png` |
| Burrow tell | `exec-92c3f390-d590-4d48-b7a4-8a76cc9a020c.png` |
| Burrow | `exec-d0683540-dc3e-4627-962f-524f0135c178.png` |
| Emerge attack | `exec-0b0e0b36-825b-481e-955d-cd74640161dc.png` |
| Hurt | `exec-a24bfeea-02dc-455e-b2b6-0cf7447b4f0d.png` |
| Death | `exec-a57d6f26-db63-479b-9c7e-ca75a08f16bc.png` |

The preserved files remain under the Codex built-in generated-image store;
the accepted copies and normalized derivatives are stored in this project
directory.

## Prompts

### Salak design anchor

> Redesign this detailed Root Skitter as a salak-fruit mutation for a
> high-resolution pixel-art action-platformer.
>
> Preserve the low side-view crab-insect silhouette, six root legs, two
> shovel-shaped digging forelimbs, reeds, crisp pixel density, outline weight,
> and upper-left lighting. Make Thai salak identity readable through
> overlapping reddish-brown snake-fruit scales, clustered palm-root anatomy,
> small cream flesh seams, sharp seed-dark claws, and a protected violet
> sensory node. Add restrained wet cyan marsh highlights. It faces right and
> remains a fast standard enemy lower than the player, not a boss. One neutral
> alert pose. No text.
>
> Transparent background.

### Idle

> Create a four-frame horizontal idle animation strip for this detailed salak
> Root Skitter enemy.
>
> Keep the same reddish-brown snake-fruit scales, six root legs, shovel
> foreclaws, reeds, violet sensory node, wet cyan highlights, side view, facing
> right, pixel detail, scale, and lighting. Animate a low alert idle loop:
> neutral crouch, foreclaws flex, sensory node and water droplets pulse, return
> toward neutral.
>
> Exactly 4 equal cells in one horizontal row, one complete creature per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Scuttle

> Create a four-frame horizontal scuttle animation strip for this detailed
> salak Root Skitter enemy.
>
> Keep the same reddish-brown snake-fruit scales, six root legs, shovel
> foreclaws, reeds, violet sensory node, wet cyan highlights, side view, facing
> right, pixel detail, scale, and lighting. Animate a fast low six-leg scuttle:
> front contact, passing, opposite contact, passing. The body remains close to
> the ground while the scaled foreclaws clearly alternate.
>
> Exactly 4 equal cells in one horizontal row, one complete creature per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Burrow tell

> Create a four-frame horizontal burrow-anticipation animation. Keep the same
> reddish-brown snake-fruit scales, six root legs, shovel foreclaws, salak
> reeds, violet sensory node, wet cyan highlights, side view facing right,
> scale, pixel density, and lighting. Animate a clear non-damaging tell: alert
> crouch, foreclaws dig into mud, body lowers while reeds fold, final held pose
> with a cyan-violet ground pulse immediately before burrowing. Do not show
> disappearance or an attack.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and ground baseline, no overlap, no text or grid
> lines.
>
> Transparent background.

### Burrow

> Create a four-frame horizontal burrow animation. Keep the same design,
> colors, side view facing right, scale, pixel density, and lighting. Animate
> foreclaws driving down, the scaled body sinking halfway into marsh soil, only
> reeds and the top shell remaining, then a final small disturbed-mud mound
> with salak reeds visible. This is disappearance, not an attack.
>
> Exactly four equal cells in one horizontal row, fixed camera scale and ground
> baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Emerge attack

> Create a four-frame horizontal emerge-attack animation. Keep the same design,
> colors, side view facing right, scale, pixel density, and lighting. Animate
> scaled foreclaws breaking the mud surface, the body erupting upward and
> forward, both shovel claws slashing at maximum reach, then landing in a low
> recovery pose. Make damaging frames two and three visually obvious. No
> detached projectile.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and ground baseline, no overlap, no text or grid
> lines.
>
> Transparent background.

### Hurt

> Create a four-frame horizontal hurt animation. Keep the same design, colors,
> side view facing right, scale, pixel density, and lighting. Animate foreclaws
> recoiling, the low shell compressing while the sensory node dims, legs
> regaining balance, and a return toward alert idle. No hit effect or
> projectile.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and ground baseline, no overlap, no text or grid
> lines.
>
> Transparent background.

### Death

> Create a four-frame horizontal death animation. Keep the same design, colors,
> side view facing right, scale, pixel density, and lighting. Animate a
> non-gory defeat: legs fail and scales crack, body collapses low with salak
> reeds bending, violet sensory node goes dark and foreclaws loosen, final
> inert split salak-root shell resting on the ground.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and ground baseline, no overlap, no text or grid
> lines.
>
> Transparent background.
