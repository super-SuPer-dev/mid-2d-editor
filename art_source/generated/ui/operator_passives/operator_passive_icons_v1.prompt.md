# Operator Passive / Mastery Icon Source Record — v1

- Asset family: `ICON-PASSIVE-*`
- State: `Review` source package; not yet integrated into runtime UI
- Art direction: detailed high-resolution pixel art, aged-gold/olive military field-journal interface, true transparent background
- Shared contract: one text-free circular field-equipment badge per operator, strong central symbol, readable at HUD and mastery sizes

## Deliverables

| Operator | Passive | Source | Normalized asset |
|---|---|---|---|
| Tonkla | Field Recovery / ฟื้นฟูภาคสนาม | `passive_tonkla_field_recovery_v1.png` | `passive_tonkla_field_recovery_normalized_v1.png` |
| Rin | Rapid Evade / หลบฉับไว | `passive_rin_rapid_evade_v1.png` | `passive_rin_rapid_evade_normalized_v1.png` |
| Khem | Wide Cut / คมกว้าง | `passive_khem_wide_cut_v1.png` | `passive_khem_wide_cut_normalized_v1.png` |
| T-800 | Reinforced Chassis / โครงเสริมเกราะ | `passive_t800_reinforced_chassis_v1.png` | `passive_t800_reinforced_chassis_normalized_v1.png` |

## Built-in ImageGen provenance

| Asset | Generated source ID | Normalized SHA-256 |
|---|---|---|
| Tonkla — Field Recovery | `exec-b338b284-a730-4885-a6e8-858173c6dd22.png` | `9FB9FEEC477227C892CB62811B72221480441EAC4BF1C0B7A0295B84B7B77BCE` |
| Rin — Rapid Evade | `exec-12aa3b6f-cec5-4638-ae94-3a89e098dbae.png` | `11A6325139DFE2A6C098A8EC1D3C3D3A175162D8620B4E2E7C4F0765E99BFEC2` |
| Khem — Wide Cut | `exec-e17cb0c9-a862-488f-b15c-e41ffc66c270.png` | `30553AEA73E12101CE5B58D9F4C676E8356722D907ADC319A6AA5C60A910C7AF` |
| T-800 — Reinforced Chassis | `exec-65c0434b-2bf2-44da-805c-eadbaf82b72c.png` | `D5DC0B8FE9F1B788223546C98D110E6599D4C2AC6E8743D0AC0C8A13071A6CFE` |

## Final prompt summaries

- Field Recovery: a green sprout-heart receiving energy from three violet alien-sample canisters.
- Rapid Evade: a tactical boot with three cyan afterimages crossing a partial recharge arc.
- Wide Cut: a brush-cutter blade projecting a broad green fan that splits thorn silhouettes at both edges.
- Reinforced Chassis: an original layered synthetic torso/shield deflecting two incoming thorn fragments.
- Shared visual prompt: centered circular aged-gold field-equipment rim, dark charcoal/olive interior, detailed high-resolution pixel art, no text, transparent background.

## Technical validation

- Source PNGs are 1254 × 1254 px with true alpha.
- Connected-component normalization places each complete badge in a clean 1400 × 1400 px `Format32bppArgb` cell.
- Every normalized canvas corner has zero alpha and every outer edge has zero nontransparent pixels.
- A 64 × 64 nearest-neighbor review preserves four distinct reads: healing/sample collection, dash/cooldown, wide attack area and damage mitigation.
- No icon contains baked English or Thai text.

Runtime import settings, mastery-rank framing, tooltip localization, selected/disabled states and 1280 × 720 UI validation remain required before promotion to `Integrated`.
