# Rice Root Props — Generation Record

- Source output: `C:\Users\ADMIN\.codex\generated_images\01a03d2f-403d-71c0-bf48-8763b6c38dd8\exec-47afce0c-7bd2-4530-af1e-76372864c00b.png`
- Source dimensions: 1536 × 1024 px, RGBA
- Generation mode: built-in ImageGen
- Prompt intent: high-resolution pixel-art northeastern Thai rice-field foreground props (rice bundles, broken irrigation marker, grass and invasive roots) on a genuinely transparent background; hard pixel edges; no realistic painting, text, UI, characters or baked language
- Source asset: `rice_root_props_v1.png`
- Runtime asset: `assets/world/level_01_contaminated_grassland/props/rice_root_props_v1.png`
- Runtime preparation: alpha threshold ≥ 24 to remove soft fringe while preserving the silhouette; nearest filtering
- Scene placement: `Environment/RiceRootPropsA` and `Environment/RiceRootPropsB` in `scenes/levels/level_01.tscn`, z-index -4, scales 0.24/0.20, no collision
- Runtime SHA-256: `0E03BE31DC89CAEFA5ADECF9F51C021692C1901B92BC34025B371570B19CF6D4`
- Localization impact: none; the image contains no text
- Acceptance: true alpha, no semi-transparent runtime pixels, no traversal occlusion, and no HUD obstruction at 1280 × 720
