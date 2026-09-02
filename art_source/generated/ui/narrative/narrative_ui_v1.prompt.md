# Narrative UI Shell Source Record — v1

- Asset families: `UI-DIALOGUE-FRAME`, `UI-RADIO-OVERLAY`, `UI-BRIEFING-PANEL`, `UI-DEBRIEF-PANEL`
- State: `Review` source package; not yet integrated as final runtime skins
- Art direction: detailed high-resolution pixel art, dark charcoal/olive ACO field-journal interface, aged-brass hardware, true transparent background
- Localization contract: all panels are text-free and reserve runtime-controlled name, body, objective, stat and action regions for English and Thai

## Deliverables

| Asset | Source | Normalized canvas |
|---|---|---|
| Reusable dialogue frame | `dialogue_frame_v1.png` | `dialogue_frame_normalized_v1.png`, 2300 × 800 px |
| Compact radio overlay frame | `radio_overlay_frame_v1.png` | `radio_overlay_frame_normalized_v1.png`, 2300 × 800 px |
| Mission briefing shell | `briefing_panel_v1.png` | `briefing_panel_normalized_v1.png`, 1800 × 1000 px |
| Mission debrief/results shell | `debrief_panel_v1.png` | `debrief_panel_normalized_v1.png`, 1800 × 1000 px |

## Built-in ImageGen provenance

| Asset | Accepted generated source ID | Normalized SHA-256 |
|---|---|---|
| Dialogue frame | `exec-ea2e033e-d091-489a-8b1c-707a2ffc781f.png` | `E23907AA80D2B1A2253372D604B0A0BF68A1CFBC4F46B52F09318A855C501EC0` |
| Radio overlay | `exec-52817f1f-003f-4eb8-9e8a-4ac7a0fae0d7.png` | `760B3122DD20A28FC35D22E72E682BB272564EF0561B0F23ED96DB6D36BFD9A3` |
| Briefing panel | `exec-dc0f2f31-9e4f-4e5a-a12a-ace4136c3fdd.png` | `2880D89D1D371B5ED5176E2946E0B8AD39E67CB9F45C93FED7A510E1B67E1B31` |
| Debrief panel | `exec-dcee5ada-efa1-4ad6-b223-f758bff007ef.png` | `2FE03B21040423926ADF488459BF3041499E99507411F47C8B8E070665D0B3CD` |

## Final prompt summaries

- Dialogue: wide portrait socket, speaker-name plate, multiline message region and two language-independent control sockets.
- Radio: compact top-right-safe portrait, name and short message regions with a small signal-strength indicator and no blocking controls.
- Briefing: 16:9 tactical viewport, objective/threat/environment stack, portrait socket and bottom dialogue/action strip.
- Debrief: 16:9 result rows, reward/sample module, completion badge socket, portrait/dialogue column and action sockets.
- Shared prompt: square corners, aged-brass borders, olive accents, worn military texture, no baked language, transparent outside the interface silhouette.
- The first debrief draft used a visible checkerboard outside the frame; the accepted source is the targeted background-extraction revision with genuine alpha.

## Technical validation

- All normalized PNGs report `Format32bppArgb`.
- Every normalized canvas corner has zero alpha and every outer edge has zero nontransparent pixels.
- Visual review confirms distinct compact, dialogue, briefing and results hierarchies with usable portrait and text-safe regions.
- No source contains baked English or Thai copy; small arrow and signal symbols are language-independent controls/status indicators.

Runtime nine-patch or sliced-panel preparation, portrait insertion, English/Thai typography fitting, control-state variants, 1280 × 720 layout validation and Web memory checks remain required before promotion to `Integrated`.
