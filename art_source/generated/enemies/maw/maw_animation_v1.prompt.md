# ENEMY-MAW animation source set v1

**State:** Review (not integrated)  
**Generation mode:** Built-in image generation  
**Model reference:** the original detailed Maw concept generated from the
campaign anchor plus the integrated Thornling enemy scale reference

## Animation contract

| Action | Frames | Loop | Runtime intent |
|---|---:|---|---|
| Idle | 4 | Yes | Subtle body rise and core pulse |
| Move | 4 | Yes | Heavy alternating root-leg scuttle |
| Anticipation | 4 | No | Braced, escalating bite wind-up |
| Attack | 4 | No | Launch, snap, impact hold, recoil |
| Hurt | 4 | No | Impact compression and recovery |
| Death | 4 | No | Buckle, collapse, core dark, inert hold |

The raw generated strips are retained as `maw_*_strip_v1.png`. Normalized
review strips use a strict 4 columns x 1 row grid at 2800 x 800 pixels:

- Cell size: 700 x 800 pixels
- Pivot guide: x = 350 within each cell
- Ground baseline: y = 740 within each cell
- Alpha threshold during normalization: 128
- Output: 32-bit RGBA PNG with transparent corners

Normalization detects the four largest solid-alpha connected components,
removes faint generated fringe, centers each complete pose, and aligns its
lowest solid pixel to the shared baseline. It does not rescale or interpolate
the art. The reusable command is:

```powershell
./tools/normalize_sprite_strip.ps1 -InputPath <raw-strip> -OutputPath <normalized-strip>
```

## Normalized validation

| Candidate | SHA-256 |
|---|---|
| `maw_idle_strip_normalized_v1.png` | `CB54FB36981177D7958F4DF8533880A655A3F33387CB405553439C31A23C4ECD` |
| `maw_move_strip_normalized_v1.png` | `B1E12691F4609BCBFF8E69AA28957BE8A0433E87BDC92A5418219CDA33C87E01` |
| `maw_anticipation_strip_normalized_v1.png` | `074E0C51DE9065184AB46D35A465E649D6654AA8F7F4F49338A8040D54C3E3A6` |
| `maw_attack_strip_normalized_v1.png` | `1D7D5766F0165911D69A57697499707948EF96D4BA7B3B68C5FEE70BB3113963` |
| `maw_hurt_strip_normalized_v1.png` | `0E73E022B73BBC5BFADD8BAA62C1FBB5BEAD463CD623A39A6A8CCED31F034CFF` |
| `maw_death_strip_normalized_v1.png` | `02935D96879635DBF0BF81136F325E90AEAB200F99A7848BAE0A7074D7014A22` |

Visual review confirmed no adjacent-frame contamination in idle, attack, and
death spot checks. Integration still requires logical downscale review,
nearest-neighbor import settings, collision/hitbox timing, and playback-speed
tuning in the game.

## Prompts

### Idle

> Create a four-frame horizontal idle animation strip for this detailed Maw
> enemy in a high-resolution pixel-art action-platformer.
>
> Keep the exact same Maw design, colors, lighting, outline weight, pixel
> detail, side-view orientation, and gameplay scale. The creature faces right
> in every frame. Show a subtle seamless idle loop: frame 1 neutral, frame 2
> jaw and root body rise slightly, frame 3 gentle breathing peak with a small
> violet-core pulse, frame 4 returning toward neutral.
>
> Exactly 4 equal square cells in one horizontal row. One complete creature
> per cell. Keep the same camera scale, foot baseline, center position, and
> generous padding in every cell. No labels, grid lines, or text.
>
> Transparent background.

### Move

> Create a four-frame horizontal walk animation strip for this detailed Maw
> enemy.
>
> Keep the same design, colors, side view, facing right, pixel detail, scale,
> and lighting. Animate a heavy root-leg scuttle: contact, passing, opposite
> contact, passing. The jaw and body bob slightly while the root feet clearly
> change position.
>
> Exactly 4 equal cells in one horizontal row, one complete creature per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Anticipation

> Create a four-frame horizontal bite-anticipation animation strip for this
> detailed Maw enemy.
>
> Keep the same design, colors, side view, facing right, pixel detail, scale,
> and lighting. Animate a readable wind-up: frame 1 alert idle, frame 2 roots
> brace and body leans back, frame 3 jaw opens wider while the violet core
> brightens, frame 4 maximum held anticipation immediately before a forward
> bite. Do not show the actual bite impact.
>
> Exactly 4 equal cells in one horizontal row, one complete creature per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Attack

> Create a four-frame horizontal bite-attack animation strip for this detailed
> Maw enemy.
>
> Keep the same design, colors, side view, facing right, pixel detail, scale,
> and lighting. Continue from the anticipation reference: frame 1 launches
> forward, frame 2 jaw snaps at maximum forward reach, frame 3 jaw remains
> closed at impact, frame 4 recoils toward the original position. Make the
> damaging reach and recovery timing visually clear.
>
> Exactly 4 equal cells in one horizontal row, one complete creature per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Hurt

> Create a four-frame horizontal hurt animation strip for this detailed Maw
> enemy.
>
> Keep the same design, colors, side view, facing right, pixel detail, scale,
> and lighting. Animate a short readable hit reaction: frame 1 impact recoil,
> frame 2 body and jaw compressed backward with the violet core dimmed, frame
> 3 roots regain balance, frame 4 returns toward idle. Do not add hit effects
> or projectiles.
>
> Exactly 4 equal cells in one horizontal row, one complete creature per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.

### Death

> Create a four-frame horizontal death animation strip for this detailed Maw
> enemy.
>
> Keep the same design, colors, side view, facing right, pixel detail, scale,
> and lighting. Animate a non-gory defeat: frame 1 roots buckle and the core
> flickers, frame 2 the jaw and body collapse downward, frame 3 the petals
> close as the core goes dark, frame 4 a final inert wilted root-and-petal body
> resting on the ground. The last frame must clearly read as dead and remain
> in place.
>
> Exactly 4 equal cells in one horizontal row, one complete creature per cell,
> fixed camera scale and ground baseline, no overlap, no text or grid lines.
>
> Transparent background.
