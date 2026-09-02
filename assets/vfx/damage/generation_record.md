# Damage and Status VFX Runtime Record

- Asset family: `VFX-DAMAGE-SET`
- Source package: `art_source/generated/vfx/damage/`
- Runtime state: `Integrated` pilot for health, boss and hazard feedback
- Presentation: four 800 × 800 frames, nearest filtering, binary alpha

| Effect | Runtime file | Binary-alpha SHA-256 | Runtime hook |
|---|---|---|---|
| Player hit | `damage_player_hit_normalized_v1.png` | `F367D65CB04E6377371803C8CF970C0CCA730511C3741E53C5E95A9E5BA893A6` | `PlayerController.take_damage()` |
| Organic hit | `damage_organic_hit_normalized_v1.png` | `36D8DEBDDA721B59AF174E4762D58DBDA4800296DB6ECBFE48908916E0F64A67` | `EnemyController.take_damage()` standard enemies |
| Armored hit | `damage_armored_hit_normalized_v1.png` | `02DFF60AF33749975A4BB4B1481E4B3A785C2B42681E60913BC8225A43075426` | `EnemyController.take_damage()` bosses |
| Boss-core hit | `damage_boss_core_hit_normalized_v1.png` | `5EAFA115365DF970C1C4EE26050433B785869A0823D7918C05782EE7271BD872` | Root-Core Eye damage |
| Root contamination | `status_root_contamination_normalized_v1.png` | `B8AAB1F31E866BC693A91534B0147B5F41D5B309150D07E72DF1CD516E65CB7D` | Hazard contact status overlay |

Generated sources remain unchanged in `art_source/` for rollback. Final blend
mode, duration tuning and human readability review remain open.
