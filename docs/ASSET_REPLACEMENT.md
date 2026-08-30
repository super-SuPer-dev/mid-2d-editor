# Replacing placeholder assets

Gameplay art now uses Inspector-ready `Sprite2D` nodes and operator portraits
use `TextureRect`. Select `BodyVisual`, `Visual`, or `Content/Portrait`, then
drop a PNG, WebP, SVG, or imported texture into its `Texture` property.
Collisions and scripts are separate, so changing artwork does not change play.

Replaceable slots are available in the player, enemy, sample, hazard,
projectile, portal, platform, level background, and reusable character-card
scenes. Scene textures are authoritative and are not replaced by scripts at
runtime. Their temporary source
textures live in `Assets/placeholders/`. Keep replacement art centered on the
same canvas size, or adjust only the art node's position and scale.

UI skins are also texture-driven. Replace `ui_background.svg`, `ui_panel.svg`,
`ui_button.svg`, `ui_button_hover.svg`, and `ui_button_pressed.svg` to reskin
every screen centrally. Individual screen backgrounds are editable
`TextureRect` nodes, while buttons remain semantic Godot `Button` controls.

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

Generated art can be stored under `art_source/generated/` during review. Move only
approved assets into `Assets/` and commit their Godot `.import` metadata with
the source image.
