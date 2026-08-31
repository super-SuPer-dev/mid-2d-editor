# Runtime Audio Pilot Record

- Generation source: `tools/generate_audio_assets.py`
- Generation mode: deterministic project-local synthesis; no external samples or voice-over
- Format: mono PCM WAV, 22,050 Hz, 16-bit
- Runtime assets: `cutter_swing.wav`, `player_hurt.wav`, `enemy_hit.wav`, `pickup_sample.wav`, `dash.wav`, `boss_defeat.wav`, `radio_beep.wav`
- Runtime integration: `src/core/managers/audio_manager.gd` exposes `play_named_sfx`; player, enemy, pickup and radio dialogue events use the named streams
- Localization impact: none; audio contains no spoken language or baked text
- Acceptance: files decode in Godot, gameplay events remain non-blocking, muted test mode remains silent, and no stream is loaded from outside `res://`
- Open work: final authored music, expanded SFX coverage, mixing, loudness normalization, platform export review and human audio approval
