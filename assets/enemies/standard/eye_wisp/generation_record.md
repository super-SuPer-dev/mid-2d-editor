# Eye Wisp Runtime Pilot

**Asset ID:** ENEMY-EYE-WISP  
**State:** Integrated (pilot; human art review pending)  
**Primary fruit identity:** Longan seed  
**Source package:** `art_source/generated/enemies/eye_wisp/`  
**Promotion date:** 2026-08-31

## Promotion contract

- All seven source action strips are normalized to exactly 4 × 700 × 800 px cells.
- The source lower visual-extent guide is y = 740; runtime uses a -16 px local
  Y offset and 0.045 scale to keep the flying silhouette stable against the
  collision body while preserving its intentionally airborne read.
- Alpha was quantized with threshold 128. Promoted strips contain only alpha
  0 or 255 and use nearest-neighbor filtering.
- Hover advances at 4.5 fps, fly at 7 fps, and aim/seed/beam/hurt at 8 fps.
  The controller alternates seed-bolt and beam attacks after the aim tell;
  both actions use the existing enemy projectile contract. Spawned projectiles
  inherit the selected four-frame body strip at nearest filtering and the
  runtime smoke contract checks the fruit-specific visual.

## Provenance hashes

| File | SHA-256 |
|---|---|
| `art_source/generated/enemies/eye_wisp/eye_wisp_hover_strip_v1.png` | `9FA4DD65B5EB7178F7C504184C473AE15C15195B87F7571D55108A6FE32AE715` |
| `art_source/generated/enemies/eye_wisp/eye_wisp_fly_strip_v1.png` | `F1FF660C2AFF37F8D800337FAE9C131DB177A92737FA1904B104F4A9EA048678` |
| `assets/enemies/standard/eye_wisp/eye_wisp_hover_strip_normalized_v2.png` | `707B4FBA0F54DCE0DA08A6CFC2A1D40709593A53BE174858FB255AE15152AC42` |
| `assets/enemies/standard/eye_wisp/eye_wisp_fly_strip_normalized_v2.png` | `D6244DA9012BBA2EEB6AA37C3D6602AD0EBDE9E12626A408522F0CF5C56A9DB9` |
| `assets/enemies/standard/eye_wisp/eye_wisp_aim_tell_strip_normalized_v2.png` | `D9AC4B42B3AAA93094AA2BC75139D0573273CCDA3F86B03068A7047ED5E4EE9E` |
| `assets/enemies/standard/eye_wisp/eye_wisp_seed_bolt_strip_normalized_v2.png` | `64E71F0575756B14981C022C6319C1F23C7279FC5E4CDFAED2ED01BFB2E87FED` |
| `assets/enemies/standard/eye_wisp/eye_wisp_beam_attack_strip_normalized_v2.png` | `905DD1438783D932035D7D14E85C0675A273D40D1EEFECC06D2908F5EFA07E8B` |
| `assets/enemies/standard/eye_wisp/eye_wisp_hurt_strip_normalized_v2.png` | `8927BA068657BF5734D39A3F4591D69B9B0D8BEBF29FD5E2AD7CCFA88D282D8E` |
| `assets/enemies/standard/eye_wisp/eye_wisp_death_strip_normalized_v2.png` | `46768AAB0AD8D3DB4148AA11FD4546A8446152B6745B49907808E2ECEFC78DC1` |

## Acceptance status

Technical decode, 4-frame grid, binary-alpha, runtime import, airborne offset,
animation-state and projectile-handoff checks pass. The package remains below
`Verified` until human review confirms longan identity, hover readability,
attack readability, projectile-scale contrast and death presentation in the
Level 5 nexus scene.
