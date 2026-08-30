# Contaminated Grassland World-Asset Generation Record

Asset IDs: `WORLD-PLATFORM-GRASSLAND`, `WORLD-HAZARD-GRASSLAND`

- Generated: 2026-08-27
- Tool: OpenAI built-in image generation
- Mode: Two separate transparent raster generations
- Art target: high-resolution pixel art on declared logical grids
- State: Level 1 runtime candidates; animation and human approval remain

## Platform final prompt

One seamless contaminated-grassland platform segment on a transparent
background, authored as a 256 × 64 logical pixel tile: crisp olive grass top,
dark Thai field soil, sparse tan roots, and small toxic-purple alien veins.
Strict 4:1 side-view rectangle, flat collision-ready top, matching left/right
edges, hard pixel clusters, limited 18-color palette, no perspective, no end
caps, no text, no creatures, no photoreal/painterly/3D rendering.

Runtime integration repeats the source horizontally through a CanvasItem shader
instead of stretching the bitmap. Ground depth is provided by a flat soil fill;
the tile itself is never vertically stretched.

## Hazard final prompt

One connected row of five uneven invasive alien thorns emerging from a shared
fibrous root mat, authored as a 128 × 64 logical pixel sprite: deep-purple
roots, red-magenta thorn bases, aged-tan tips, tiny toxic-lime sap nodes, hard
pixel clusters, flat baseline, transparent background, no floor, no detached
fragments, no photoreal/painterly/3D rendering.

## Technical inspection

| Runtime file | Dimensions | Format | Corner alpha |
|---|---:|---|---|
| `platform_tile.png` | 1983 × 793 | 32-bit ARGB PNG | 0/0/0/0 |
| `thorn_hazard.png` | 1774 × 887 | 32-bit ARGB PNG | 0/0/0/0 |
