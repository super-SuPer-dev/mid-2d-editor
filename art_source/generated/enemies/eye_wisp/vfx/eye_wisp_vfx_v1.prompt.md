# Eye Wisp Detached VFX Source Record — v1

- Asset family: `ENEMY-EYE-WISP`
- Fruit identity: Longan / ลำไย
- State: `Review` source package; not yet integrated into runtime combat
- Art direction: detailed high-resolution pixel art, original Thai-fruit alien biology, true transparent background
- Reference role: the approved Eye Wisp hover, seed-bolt attack and beam-attack strips were supplied through a visual contact sheet as style/design references, not edit targets

## Deliverables

| Runtime purpose | Source | Normalized grid |
|---|---|---|
| Longan seed-eye bolt travel loop | `eye_wisp_longan_seed_bolt_v1.png` | `eye_wisp_longan_seed_bolt_normalized_v1.png`, 4 × 700 px centered cells |
| Seed-bolt impact lifecycle | `eye_wisp_seed_bolt_impact_v1.png` | `eye_wisp_seed_bolt_impact_normalized_v1.png`, 4 × 700 px centered cells |
| Sustained beam segment loop | `eye_wisp_beam_segment_v1.png` | `eye_wisp_beam_segment_normalized_v1.png`, 4 × 700 px centered cells |
| Right-facing beam endpoint loop | `eye_wisp_beam_endpoint_v1.png` | `eye_wisp_beam_endpoint_normalized_v1.png`, 4 × 700 px centered cells |

## Built-in ImageGen provenance

| Asset | Accepted generated source ID | Normalized SHA-256 |
|---|---|---|
| Longan seed-eye bolt | `exec-cbdc8574-110d-4912-a023-f58e963e855c.png` | `F03381F0731EDBD14F96B5A09E79322923779A50C1D420219D04FAF07C32B6F5` |
| Seed-bolt impact | `exec-eca5b830-bd0b-4c55-b413-31c705d27189.png` | `6616E289FFF8F589725E35EEB173793113CF2AD085717FC865351CF749BEC8C2` |
| Beam segment | `exec-98759ad3-500b-4d9c-8820-4f68a1ef2035.png` | `F0F115AC04FC4BE74FD381858B8A59916DF72207B0DB86BC69CC58AB85DA2393` |
| Beam endpoint | `exec-df066fb6-08dc-486d-b1a4-2f65602bf2bf.png` | `435E7CA1331281F6F084D7923C6CDDDFDB4150070E246AD5AC521D8E21215207` |

## Final prompt summaries

- Seed-eye bolt: four stable-scale travel frames of one narrow glossy black longan seed/pupil with pale flesh rim, copper rind cap, magenta vein and cyan-magenta trail.
- Bolt impact: compact contact flash, pupil-starburst with flesh/rind fragments, magenta/cyan breakup and fading afterglow.
- Beam segment: four equal-length cyan-white horizontal beam frames with magenta energy, pupil pulses and restrained longan/copper accents.
- Beam endpoint: four fixed-center right-facing impact pulses with a short incoming beam stub, vertical pupil flare, pale flesh light, magenta sap arcs and cyan sparks.
- Shared ending constraint: `Transparent background.`

## Technical validation

- Every normalized PNG is 2800 × 700 px with four 700 × 700 cells.
- Every normalized PNG reports `Format32bppArgb`.
- All four canvas corners have zero alpha.
- Every normalized cell has zero nontransparent pixels on its outer boundary.
- Connected-component normalization used alpha threshold 1 to preserve translucent glow while eliminating neighboring-frame contamination.
- Visual review confirmed a stable bolt silhouette, readable impact lifecycle, fixed beam centerline and anchored endpoint.

Runtime integration, projectile/beam collision sizing, animation timing, pooling, beam-length handling and gameplay-scale readability remain required before promotion to `Integrated`.
