# BOSS-THORN-MATRIARCH presentation source set v1

**State:** Review (not integrated)

**Generation mode:** Built-in image generation

**Fruit identity:** Rambutan queen cluster / พวงราชินีเงาะ

**Localization contract:** All generated presentation art is text-free. Boss
name, warning, phase and accessibility text must be rendered at runtime from
localization keys. Portrait, title, health-fill and phase-marker openings are
transparent.

## Package contract

| Asset | Grid / canvas | Runtime intent |
|---|---|---|
| Portrait states | 3 x 1, 800 x 800 cells | Armored, enraged/exposed and damaged/wilting crops |
| Boss-intro frame | 1800 x 1000 | Left portrait socket plus large title-safe opening |
| Boss-HUD frame | 2100 x 800 | Portrait socket, health opening and three phase sockets |
| Phase markers | 3 x 1, 800 x 800 cells | Armored rind, cracking crown and exposed seed |

Normalized assets preserve the built-in pixel detail without rescaling or
interpolation. Grid-cell normalization isolates the three portrait/icon states
and preserves all alpha inside each authored cell.

## Validation hashes

| Candidate | SHA-256 |
|---|---|
| `thorn_matriarch_portrait_states_normalized_v1.png` | `A3939D87EECC8D59A0D11267E52E3F445CAF987948C956E1455C1843E92DFEEF` |
| `thorn_matriarch_intro_frame_normalized_v1.png` | `75C1B3962B31431B86A8C4E361DF766E447D2202617E89617655E597EBFCE533` |
| `thorn_matriarch_boss_hud_frame_normalized_v1.png` | `F3439769890E8C2A995E1F9CD807301B6E1E33E8621425B9AFDC4D39B54EAE1D` |
| `thorn_matriarch_phase_markers_normalized_v1.png` | `9392E59966A7E52267DA621789475C9E3D191A62EE1F1D63E391816C1875D806` |

All normalized outputs are `Format32bppArgb` with transparent corner pixels.
Visual review confirmed stable portrait crops, distinct phase states, empty
runtime-text regions and no baked English or Thai text. Integration still
requires a 1280 x 720 layout pass, logical downscale, nearest-neighbor imports,
localized label fitting, contrast checks and Windows/Web validation.

## Built-in source provenance

| Asset | Preserved built-in output |
|---|---|
| Portrait states | `exec-c7db3999-c606-4d35-a45d-4eab4ac825ed.png` |
| Intro frame draft | `exec-87eac4ba-8d14-4bee-8109-4f16440d72d9.png` |
| Intro frame transparent-socket edit | `exec-3b8a195e-5998-43a8-b069-162156230b14.png` |
| Boss-HUD frame | `exec-8312b70d-2cd2-4e61-ae32-fbf947a19ec6.png` |
| Phase markers | `exec-48817abe-6bae-4002-9aab-f97b9933c4cf.png` |

## Prompts

### Portrait states

> Create a three-frame horizontal portrait strip for boss introductions,
> radio warnings, and the boss HUD. Show a consistent close portrait crop of
> the central rambutan queen cluster and the two fruit-jaw vines, without the
> rooted lower body. Expressions: armored dormant menace with closed pale
> flesh seams; enraged open crown with the glossy dark queen seed exposed;
> damaged and wilting with the seed dimmed. Preserve the detailed
> high-resolution pixel-art rendering, red-yellow rambutan hairs, ivory
> thorns, green calyx, toxic-lime nodes, violet seams, strong outline, and
> upper-left lighting. Face toward the viewer in a slight three-quarter angle.
> No frame, text, symbols, scenery, or projectiles.
>
> Exactly three equal cells in one horizontal row, one complete portrait per
> cell, identical crop and scale, generous transparent separation, no overlap
> or grid lines.
>
> Transparent background.

### Boss-intro frame

> Create one wide horizontal pixel-art overlay frame for a boss introduction
> at 1280x720. Build a thin asymmetrical border combining dark charcoal ACO
> metal, restrained brass corners, violet alien roots, red rambutan hairs,
> ivory thorns, and small toxic-lime nodes. Place a circular portrait socket
> on the left and a large clean transparent title-safe opening across the
> center and right for runtime English or Thai text. Keep decoration around
> the edges only, with a strong readable silhouette and no opaque background
> fill. No boss portrait inside the socket, no words, letters, numbers, logos,
> health bar fill, scenery, or mock screen.
>
> One isolated complete frame, wide landscape composition.
>
> Transparent background.

### Boss-intro socket correction

> Make the circular portrait socket interior transparent. Change only the
> pale gray fill inside the left circular portrait socket. Keep the
> surrounding rambutan-and-metal frame, all edge decoration, proportions,
> colors, pixel detail, and the already transparent title-safe opening
> unchanged. No portrait, text, symbols, or scenery.
>
> Transparent background.

### Boss-HUD frame

> Create one long, shallow horizontal pixel-art boss-health frame for a
> 1280x720 HUD. Combine a thin dark charcoal metal rail with restrained brass
> joints, violet root filaments, red rambutan hairs, ivory thorn tips, and
> small toxic-lime nodes. Include a compact circular portrait socket on the
> far left, one large transparent health-fill opening through the middle, a
> clean transparent boss-name safe area above or below the rail, and three
> small empty phase-marker sockets at the far right. Keep the silhouette
> compact enough for the top-center HUD and preserve maximum gameplay
> visibility. No portrait, health fill, words, letters, numbers, logos,
> background panel, or mock screen.
>
> One isolated complete HUD frame, wide landscape composition.
>
> Transparent background.

### Phase markers

> Create a three-cell horizontal strip of compact square pixel-art boss phase
> icons. Icon one: closed red rambutan rind protected by green-tipped hair
> armor. Icon two: cracked rind with pale flesh lobes beginning to open and a
> violet glow. Icon three: fully exposed glossy dark queen seed surrounded by
> pale rambutan flesh. Give all icons the same dark charcoal and brass circular
> socket rim, scale, pixel density, outline weight, palette, and upper-left
> lighting. Make them clear at small HUD size. No words, numbers, boss body,
> scenery, or extra symbols.
>
> Exactly three equal cells in one horizontal row, one complete centered icon
> per cell, generous transparent separation, no overlap or grid lines.
>
> Transparent background.
