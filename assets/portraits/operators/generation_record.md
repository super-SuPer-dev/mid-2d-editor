# Operator Portrait Runtime Record

- Asset family: `PORTRAIT-OP-*`
- Source package: `art_source/generated/portraits/operators/`
- Runtime state: `Integrated` pilot; English dialogue selects expression atlas frames
- Presentation: two 900 × 900 cells per operator, nearest filtering, no collision

Runtime copies use binary alpha for crisp pixel-art edges. Generated sources are
preserved unchanged for rollback and visual comparison.

| Operator | Runtime sheet | Expressions | Binary-alpha SHA-256 |
|---|---|---|---|
| Tonkla | `tonkla_portrait_states_normalized_v1.png` | neutral, determined | `978134259EC12557FDF4108A498F49F18B1C76B13AAE901CDDC0D517B5EE8A16` |
| Rin | `rin_portrait_states_normalized_v1.png` | neutral, determined | `20DDC379772B24AE0C4C16B128A74483CF4457F17811F4840B89CC11106EA3A6` |
| Khem | `khem_portrait_states_normalized_v1.png` | neutral, determined | `5D3A984317259A2984CDA463DD4B709D37428E7FF70D067445F5E19BFE02E4D8` |
| T-800 | `t800_portrait_states_normalized_v1.png` | neutral, alert | `516ABF800FE6CA127B73D2347B3D8B1EC9DD5DD400230485DEBB8B1E65F960FD` |

The source sheets and runtime copies intentionally remain separate so the
binary-alpha remediation is reversible. Final portrait crop, bilingual text
fit and human pixel-art review remain open.
