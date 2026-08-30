# Operator Mastery UI Source Record — v1

- Asset family: `UI-MASTERY`
- State: `Review` source package; not yet integrated into runtime UI
- Art direction: detailed high-resolution pixel art, dark charcoal/olive ACO field-journal interface, aged-brass hardware, true transparent background
- Localization contract: shell and rank nodes contain no baked English, Thai or numerals

## Deliverables

| Asset | Source | Normalized asset |
|---|---|---|
| Operator Mastery screen shell | `operator_mastery_screen_v1.png` | `operator_mastery_screen_normalized_v1.png`, 1800 × 1000 px |
| Rank 0–5 node states | `mastery_rank_nodes_v1.png` | `mastery_rank_nodes_normalized_v1.png`, 6 × 750 px cells |

## Built-in ImageGen provenance

| Asset | Accepted generated source ID | Normalized SHA-256 |
|---|---|---|
| Mastery screen | `exec-13152dc8-0e01-48d7-a09e-c290dcf6451d.png` | `DA36D02E962507A505270F9E90F8B0B97F10C391285DE01720A794BF77C49A2F` |
| Mastery rank nodes | `exec-fd25838f-9ba4-4d4e-9c18-3997cf74313c.png` | `B167B2A0C04AD8781A07B1C721F1B4679D72DBB310A998D05E9EA179376582BD` |

## Final prompt summaries

- Mastery shell: 16:9 portrait area, four operator tabs, passive-badge socket, description region, connected six-node track, six bonus rows, cost module and action sockets.
- Rank nodes: six identical aged-brass circular nodes progressing visually from dormant through olive-gold illumination to a white-gold capstone star.
- Shared prompt: square corners, worn military texture, no baked text/numerals, transparent outside the interface silhouette.
- The first mastery-shell draft used a visible checkerboard outside the frame; the accepted source is the targeted background-extraction revision with genuine alpha.

## Technical validation

- The normalized screen is 1800 × 1000 px and the node atlas is 4500 × 750 px.
- Both normalized assets report `Format32bppArgb`.
- Every canvas corner and outer edge has zero alpha; all six node cells report zero nontransparent boundary pixels.
- Visual review confirms that rank progression is readable without numbers and every data/text region remains runtime-controlled.

Runtime slicing, operator/passive insertion, selected/locked/purchased interaction states, English/Thai fitting, controller/keyboard focus treatment and 1280 × 720 validation remain required before promotion to `Integrated`.
