# NPC Portrait Generation Record

Asset IDs: `PORTRAIT-NPC-ANAN`, `PORTRAIT-NPC-MALI`, `PORTRAIT-NPC-CHAI`  
Generated: 2026-08-26  
Tool: OpenAI built-in image generation  
Mode: Three separate transparent raster generations  
Art target: high-resolution pixel art on a 256 × 256 logical grid  
State: Anchor portraits integrated; expressions and human approval remain

## Shared final prompt contract

Use case: stylized-concept  
Asset type: transparent dialogue portrait for a high-resolution pixel-art 2D
game  
Scene/backdrop: none; genuinely transparent background  
Subject: exactly one fictional Thai NPC, chest-up three-quarter view, entire
head and shoulders visible, readable at a 160 × 160 UI display  
Style/medium: authentic high-resolution pixel art, authored as if on a 256 ×
256 logical canvas and enlarged with integer nearest-neighbor scaling; visible
consistent square pixel clusters, hard stepped contours, simplified facial
anatomy, limited 24-color palette, logical-pixel highlights, deliberately
non-realistic  
Constraints: actual transparent alpha, clean hard silhouette, no text/UI
frame/background/extra people/cropped head/watermark  
Avoid: photoreal faces, pores, realistic skin rendering, painterly brushwork,
airbrush, smooth gradients, anti-aliased vector curves, 3D/PBR rendering, depth
of field, noisy pixel-filter overlays, checkerboard backgrounds

NPC-specific prompt content:

- Commander Anan: fictional Thai male field commander, late 40s, calm and
  authoritative; olive field uniform, tactical headset, small aged-gold ACO
  insignia without letters; facing right; neutral focused expression.
- Dr. Mali: fictional Thai female xenobotanist, mid 30s, analytical and alert;
  dark field-science clothing, muted teal vest, goggles, compact sample scanner
  without text; facing left; analytical neutral expression.
- Technician Chai: fictional Thai male rural field engineer, early 40s, capable
  and dryly amused; faded-orange workwear, charcoal mechanic vest, protective
  earmuffs, clipped gloves, compact brush-cutter harness; facing right;
  restrained half-smile.

## Technical inspection

| Runtime file | Dimensions | Format | Corner alpha |
|---|---:|---|---|
| `commander_anan_neutral.png` | 1310 × 1200 | 32-bit ARGB PNG | 0/0/0/0 |
| `dr_mali_analytical.png` | 1214 × 1295 | 32-bit ARGB PNG | 0/0/0/0 |
| `technician_chai_neutral.png` | 1214 × 1295 | 32-bit ARGB PNG | 0/0/0/0 |

All portraits require nearest-neighbor runtime filtering. Additional
expressions should use identity-preserving edits of these anchors.
