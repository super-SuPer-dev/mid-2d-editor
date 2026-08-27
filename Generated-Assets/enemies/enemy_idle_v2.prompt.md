# Standard enemy idle anchors — v2

**State:** Review (source candidates only)  
**Generation mode:** Built-in image generation  
**Art direction:** Original high-resolution pixel art; English-first project;
no baked text  
**Reference roles:**

- `art_refs/generated_campaign_style_anchor.png` — campaign palette, biome and
  alien-biology direction
- `Assets/Enemies/Standard/thornling.png` — runtime scale, pixel density,
  outline and lighting reference
- `Assets/Enemies/Standard/spitter.png` — runtime scale, pixel density,
  outline and lighting reference

The references are style and scale inputs only. None was edited or copied.

## Technical validation

| Asset ID | Candidate | Dimensions | Format | Corner alpha | SHA-256 |
|---|---|---:|---|---|---|
| ENEMY-MAW | `maw_idle_v2.png` | 1402 x 1122 | PNG RGBA | 0,0,0,0 | `E5AEEC1E3ECDB03E4BE05CE5D69710C9DD015513A1F78DC0A3E1281B7B2661DA` |
| ENEMY-CAPSULE-HUSK | `capsule_husk_idle_v2.png` | 1536 x 1024 | PNG RGBA | 0,0,0,0 | `A51814565A5123B494011E21697D450107B136BDA557F46DD98CAF4E36BC6847` |
| ENEMY-ROOT-SKITTER | `root_skitter_idle_v2.png` | 1536 x 1024 | PNG RGBA | 0,0,0,0 | `D098EEA63DDC77DBFFD4C25C50829E8BEEDEB0DFB4CD3DF0CBD36F35A980FA3A` |
| ENEMY-EYE-WISP | `eye_wisp_idle_v2.png` | 1536 x 1024 | PNG RGBA | 0,0,0,0 | `D8FDE84157B6FAC6FE182154CA91E978B9CE2D07F819BEFB833BE6458B96326D` |

All four candidates use 32-bit ARGB storage and passed transparent-corner
validation. Runtime promotion still requires crop/padding review, silhouette
approval at logical gameplay size, baseline/pivot definition, memory review,
and animation production.

An earlier over-specified prompt produced flattened checkerboard backgrounds.
Those rejected files were not retained. The concise prompts below produced
true alpha and are the approved prompt pattern for future isolated sprites.

## ENEMY-MAW prompt

> Create a single side-view enemy sprite for a high-resolution pixel-art
> action-platformer.
>
> A squat carnivorous alien flower called the Maw, facing right, with a broad
> snapping teal-green petal jaw, violet biological core, thick root legs, and
> two short vine arms. It is a standard enemy, smaller than a boss. Match the
> crisp pixel density, outline weight, lighting, and gameplay scale of the
> enemy references, using the forest palette from the campaign reference. One
> neutral idle pose only. No text.
>
> Transparent background.

## ENEMY-CAPSULE-HUSK prompt

> Create a single side-view enemy sprite for a high-resolution pixel-art
> action-platformer.
>
> A compact grounded alien seed-shell creature called the Capsule Husk,
> facing right. It has a low beetle-like pod silhouette, layered charcoal
> metal-organic armor, four sturdy root legs, green seams, and a small violet
> core visible between shell plates. The armor must look capable of opening to
> expose the core. It is a standard enemy, smaller than a boss. Match the crisp
> pixel density, outline weight, lighting, and gameplay scale of the enemy
> references, using the underground Capsule 07 palette from the campaign
> reference. One neutral idle pose only. No text or numbers.
>
> Transparent background.

## ENEMY-ROOT-SKITTER prompt

> Create a single side-view enemy sprite for a high-resolution pixel-art
> action-platformer.
>
> A low, fast marsh ambusher called the Root Skitter, facing right. Its wide
> crab-insect silhouette is built from wet tangled roots and reed-like armor,
> with six low root legs, two large shovel-shaped forelimbs for burrowing, a
> protected violet sensory node, and a few marsh reeds on its back. It is
> compact and lower than the player, not boss-sized. Match the crisp pixel
> density, outline weight, lighting, and gameplay scale of the enemy
> references, using the brown, olive, cyan, and violet marsh palette from the
> campaign reference. One neutral alert idle pose only. No text.
>
> Transparent background.

## ENEMY-EYE-WISP prompt

> Create a single side-view enemy sprite for a high-resolution pixel-art
> action-platformer.
>
> A small floating ranged enemy called the Eye Wisp, facing right. It has one
> large horizontal eye inside a broken seed-ring, five short neural-root
> tendrils trailing backward and downward, and a compact magenta energy organ
> beneath the eye for a future charge tell. Its silhouette is eerie, elegant,
> and lightweight, clearly smaller and simpler than the final eye boss. Match
> the crisp pixel density, outline weight, lighting, and gameplay scale of the
> enemy references, using the near-black plum, violet, magenta, and pale-cyan
> Level 5 palette from the campaign reference. One neutral hover pose only. No
> projectile and no text.
>
> Transparent background.
