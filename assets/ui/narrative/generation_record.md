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

Generated sources remain unchanged in `art_source/` for rollback. Briefing and
debrief full-screen shells remain in Review for a later presentation slice.
