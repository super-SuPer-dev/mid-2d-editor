# Eye Wisp Runtime Pilot

**Asset ID:** ENEMY-EYE-WISP  
**State:** Integrated (pilot; human art review pending)  
**Primary fruit identity:** Longan seed  
**Source package:** `art_source/generated/enemies/eye_wisp/`  
**Promotion date:** 2026-08-31

## Promotion contract

- Hover and fly source strips are normalized to exactly 4 × 700 × 800 px cells.
- The source lower visual-extent guide is y = 740; runtime uses a -16 px local
  Y offset and 0.045 scale to keep the flying silhouette stable against the
  collision body while preserving its intentionally airborne read.
- Alpha was quantized with threshold 128. Both promoted pilots contain only
  alpha 0 or 255 and use nearest-neighbor filtering.
- Hover advances at 4.5 fps and fly advances at 7 fps. Aim, seed-bolt, beam,
  hurt and death strips remain source candidates for the next action pass.

## Provenance hashes

| File | SHA-256 |
|---|---|
| `art_source/generated/enemies/eye_wisp/eye_wisp_hover_strip_v1.png` | `9FA4DD65B5EB7178F7C504184C473AE15C15195B87F7571D55108A6FE32AE715` |
| `art_source/generated/enemies/eye_wisp/eye_wisp_fly_strip_v1.png` | `F1FF660C2AFF37F8D800337FAE9C131DB177A92737FA1904B104F4A9EA048678` |
| `assets/enemies/standard/eye_wisp/eye_wisp_hover_strip_normalized_v2.png` | `707B4FBA0F54DCE0DA08A6CFC2A1D40709593A53BE174858FB255AE15152AC42` |
| `assets/enemies/standard/eye_wisp/eye_wisp_fly_strip_normalized_v2.png` | `D6244DA9012BBA2EEB6AA37C3D6602AD0EBDE9E12626A408522F0CF5C56A9DB9` |

## Acceptance status

Technical decode, 4-frame grid, binary-alpha, runtime import, airborne offset
and animation-state checks pass. The package remains below `Verified` until
human review confirms longan identity, hover readability, flight continuity and
projectile-scale contrast in the Level 5 nexus scene.
