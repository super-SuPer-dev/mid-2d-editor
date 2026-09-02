# Operator Dialogue Portrait Source Record — v1

- Asset family: `PORTRAIT-OP-*`
- State: `Review` source package; not yet integrated into dialogue UI
- Art direction: detailed high-resolution pixel art, original non-realistic Thai sci-fi field operators, true transparent background
- Reference role: the current fixed operator sprite sheets established identity, clothing and equipment; approved portrait outputs established the shared finish

## Deliverables

| Operator | Expressions | Source | Normalized grid |
|---|---|---|---|
| Tonkla | neutral, determined | `operator_tonkla_portrait_states_v1.png` | `operator_tonkla_portrait_states_normalized_v1.png`, 2 × 900 px cells |
| Rin | neutral, determined | `operator_rin_portrait_states_v1.png` | `operator_rin_portrait_states_normalized_v1.png`, 2 × 900 px cells |
| Khem | neutral, determined | `operator_khem_portrait_states_v1.png` | `operator_khem_portrait_states_normalized_v1.png`, 2 × 900 px cells |
| T-800 | neutral, alert | `operator_t800_portrait_states_v1.png` | `operator_t800_portrait_states_normalized_v1.png`, 2 × 900 px cells |

## Built-in ImageGen provenance

| Asset | Accepted generated source ID | Normalized SHA-256 |
|---|---|---|
| Tonkla portrait states | `exec-a2644f3b-1f83-47ab-a023-77f18554d0c6.png` | `6C02C144E941305D6F185FE512AE8E90D7DF6AAF19384CB0FEE5140771F683E0` |
| Rin portrait states | `exec-dba58451-efde-4790-83e5-a74e37828163.png` | `45C0301CB39F8CEA95724B5F59BCA543DBC425D27BDD260D2A902950D002CC5A` |
| Khem portrait states | `exec-73c51d1a-ff61-4003-b3a8-b12c27c78b3a.png` | `DD940D4EB696CD0B56FA7D0AECC051FC41E1136F20A087C106B58E2135D33625` |
| T-800 portrait states | `exec-49cd2510-476b-4d86-b144-2b247faaf72e.png` | `EEAB686F2F73511C21B06166C95733E172CA70483FDE7658620402DE611A4BDA` |

## Final prompt summaries

- Tonkla: adult Thai male, black cap, orange-charcoal ACO workwear, radio, harness and red cutter-engine detail; neutral and determined.
- Rin: adult Thai woman ranger, black tactical cap, charcoal/deep-olive special-forces workwear, light armor and radio; neutral and determined.
- Khem: adult Isan Thai male volunteer, uncovered tousled hair, red-brown workwear, restrained pha khao ma scarf, radio and cutter harness; neutral and determined.
- T-800: original black/gunmetal synthetic with integrated segmented helmet, silver faceplate, narrow amber-red visor, radio and red cutter engine; neutral and alert.
- Shared prompt: two identity-matched chest-up three-quarter portraits, radio-crop safe, no background or frame, transparent background.

## Technical validation

- Source strips are 1774 × 887 px with two equal 887 px source cells and true alpha.
- Normalized strips are 1800 × 900 px, `Format32bppArgb`, with two clean 900 × 900 cells.
- Tonkla and Khem use connected-component normalization; Rin and T-800 use fixed-grid normalization because antialiased source pixels touched at the exact midpoint.
- Every normalized canvas corner has zero alpha and both cells report zero nontransparent boundary pixels.
- Visual review confirmed consistent identity between expressions, distinct operator silhouettes and safe bust crops for radio/briefing layouts.

Runtime portrait slicing, expression IDs, dialogue catalog wiring, selected-language UI fitting and 1280 × 720 validation remain required before promotion to `Integrated`.
