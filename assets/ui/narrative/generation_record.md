# Narrative Frame Runtime Record

- Asset families: `UI-DIALOGUE-FRAME`, `UI-RADIO-OVERLAY`
- Source package: `art_source/generated/ui/narrative/`
- Runtime state: `Integrated` pilot as full and radio dialogue panel skins
- Presentation: text-free binary-alpha pixel-art frames, nearest filtering,
  StyleBoxTexture nine-patch margins, no baked language

| Frame | Runtime file | Binary-alpha SHA-256 | Runtime hook |
|---|---|---|---|
| Dialogue | `dialogue_frame_normalized_v1.png` | `AC1CD4F25AD9D125A95CC019A0DA86D3FE639107F755AD8AD0E0ECAC5147268A` | `DialogueOverlay` full mode |
| Radio | `radio_overlay_frame_normalized_v1.png` | `77137D36A9A117B59E909E6BE9D84F120712B2837CDFA5F4DA7EA5973D9E1A8A` | `DialogueOverlay` radio mode |
| Briefing | `briefing_panel_normalized_v1.png` | `BB7C345FCD1186915687057B6E81CF65B0A68EBC8796E187A3B64C2CFDE1CD42` | `DialogueOverlay` briefing mode |
| Debrief | `debrief_panel_normalized_v1.png` | `08C89374A837B6FACFAF315A1C08A09DD8A50547C0300BF4A452D21F3E70D816` | `DialogueOverlay` debrief mode |

Generated sources remain unchanged in `art_source/` for rollback. Full-screen
mission layout and final human presentation review remain open.
