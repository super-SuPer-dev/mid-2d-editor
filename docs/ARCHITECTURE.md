# Game architecture

Low Altitude Warrior is a data-driven side-scrolling campaign built with
Godot 4.7. Scripts live in `src/`; reusable Godot scenes live in `Scenes/`.

## Player flow

```text
Main menu -> Character select -> Mission select -> Gameplay
                                                 |       |
                                             Defeat    Clear
                                                 |       |
                                               Retry   Next mission
```

`Scenes/main.tscn` is the project entrance. It contains the main menu as a
native scene instance and is the only scene configured under `run/main_scene`.

## Scene authoring rule

Production layouts are authored in `.tscn` files. Menus, operator cards,
mission rows, workshop rows, HUD labels, modal overlays, platforms, hazards,
pickups, enemies, and environment shapes must remain visible and editable in
the Godot scene tree. Scripts may bind catalog/save data, connect behavior, and
spawn transient gameplay effects, but must not construct screen or level
layouts with `new()` and `add_child()`.

## Runtime services

- `GameManager` owns the current run: operative, mission, crystals, enemy
  objective, movement state, and debug modes.
- `SaveManager` owns the persistent profile: unlocked and completed missions,
  best crystal results, selected operative, volume, and fullscreen state.
- `SceneManager` owns navigation and always clears pause state during changes.
- `AudioManager` is the stable entry point for UI and future gameplay audio.

## Authored scenes and data

- `CharacterCatalog` defines operative identity, health, speed, jump, damage,
  dash speed, and placeholder color.
- `LevelCatalog` defines mission metadata, balance, palette, and unlock order.
- `Scenes/levels/level_01.tscn` through `level_03.tscn` contain the actual
  environment, platforms, collisions, hazards, enemies, pickups, player spawn,
  and exit as native editor-visible Godot nodes.
- `LevelController` only connects gameplay behavior and mission state. It does
  not construct the world.

## Gameplay contracts

- Damageable actors implement `take_damage(amount, source_direction)`.
- `HealthComponent` owns reusable health, healing, damage, and death signals.
- Enemy death registers with `GameManager`; the exit activates when the mission
  objective is complete.
- The HUD binds to player health and manager signals. It also owns pause,
  defeat, completion, and campaign-completion modals.

## Campaign content

1. Contaminated Grassland — movement, thornlings, and the fallen seed trail.
2. Mutated Forest — larger platforming spaces, spore spitters, and carnivorous maws.
3. Alien Root Cave — mixed combat and the possessed banyan boss.

## Extension points

Add new character definitions to `CharacterCatalog.CHARACTERS`. Duplicate an
authored level scene and add its metadata to `LevelCatalog` and `SceneManager`.
New enemy behaviors should extend the
enemy type configuration or move into dedicated enemy scenes when their logic
becomes substantially different.
