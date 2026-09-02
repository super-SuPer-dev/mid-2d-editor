# Level 02 — Mutated Forest World Source Record v1

Generated on 2026-08-29 with OpenAI ImageGen for the English-first bilingual
high-resolution pixel-art campaign. This package is a production source
candidate. Runtime parallax speeds, camera crops, tile slicing, collision masks,
mirrored variants, prop placement, texture budgets, and color grading remain for
integration review.

## Art and level contract

- Original, detailed, non-realistic high-resolution pixel art.
- Dark atmospheric Thai rural science-fantasy with blue-green tropical forest,
  violet shadow, magenta alien spores, and readable cyan/amber ACO technology.
- Young mangosteen is the dominant Level 2 standard-enemy mutation language;
  durian anatomy is reserved for the boss/landmark crown.
- Gameplay silhouettes, collision surfaces, hazards, extraction equipment, and
  pickups must remain distinguishable at 1280 × 720.
- Raster assets contain no baked English or Thai text.

## Accepted sources and hashes

| Asset | ImageGen source ID | Dimensions | SHA-256 |
|---|---|---:|---|
| `parallax/forest_sky_far_v1.png` | `exec-97544c4a-8f1b-4388-a958-2eb016eac484.png` | 1774 × 887 | `a7af3ec285f0be6a8728deed66cac3f2d0c27fb4c99316b2bc72d4af165dfa61` |
| `parallax/forest_tree_line_far_v1.png` | `exec-05e43815-a19c-4b88-9812-7117fc1db9e8.png` | 1983 × 793 | `c9b605d76bc8070e1a985b0cc906609c33fde804c0040f908ab654427f02b7ed` |
| `parallax/forest_canopy_mid_v1.png` | `exec-003f5cd7-de23-4585-83d2-54bc9f04203a.png` | 1983 × 793 | `34e9b98d9c07e4899d8ede70a60c6bc16c8ee59cda3fbbd3f6342c3bb31ac657` |
| `parallax/forest_trunks_near_v1.png` | `exec-b1311ba8-75c0-4fb5-bc15-be35dcfe094e.png` | 1774 × 887 | `15f8d89bcd9e6dcae5aedf97480912f67df9112695b77e6777434100866cabb8` |
| `parallax/forest_foreground_frame_v1.png` | `exec-64c213c4-8060-4772-8935-46f1f0abc0fa.png` | 1672 × 941 | `5b36d38a3c27ed262f0e88a0945fa6a838ea2be3714413815b6bb977915609b7` |
| `tiles/forest_ground_straight_v1.png` | `exec-0f70f8dc-fc24-4589-9ae7-a02faa0db549.png` | 2172 × 724 | `9dd48f8474caf92e7f870e27dd164706ddc23a2e908dc845e1735d36f6e611c7` |
| `tiles/forest_ground_cap_left_v1.png` | `exec-67e2a5a0-dc6b-4248-b495-76f7f9950f06.png` | 1659 × 948 | `5dcab92542e17926d3aad00a8257fa59ec098cf52657b1b6e94545fc39502800` |
| `tiles/forest_platform_floating_v1.png` | `exec-4542212a-135c-44ae-a7ca-380e32988d1e.png` | 1672 × 941 | `6fcdfec37401c433279d78264103131605e1dde39ea22cbd365f35d514356360` |
| `tiles/forest_slope_up_v1.png` | `exec-8cc313d0-be74-4be6-a723-ef94ec5376b9.png` | 1672 × 941 | `248e632b48801d4952304c9978213ebfaa3309ca5a813c499ce66803ad278dd7` |
| `tiles/forest_corner_v1.png` | `exec-592604c2-9ebe-4f95-9073-54f31432847c.png` | 1254 × 1254 | `cf43f8119c93e6791b7de5dd407935b1cd1dbdfd609ec3448fcd135196207ef0` |
| `tiles/forest_ground_broken_v1.png` | `exec-dc7283cd-b680-45af-b200-ff2337670717.png` | 1774 × 887 | `ce4f96b98a4fd139619a94cd619682a9579a404e6377a16977722b5677a0e83d` |
| `tiles/forest_infestation_overlay_v1.png` | `exec-3cab5960-c017-4809-9079-7e7d7ef53cd6.png` | 1983 × 793 | `cb7f362cd518401e7ff48a60576364bed33e750cae0f1113f5fa0632a30233f0` |
| `hazards/mangosteen_spore_vent_v1.png` | `exec-9991f04e-ace2-4ca5-aaec-59df38a638e9.png` | 2172 × 724 | `fc3e1e7464e5cfd5334635c90753d002b8492c9cd434db0968a0b5c47bc056b5` |
| `hazards/mangosteen_spore_vent_normalized_v1.png` | derived from source above | 3200 × 800 | `3b5699e9f46f92f648868b4f6c234a58801dcda65fcce639ac5398ca0dd35ae4` |
| `extraction/forest_extraction_beacon_v1.png` | `exec-dce5ce41-2457-4ca4-8b41-50c445e47989.png` | 1166 × 1349 | `1eecdde71e112c186c8d9f975e03b31b3531a1e24a9de92b6bbdd7d7c9105100` |
| `landmarks/maw_bloom_lair_v1.png` | `exec-f4628f20-dfbf-4aa7-a857-7a443d92c3ac.png` | 1536 × 1024 | `1b045ad45cb352713e305862e60ef12a8f26f081ddd81b9b68dadfbde63adb88` |
| `props/forest_field_shrine_v1.png` | `exec-22e666b5-d463-4117-bf9f-aadc6f4eadbe.png` | 1166 × 1349 | `96ff102dc457b3a2f0d759b06b4dc8161885802634f5d3f261ed24bf0788454b` |

