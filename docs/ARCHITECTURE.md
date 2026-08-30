# Game architecture

Low Altitude Warrior is a data-driven side-scrolling campaign built with
Godot 4.7. Scripts live in `src/`; reusable Godot scenes live in `scenes/`.

## Player flow

```text
Main menu -> Character select -> Mission select -> Gameplay
                                                 |       |
                                             Defeat    Clear
                                                 |       |
                                               Retry   Next mission
```

`scenes/main.tscn` is the project entrance. It contains the main menu as a
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
  objective, `CLEAR_THREATS → BOSS_ACTIVE → EXTRACTION` phase transitions,
  boss signals, movement state, and debug modes.
- `SaveManager` owns the persistent profile: unlocked and completed missions,
  best crystal results, selected operative, Base Technology, Operator Mastery,
  story state, language, volume, fullscreen state, and v1→v2 migration.
- `LocalizationManager` loads the English/Thai CSV tables, applies the live
  locale, and provides deterministic English fallback.
- `StoryManager` tracks one-shot sequences and campaign act state; reusable
  presentation is owned by `DialogueOverlay`.
- `SceneManager` owns navigation and always clears pause state during changes.
- `AudioManager` is the stable entry point for UI and future gameplay audio.

## Authored scenes and data

- `CharacterCatalog` defines operative identity, health, speed, jump, damage,
  dash speed, passive ID, animation source, and Mastery scaling.
- `LevelCatalog` defines mission metadata, 5–7 minute segment contract,
  enemy roster, biome art-kit IDs, boss pattern set, projectile cap, story
  sequences, mission phases, balance, palette, and unlock order.
- `BossPatternCatalog` defines named projectile formations, telegraph/active/
  recovery timing, speed, safe-lane width, per-level cap, and cleanup events.
- `scenes/levels/level_01.tscn` through `level_03.tscn` contain the actual
  environment, platforms, collisions, hazards, enemies, pickups, player spawn,
  and exit as native editor-visible Godot nodes.
- `LevelController` only connects gameplay behavior and mission state. It does
  not construct the world.

## Gameplay contracts

- Damageable actors implement `take_damage(amount, source_direction)`.
- `HealthComponent` owns reusable health, healing, damage, and death signals.
- Standard-enemy death registers with `GameManager`; quota completion starts
  the boss phase, and only boss defeat activates extraction.
- `EncounterGate` owns one authored pre-boss beat. It keeps its assigned
  enemies dormant until physical player overlap, blocks forward travel during
  combat, and removes its barrier only after every assigned enemy emits
  `defeated_event`. Each standard threat belongs to exactly one gate.
- `BossProjectilePatternRunner` consumes `BossPatternCatalog`, telegraphs and
  cycles authored formations, pools transient projectiles, enforces the level
  cap, and clears owned shots on combat shutdown, pattern transition, defeat,
  retry, or scene teardown.
- The HUD binds to player health and manager signals. It also owns pause,
  defeat, completion, and campaign-completion modals.

## Campaign content

1. Contaminated Grassland — movement, thornlings, Spitters, and the fallen seed trail.
2. Mutated Forest — canopy routes, spore pressure, and carnivorous maws.
3. Roots Beneath Capsule 07 — impact tunnels, Capsule Husks, and the possessed banyan.
4. Devouring Root Marsh — sinking root routes, conduit hazards, and the Root Hydra.
5. Alien Eye Nexus — shifting platforms, elite mixed threats, and the Root-Core Eye.

## Extension points

Add new character definitions to `CharacterCatalog.CHARACTERS`. Duplicate an
authored level scene and add its metadata to `LevelCatalog`, its boss patterns
to `BossPatternCatalog`, and its route to `SceneManager`.
New enemy behaviors should extend the
enemy type configuration or move into dedicated enemy scenes when their logic
becomes substantially different.
