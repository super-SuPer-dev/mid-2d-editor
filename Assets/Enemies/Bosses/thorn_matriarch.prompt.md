# Thorn Matriarch Generation Record

- Asset ID: `BOSS-THORN-MATRIARCH`
- Runtime file: `thorn_matriarch.png`
- Generated: 2026-08-26
- Tool: OpenAI built-in image generation
- Mode: New transparent raster generation
- Runtime dimensions: 1312 × 1199 PNG, 32-bit ARGB
- Art target: high-resolution pixel art on a 256 × 256 logical grid
- Integration state: Integrated; runtime visual review still required

## Final generation prompt

Use case: stylized-concept  
Asset type: transparent 2D side-scrolling game boss sprite  
Primary request: one complete Thorn Matriarch boss for a Thai sci-fi
action-platformer: a broad hostile alien flowering plant with a thick rooted
base, two thorny striking vines, layered red-magenta petals around a toxic green
core, and readable asymmetrical organic mutations  
Scene/backdrop: none; genuinely transparent background  
Style/medium: authentic high-resolution pixel art, authored as if on a 256 ×
256 logical pixel canvas and enlarged with integer nearest-neighbor scaling;
consistent visible square pixels, hard clustered edges, stepped curves,
simplified anatomy, limited 28-color palette, crisp logical-pixel highlights,
and deliberately non-realistic rendering  
Composition/framing: side-view gameplay silhouette, centered, generous
transparent padding, roughly square footprint, facing left, all roots grounded
on one horizontal baseline  
Color palette: field olive and toxic green, deep purple roots, red-magenta
petals, aged-tan thorn tips  
Constraints: actual transparent alpha, hard clean alpha edge, no text/UI/shadow
ellipse/extra creatures/detached fragments/cropped roots/animation frames/sprite
sheet/watermark  
Avoid: photorealism, realistic plant textures, painterly brushwork, airbrush
shading, smooth gradients, anti-aliased vector curves, 3D/PBR rendering,
cinematic depth of field, noisy pixel-filter overlays, checkerboard backgrounds

## Technical inspection

- All four corners are transparent (one corner stores alpha 1/255, visually
  transparent and rechecked under nearest-neighbor runtime rendering).
- The asset must use nearest-neighbor filtering in Godot.
- Human approval is still required before `Verified` or `Release-ready`.
