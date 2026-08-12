# Replacing placeholder assets

The current presentation uses `Polygon2D`, `ColorRect`, default fonts, and one
click sound. These are deliberate placeholders; gameplay does not depend on
their geometry.

## Recommended pixel-art specification

- Native render resolution: 1280 × 720
- Gameplay camera zoom: 2×, preserving the readable pixel-art scale while UI
  and rendering remain true 720p
- Base tile: 16 x 16 pixels
- Player frame: about 32 x 48 pixels
- Standard enemy frame: about 40 x 40 pixels
- Boss frame: about 80 x 80 pixels
- UI icons: 16 x 16 or 24 x 24 pixels
- Filtering: nearest-neighbor / Godot texture filter `Nearest`

## Safe replacement points

- Player: replace `BodyVisual` in `Scenes/actors/player.tscn` with an
  `AnimatedSprite2D`. Preserve `CollisionShape2D`, `AttackArea`,
  `HealthComponent`, and `Camera2D`.
- Enemy: replace `Visual` and `Eye` in `Scenes/actors/enemy.tscn`. Preserve the
  body collision, `HurtBox`, health component, and health bar.
- Pickups, hazards, projectiles, and portal: replace only each scene's visual
  polygon nodes.
- Level art: replace procedural platform polygons with a TileMap while keeping
  the same world collision layer (layer 1).
- UI: replace the default font and style boxes in `UIFactory`; every screen and
  gameplay modal will inherit the change.

## Animation hooks to add later

Use these animation names consistently: `idle`, `run`, `jump`, `fall`, `dash`,
`attack`, `hurt`, and `death`. Character gameplay stats should remain in
`CharacterCatalog`, not inside sprite resources.

Generated art can be stored under `Generated-Assets/` during review. Move only
approved assets into `Assets/` and commit their Godot `.import` metadata with
the source image.
