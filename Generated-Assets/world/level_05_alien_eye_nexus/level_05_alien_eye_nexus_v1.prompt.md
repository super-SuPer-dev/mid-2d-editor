# Level 05 — Alien Eye Nexus World Source Record v1

Generated on 2026-08-29 with OpenAI ImageGen for the English-first bilingual
high-resolution pixel-art campaign. This package is a production source
candidate. Runtime parallax speeds, crops, tile slicing, collision masks,
mirrored variants, placement, texture budgets, and color grading remain for
integration review.

## Art and narrative contract

- Original, detailed, non-realistic high-resolution pixel art.
- Longan flesh and black seeds form the sensory-eye language; dragon-fruit
  bracts form the final biome and boss crown. Neural roots are secondary tissue.
- The biome escalates into impossible organic depth while preserving a clean
  combat corridor for the campaign's densest projectile patterns.
- The landmark is the awakened network's sensory organ, not a duplicate boss
  sprite or a generic mechanical portal.
- Raster assets contain no baked English or Thai text.

## Accepted sources and hashes

| Asset | ImageGen source ID | Dimensions | SHA-256 |
|---|---|---:|---|
| `parallax/nexus_impossible_depth_far_v1.png` | `exec-f1641c50-913f-4029-98fa-a32a6b64de58.png` | 1536 × 1024 | `01be0ba0e2564f928109cc372829e096a6c81d087f1ccc0b59459f311db5b313` |
| `parallax/nexus_neural_lattice_far_v1.png` | `exec-7f39e770-9966-4b23-b4c0-22d7925aee0a.png` | 2172 × 724 | `ffb5dd6df202ffa2dca9f0df3e73323c323ba00156154a85c5106384003ce8cb` |
| `parallax/nexus_longan_eye_network_mid_v1.png` | `exec-1805a8bf-3ec2-4964-b650-0578b1c36383.png` | 1672 × 941 | `0fd927800917336e89ec5f347f5931df5be3680c043a985ed669962ac34248c9` |
| `parallax/nexus_dragon_bracts_near_v1.png` | `exec-934f6386-3030-4e13-bc11-049c40f2b664.png` | 1672 × 941 | `f07579aadcf3df33435d3ffd9b0077d12880e0ed81d156ac884f8e49573a584d` |
| `parallax/nexus_foreground_frame_v1.png` | `exec-803ba496-5fa8-472d-80fd-e9cecf48ffb6.png` | 1672 × 941 | `e4fc0662968c40ebedd5f7ba06ba515c5a3ec21259cd6adb0a2d869c498ddef5` |
| `tiles/nexus_ground_straight_v1.png` | `exec-958e5455-f4cc-4ae5-97c9-2cbd623daf6c.png` | 2172 × 724 | `bbe21c7dba55fa7c02de917fb7d3e95c55885926678dc231f452ac758d309ce9` |
| `tiles/nexus_ground_cap_left_v1.png` | `exec-2d26bc0f-26bb-458f-bac2-ca48ae30a509.png` | 1536 × 1024 | `9dd3fb064566496e98d9ca4effb559514cec2fc38bd400ca565ee5be6e1a62c5` |
| `tiles/nexus_platform_floating_v1.png` | `exec-0aac21dd-6d24-4be3-942d-34f239ec7f47.png` | 1536 × 1024 | `388d6ee71d0e96f424fc226e87caef4a40ecac3745af526406b3df4128afe43b` |
| `tiles/nexus_slope_up_v1.png` | `exec-d853c56e-a133-4c02-b7a9-af174bb43f37.png` | 1536 × 1024 | `c31e30077e111799eb20b5377b08b72d0bd6f08b87de7994d958f2544c2b3b47` |
| `tiles/nexus_corner_v1.png` | `exec-619b9d20-7fb0-40de-8292-c84d1846d516.png` | 1305 × 1205 | `7575e629fec40caab6f3b1eaa0c4a6756454619019aec3787d136e6417decb60` |
| `tiles/nexus_ground_broken_v1.png` | `exec-e87df2c9-605e-4fba-935f-2c58870138c0.png` | 1774 × 887 | `76ac0aecc0af4b6c7cb518c14915ce01855db6824a1f8872c098c90af72b4074` |
| `tiles/nexus_neural_infestation_overlay_v1.png` | `exec-b5740b64-9a7e-43e3-992f-bcc6da122f93.png` | 1536 × 1024 | `628c7857eec05044873c5a35a81519141a40ce0292b721c5b012660ae898bfa9` |
| `hazards/sensory_platform_collapse_v1.png` | `exec-b31838fd-0ed6-4432-96db-7c2728d74cb5.png` | 2172 × 724 | `a782d071decf07a5907ca1cc3594e0e53d9a21169de0849dca9b915a90375471` |
| `hazards/sensory_platform_collapse_normalized_v1.png` | derived from source above | 3200 × 800 | `bfbe6466574a141cdff8c6026b438a90fd236c07f358955eaad9af840d31d4e1` |
| `extraction/nexus_extraction_beacon_v1.png` | `exec-b28b687f-3319-4d3d-951c-9491c222e61b.png` | 1536 × 1024 | `608a18f32c3f62c4ab464b6c285cdcdc80160e64363b87972c85d43bc37b001d` |
| `landmarks/awakened_sensory_nexus_v1.png` | `exec-710f30ff-a743-425e-a923-966e90e2d4c0.png` | 1536 × 1024 | `198c4944d114b0a29d53e929156d76d0842ece839ae2c82abfbd49e0283b1780` |

## Prompt-specific direction

### Parallax stack

The opaque far layer establishes concentric organic depth. Four alpha layers add
a distant neural lattice, longan eye networks, near dragon-fruit bract columns,
and a dark membrane foreground. The stack keeps the central projectile-read
corridor open despite the final biome's visual intensity.

### Gameplay tile kit

Individual cutouts provide straight membrane ground, left cap, floating eye
platform, clean up-slope, rotatable corner, broken/collapsing ground, and a
collision-free longan/dragon-fruit neural overlay. Right cap, down-slope,
opposite corner, ceiling, and wall variants may use deterministic runtime
mirroring or rotation after collision and lighting review; stretching is banned.

### Hazard, extraction, and landmark

The four-frame sensory platform moves through stable closed eye, cyan warning,
hostile open eye, and membrane collapse. The final ACO beacon is mechanically
clamped into the network. The Awakened Sensory Nexus presents the longan pupil,
dragon-fruit iris crown, biomass arteries, and a traversable lower passage.

## Processing and validation

The platform strip was normalized with `tools/Normalize-GridSpriteStrip.ps1`
using four frames, `800 × 800` cells, bottom alignment, baseline 740, and alpha
threshold 1. The normalized file is `Format32bppArgb`; all three internal cell
boundary counts are zero. Every parallax overlay, tile, hazard, extraction prop,
and landmark contains true alpha; the impossible-depth background is the only
intentional opaque RGB layer. Visual QA covered the five depth layers and a full
source contact sheet. Runtime crop, parallax speed, collision seams, hazard
timing, projectile readability, Web texture memory, landmark placement, and
1280 × 720 combat validation remain.
