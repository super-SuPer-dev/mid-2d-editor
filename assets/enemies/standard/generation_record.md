# Standard Enemy Generation Record

Asset IDs: `ENEMY-THORNLING`, `ENEMY-SPITTER`  
Generated: 2026-08-26  
Tool: OpenAI built-in image generation  
Mode: Two separate transparent raster generations  
Art target: high-resolution pixel art on a 128 × 128 logical grid  
State: Idle anchor sprites integrated; production animation sets remain

## Shared final prompt contract

Use case: stylized-concept  
Asset type: transparent 2D side-scrolling standard enemy sprite  
Scene/backdrop: none; genuinely transparent background  
Subject: exactly one complete alien plant creature, side view facing left, all
root-feet planted on one horizontal baseline, compact readable silhouette  
Style/medium: authentic high-resolution pixel art, authored as if on a 128 ×
128 logical canvas and enlarged with integer nearest-neighbor scaling;
consistent square pixel clusters, hard stepped contours, simplified anatomy,
limited 20-color palette, deliberately non-realistic  
Constraints: actual transparent alpha, clean hard edge, no text/UI/floor/shadow
ellipse/extra creatures/detached parts/animation sheet/watermark  
Avoid: photorealism, painterly brushwork, airbrush, smooth gradients,
anti-aliased vector curves, 3D/PBR rendering, realistic plant textures, noisy
pixel-filter overlays, checkerboard backgrounds

Enemy-specific prompt content:

- Thornling: small hostile contaminated-grassland plant with a low seed body,
  four root-legs, hooked thorn crown, snapping bud-mouth, muted-magenta mutation,
  and toxic-lime growth nodes; melee silhouette readable near 72 pixels tall.
- Spitter: squat hostile pitcher plant with three root-legs, horizontal tubular
  seed cannon, folded thorn leaves, purple mutation seams, and swollen toxic
  spore sac; ranged silhouette readable near 80 pixels tall.

## Technical inspection

| Runtime file | Dimensions | Format | Corner alpha |
|---|---:|---|---|
| `thornling.png` | 1312 × 1199 | 32-bit ARGB PNG | 0/0/0/0 |
| `spitter.png` | 1402 × 1122 | 32-bit ARGB PNG | 0/0/0/0 |

Both sprites use nearest-neighbor filtering. Static anchors are production
candidates, not substitutes for the required idle/move/attack/hurt/death sets.
