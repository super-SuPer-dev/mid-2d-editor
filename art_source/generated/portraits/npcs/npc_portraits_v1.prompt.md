# NPC Dialogue Portrait Source Record — v1

- Asset family: `PORTRAIT-NPC-*`
- State: `Review` full-expression source package; existing single anchors remain integrated at runtime
- Art direction: detailed high-resolution pixel art, original Thai sci-fi field-team portraits, true transparent background
- Reference role: the currently integrated NPC anchors established identity, clothing, equipment and role

## Deliverables

| NPC | Expressions | Source | Normalized grid |
|---|---|---|---|
| Commander Anan | neutral, urgent, relieved | `commander_anan_portrait_states_v1.png` | `commander_anan_portrait_states_normalized_v1.png`, 3 × 900 px cells |
| Dr. Mali | analytical, alarmed, hopeful | `dr_mali_portrait_states_v1.png` | `dr_mali_portrait_states_normalized_v1.png`, 3 × 900 px cells |
| Technician Chai | neutral, amused, concerned | `technician_chai_portrait_states_v1.png` | `technician_chai_portrait_states_normalized_v1.png`, 3 × 900 px cells |

## Built-in ImageGen provenance

| Asset | Generated source ID | Normalized SHA-256 |
|---|---|---|
| Commander Anan expression set | `exec-6f3e9eb6-7b29-46aa-a92d-9553f2fe5248.png` | `295A7CA6FCAA9CDA034CAE427B15AC9CCAB218FB4394EF278D8CA3274E45EF9B` |
| Dr. Mali expression set | `exec-20b4d9f9-3023-480e-af27-77107c81e9fd.png` | `06E9B455DECBAA26B10391D15AB0BE6460E78E2C13F6BB932B3AFF722017DABC` |
| Technician Chai expression set | `exec-73082c51-d679-485e-ac45-09e9f29dab1f.png` | `9DE76D7B9DBBA63DF1EE117437F2AF4A01484A1EA9F88D66BEA739D34EC10E9F` |

## Final prompt summaries

- Anan: the established middle-aged Thai commander in olive ACO armor, scarf and headset; neutral, urgent and relieved.
- Mali: the established Thai xenobotanist with high bun, goggles, teal vest, scarf, specimen vial and botanical badge; analytical, alarmed and hopeful.
- Chai: the established Thai field engineer in orange workwear, utility vest, hearing protectors, gloves and cutter equipment; neutral, amused and concerned.
- Shared prompt: three identity-matched chest-up three-quarter portraits, radio-crop safe, no background or frame, transparent background.

## Technical validation

- Source strips are 2172 × 724 px with three exact 724 × 724 source cells and true alpha.
- Fixed-grid normalization produces 2700 × 900 px `Format32bppArgb` strips with three clean 900 × 900 cells.
- Every normalized canvas corner has zero alpha and all nine cells report zero nontransparent boundary pixels.
- Visual review confirms clear expression changes, locked identity/costume and safe briefing/radio crops.

Runtime expression slicing, speaker-catalog wiring, replacement or migration of the current single anchors, dialogue-layout validation and 1280 × 720 testing remain required before promotion to `Integrated`.
