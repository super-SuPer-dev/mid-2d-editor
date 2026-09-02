# Operator Mastery Shell Runtime Record

- Asset family: `UI-MASTERY`
- Source package: `art_source/generated/ui/mastery/`
- Runtime state: `Integrated` shell pilot on the character-upgrades screen
- Presentation: text-free 1800 × 1000 binary-alpha frame, nearest filtering,
  full 1280 × 720 coverage, runtime-controlled English/Thai text

| Runtime file | Binary-alpha SHA-256 | Runtime hook |
|---|---|---|
| `operator_mastery_screen_normalized_v1.png` | `17D7DF46C82FCACC1EEF2183F28FC1A49225DA6D4666B67CB6B1F9FCA2F93EBA` | `scenes/ui/character_upgrades.tscn` MasteryFrame |
| `mastery_rank_nodes_normalized_v1.png` | `8F56DFC0614A36FC85E45DF26A2BAD06F99BD01E0324738A1B6427B5ED992086` | `CharacterUpgrades._set_rank_track()` |

Generated sources remain unchanged in `art_source/` for rollback. Rank-node
states and final interaction-state review remain open.
