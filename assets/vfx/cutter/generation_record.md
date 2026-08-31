# Cutter Combat VFX Runtime Record

- Asset family: `VFX-CUTTER-SET`
- Source package: `art_source/generated/vfx/cutter/`
- Runtime state: `Integrated` pilot for player attacks and enemy contact hits
- Presentation: four 800 × 800 frames, nearest filtering, binary alpha

| Effect | Runtime file | Binary-alpha SHA-256 | Runtime hook |
|---|---|---|---|
| Swing arc | `cutter_swing_arc_normalized_v1.png` | `70C16A23C52D8A398E742F3E9454825DD6F7B624C432B4100F73FE3DAAD58D54` | `PlayerController._start_attack()` |
| Organic contact | `cutter_organic_contact_normalized_v1.png` | `530E573CDAD4FF7DE7AA211474CEDB0A51EE2A64A2BD3B3DCB00950BBEED662D` | `EnemyController.take_damage()` |

Generated sources remain unchanged in `art_source/` for rollback. Charged-swing
and upgrade-activation variants remain in Review for a later combat-feedback
pass.
