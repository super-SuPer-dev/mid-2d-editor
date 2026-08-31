# Boss HUD Frame Runtime Record

- Asset family: `UI-BOSS-HUD`
- Source package: `art_source/generated/bosses/*/presentation/`
- Runtime state: `Integrated` reusable frame layer for all five boss encounters
- Presentation: text-free 2100–2200 × 800 frames, binary alpha, nearest filtering, aspect-preserving TextureRect
- Localization impact: none in the raster; boss names, phases and health remain runtime English/Thai keys

| Boss ID | Runtime file | Binary-alpha SHA-256 | Runtime hook |
|---|---|---|---|
| `thorn_matriarch` | `thorn_matriarch_boss_hud_frame_v1.png` | `A543A44C1D11B3C84284324398235A9B8468E251C9188B6AC11396F2B7861CA5` | `GameHUD._on_mission_phase_changed()` |
| `maw_bloom_sovereign` | `maw_sovereign_boss_hud_frame_v1.png` | `C5CB8CE11C8A1705B4022648BA59CB97E3DF9BC8C5DFFD91F56930B284FBCFEB` | `GameHUD._on_mission_phase_changed()` |
| `possessed_banyan` | `possessed_banyan_boss_hud_frame_v1.png` | `31F42D5D8D666F69B3BD9D113BAAD1D2F53AC496045912B0006B14831C670551` | `GameHUD._on_mission_phase_changed()` |
| `root_hydra` | `root_hydra_boss_hud_frame_v1.png` | `BF8C9B25A040603220D2B29C7E17A2E4C0C20D4FD0EDC7778BCE2A05EC73C72E` | `GameHUD._on_mission_phase_changed()` |
| `root_core_eye` | `root_core_eye_boss_hud_frame_v1.png` | `32F42A43C152034595D248252D9E54E6854ED0572C10742CA1B465861BC7524C` | `GameHUD._on_mission_phase_changed()` |

The runtime copies are binary-alpha remediations of the generated normalized
sources; source masters remain unchanged for rollback. The HUD panel reserves
an aspect-safe 660 × 220 presentation area and keeps all localized text outside
the raster frame. Human visual composition and final platform memory review
remain open before `Verified`.