## Prompt-specific direction

### Parallax stack

The opaque far sky establishes teal-indigo storm haze and distant Isan hills.
Four true-alpha layers add distant tree line, mossy mid-canopy, massive near
trunks, and a dark foreground frame. The composed review keeps a central combat
window while preserving visible depth and distinct layer silhouettes.

### Gameplay tile kit

Individual true-alpha cutouts replace a rejected presentation atlas. The source
set supplies repeatable straight ground, left cap, floating platform, clean
up-slope, rotatable corner, broken gap, and collision-free infestation overlay.
Right cap, down-slope, opposite corner, ceiling, and wall orientations may be
derived by deterministic runtime mirroring/rotation only after collision and
lighting review; no bitmap stretching is allowed.

### Hazard, extraction, landmark, and prop

The four-frame young-mangosteen spore vent moves from armored idle through a
magenta tell, acidic spore burst, and recovery. The ACO extraction beacon keeps
an open cyan player window and forest-specific overgrowth. The Maw Bloom Lair
combines a dominant mangosteen maw with a secondary durian crown as a distant
destination landmark. The field shrine is text-free environmental storytelling
and must be placed respectfully without becoming a joke, pickup, or collision
trap.

## Processing and validation

The spore vent was normalized with `tools/normalize_grid_sprite_strip.ps1` using
four frames, `800 × 800` cells, bottom alignment, baseline 740, and alpha
threshold 1. The normalized file is `Format32bppArgb` and all four cell boundary
counts are zero. The four overlay parallax layers and every tile, hazard,
extraction, landmark, and prop candidate contain alpha; the far sky is the only
intentional opaque RGB layer. Visual QA covered an in-memory five-layer composite
and a source contact sheet. Runtime crop, parallax speed, collision seams,
hazard timing, Web texture memory, and 1280 × 720 combat readability remain.

Three full-atlas attempts (`exec-218fba30-3638-46e1-bf4d-dee62a1ee026.png`,
`exec-68628d56-fbc6-48ee-aa82-7f74968f9650.png`, and
`exec-444561d5-cb08-45fd-9e64-a649ed8bbac7.png`) were rejected because they
contained full-canvas presentation backdrops. The hanging calyx snare
`exec-288db948-10ae-4644-a0c7-1ec47a863040.png` was rejected because it baked a
checkerboard and guide boxes instead of true alpha. Rejected sources were not
copied into this package.
