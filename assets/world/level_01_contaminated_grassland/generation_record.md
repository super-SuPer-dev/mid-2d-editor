# Level 1 Grassland Runtime Record

- Asset family: `WORLD-L1-GRASSLAND`
- Source: `art_source/generated/world/level_01_contaminated_grassland/contaminated_grassland_backdrop_v1.png`
- Runtime: `parallax/grassland_backdrop_v1.png`
- Dimensions: 1672 × 941 px, RGB
- Runtime SHA-256: `1B677F5E37FCD82C3A6B7096A2924EF0115A2B08A46570279A97CA8F8840B2CC`
- Import: nearest filtering, aspect-preserving 0.766 scale, presentation-only z-index -100
- Runtime scene: `scenes/backgrounds/grassland_generated_parallax.tscn`
- Landmark source: `art_source/generated/world/level_01_contaminated_grassland/landmarks/irrigation_root_tower_v1.png`
- Landmark runtime: `landmarks/irrigation_root_tower_v1.png`
- Landmark dimensions: 1024 × 1536 px, RGBA source normalized to binary alpha for runtime
- Landmark runtime SHA-256: `90B7AB226AC74EC9E0B52445C47A826781D80C841D71BF431A39389608CB1B7B`
- Landmark placement: `Environment/IrrigationRootLandmark`, z-index -5, scale 0.34, no collision
- Foreground prop source: `art_source/generated/world/level_01_contaminated_grassland/props/rice_root_props_v1.png`
- Foreground prop runtime: `props/rice_root_props_v1.png`
- Foreground prop dimensions: 1536 × 1024 px, RGBA source normalized to binary alpha for runtime
- Foreground prop placement: `Environment/RiceRootPropsA` and `Environment/RiceRootPropsB`, z-index -4, scales 0.24/0.20, no collision
- Foreground prop runtime SHA-256: `0E03BE31DC89CAEFA5ADECF9F51C021692C1901B92BC34025B371570B19CF6D4`
- Localization impact: none; no baked text or language-specific copy

The previous `grassland_parallax.tscn` remains available for rollback. Modular
tile variants, foreground props, memory and human pixel-art review remain open.
