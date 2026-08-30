# Asset Register

**Project:** Low Attitude Warrior
**Version:** 2.0  
**Status:** Living production inventory  
**Authority:** This English register is maintained. Existing Thai documents are frozen references.

This register records the assets required to ship the five-level campaign. Paths beginning with `art_source/generated/` are source candidates only. They are not production-approved until validated, reviewed, moved into `assets/`, integrated and evidenced.

## 1. State and Priority Rules

[ASSET-STATE-01]

`Missing → Placeholder → Review → Integrated → Verified → Release-ready`

| State | Meaning |
|---|---|
| Missing | Required asset does not exist |
| Placeholder | Temporary runtime representation exists |
| Review | Candidate source exists but needs technical and/or visual approval |
| Integrated | Production candidate is referenced correctly at runtime |
| Verified | Acceptance checks pass on Windows and Web |
| Release-ready | Final quality, provenance, localization and release checks are signed off |

Priorities: **P0** blocks the core campaign or legal release; **P1** is required for intended launch quality; **P2** is polish that may be deferred only through explicit scope review.

Every production entry must ultimately record source/runtime paths, dimensions, format, dependencies, author/source/license, acceptance criteria, evidence, localization impact and current state. Unknown provenance prevents Release-ready status.

The campaign-wide visual source reference `ARTREF-CAMPAIGN-ANCHOR` is in Review
at `art_source/references/generated_campaign_style_anchor.png`. It establishes five-biome
palette, depth, landmark, tile-silhouette and alien-organic language only; it is
not a runtime asset. Its generation record is stored beside the image.

## 2. Technical Acceptance Rules

[ASSET-TECH-01]

- Runtime UI images contain no baked English or Thai text.
- Raster assets use true alpha with no white/colored matte, edge halo or neighboring-frame contamination.
- Sprite sheets declare exact cell size, columns, rows, gutters, animation mapping, pivot and baseline.
- Character motion is tested with a fixed world-space foot baseline; no unintended floating or camera-scaled blur.
- Pixel art declares a logical pixel canvas, uses hard cluster edges and limited color ramps, and is displayed with integer nearest-neighbor scaling where practical.
- Photorealistic, painterly, airbrushed, vector-smooth, and 3D/PBR-looking raster assets are rejected even when their output dimensions are high.
- Filtering/import settings preserve crisp pixel clusters and remain consistent across Windows/Web; sprites may not inherit bilinear filtering from UI or backgrounds.
- Large images are cropped/atlased to control texture memory; transparent empty area is not treated as free.
- Canonical file and asset IDs use lowercase filesystem-safe names; localized display names do not change IDs.
- Source files remain editable; flattened runtime exports do not replace masters.
- VFX and telegraphs must be readable against every intended biome and for common color-vision deficiencies.

### Generated-source audit snapshot

[ASSET-AUDIT-01] The 2026-08-30 audit found 474/474 decodable PNG candidates, but all 188 `_normalized_` files contain substantial semi-transparent alpha. File integrity passes; hard-edge pixel-art approval, package-level grid validation, runtime filtering, platform memory, and human visual approval remain blocked or pending. `true alpha` records transparency presence only and must not be read as clean-edge approval. No generated candidate advances beyond `Review` from this audit. See [Generated Asset Audit](GENERATED_ASSET_AUDIT.md).

## 3. Character and Narrative Assets

[ASSET-CHAR-01]

| Asset ID | English / Thai display | Priority | Source / runtime | Acceptance summary | Localization | State |
|---|---|---:|---|---|---|---|
| CHAR-TONKLA-SHEET | Tonkla / ต้นกล้า | P0 | `art_source/generated/character/` / current character runtime | Idle, run, jump, fall, attack, dash, hurt, death; clean alpha, stable feet/pivot | Name/description only | Review |
| CHAR-RIN-SHEET | Rin / ริน | P0 | `art_source/generated/character/` / current character runtime | Same shared animation contract; visually distinct silhouette | Name/description only | Review |
| CHAR-KHEM-SHEET | Khem / เข้ม | P0 | `art_source/generated/character/` / current character runtime | Same shared animation contract; attack reach remains data-driven | Name/description only | Review |
| CHAR-T800-SHEET | T-800 / T-800 | P0 | `art_source/generated/character/` / current character runtime | Same shared animation contract; mechanical damage readability | Name/description only | Review |
| ICON-PASSIVE-TONKLA | Field Recovery / ฟื้นฟูภาคสนาม | P1 | `art_source/generated/ui/operator_passives/passive_tonkla_field_recovery_normalized_v1.png` / `assets/UI/icons/` | Text-free true-alpha source is readable at 64 px; runtime import and mastery-state framing remain | Tooltip keys | Review |
| ICON-PASSIVE-RIN | Rapid Evade / หลบฉับไว | P1 | `art_source/generated/ui/operator_passives/passive_rin_rapid_evade_normalized_v1.png` / `assets/UI/icons/` | Dash/cooldown read is distinct at 64 px; runtime import and mastery-state framing remain | Tooltip keys | Review |
| ICON-PASSIVE-KHEM | Wide Cut / คมกว้าง | P1 | `art_source/generated/ui/operator_passives/passive_khem_wide_cut_normalized_v1.png` / `assets/UI/icons/` | Cutter-area read is distinct at 64 px; runtime import and mastery-state framing remain | Tooltip keys | Review |
| ICON-PASSIVE-T800 | Reinforced Chassis / โครงเสริมเกราะ | P1 | `art_source/generated/ui/operator_passives/passive_t800_reinforced_chassis_normalized_v1.png` / `assets/UI/icons/` | Mitigation/armor read is distinct at 64 px; runtime import and mastery-state framing remain | Tooltip keys | Review |
| PORTRAIT-OP-TONKLA | Tonkla Portrait / ภาพต้นกล้า | P1 | `art_source/generated/portraits/operators/operator_tonkla_portrait_states_normalized_v1.png` / `assets/portraits/operators/` | Neutral + determined true-alpha states in clean 2 × 900 px cells; runtime integration remains | Speaker/display keys | Review |
| PORTRAIT-OP-RIN | Rin Portrait / ภาพริน | P1 | `art_source/generated/portraits/operators/operator_rin_portrait_states_normalized_v1.png` / `assets/portraits/operators/` | Neutral + determined true-alpha states in clean 2 × 900 px cells; runtime integration remains | Speaker/display keys | Review |
| PORTRAIT-OP-KHEM | Khem Portrait / ภาพเข้ม | P1 | `art_source/generated/portraits/operators/operator_khem_portrait_states_normalized_v1.png` / `assets/portraits/operators/` | Neutral + determined true-alpha states in clean 2 × 900 px cells; runtime integration remains | Speaker/display keys | Review |
| PORTRAIT-OP-T800 | T-800 Portrait / ภาพ T-800 | P1 | `art_source/generated/portraits/operators/operator_t800_portrait_states_normalized_v1.png` / `assets/portraits/operators/` | Neutral + alert true-alpha states in clean 2 × 900 px cells; runtime integration remains | Speaker/display keys | Review |
| PORTRAIT-NPC-ANAN | Commander Anan / ผู้การอนันต์ | P0 | `art_source/generated/portraits/npcs/commander_anan_portrait_states_normalized_v1.png` / current neutral anchor | Neutral, urgent and relieved true-alpha source states are complete in clean 3 × 900 px cells; full runtime integration remains | Speaker name key | Review |
| PORTRAIT-NPC-MALI | Dr. Mali / ดร.มะลิ | P0 | `art_source/generated/portraits/npcs/dr_mali_portrait_states_normalized_v1.png` / current analytical anchor | Analytical, alarmed and hopeful true-alpha source states are complete in clean 3 × 900 px cells; full runtime integration remains | Speaker name key | Review |
| PORTRAIT-NPC-CHAI | Technician Chai / ช่างชัย | P0 | `art_source/generated/portraits/npcs/technician_chai_portrait_states_normalized_v1.png` / current neutral anchor | Neutral, amused and concerned true-alpha source states are complete in clean 3 × 900 px cells; full runtime integration remains | Speaker name key | Review |

## 4. Standard Enemy Assets

[ASSET-ENEMY-01]

| Asset ID | Family | Fruit identity | Priority | Runtime/source status | Required set | State |
|---|---|---|---:|---|---|---|
| ENEMY-THORNLING | Thornling | Rambutan / เงาะ | P0 | Detailed true-alpha six-action body plus a detached four-frame rambutan contact-hit VFX source are in Review at `art_source/generated/enemies/thornling/`; body strips use 700 x 800 cells/baseline 740 and VFX uses clean 700 x 700 cells with hashes/provenance; old static idle remains integrated while runtime retrofit and gameplay validation remain | Idle/run, attack tell, attack, hurt, death, contact-hit VFX | Review |
| ENEMY-SPITTER | Spitter | Makrut lime / มะกรูด | P0 | Detailed true-alpha seven-action body plus four detached makrut seed/glob/impact VFX strips are in Review at `art_source/generated/enemies/spitter/`; body uses 700 x 800 cells/baseline 740, while VFX uses clean 700/800 px square cells with distinct silhouettes, hashes and provenance; old static idle remains integrated while runtime retrofit and gameplay validation remain | Idle/walk, pressure tell, seed burst, juice lob, hurt, death, seed/glob/impact VFX | Review |
| ENEMY-MAW | Maw | Young mangosteen / มังคุดอ่อน | P0 | Detailed true-alpha six-action source set at `art_source/generated/enemies/maw/`; normalized 4 x 1 strips use 700 x 800 cells and baseline 740; fruit-read review and runtime integration remain | Idle/move, bite, hurt, death, anticipation/recovery | Review |
| ENEMY-ROOT-SKITTER | Root Skitter | Salak / สละ | P1 | Seven-action source set at `art_source/generated/enemies/root_skitter/` is promoted to a quantized runtime pilot at `assets/enemies/standard/root_skitter/`; idle/scuttle use 4 × 700 × 800 cells, 740 px baseline, binary alpha and nearest filtering. Remaining action binding and human silhouette/motion review are open; see the English provenance record in the runtime folder. | Idle/scuttle pilot, burrow tell, burrow, emerge attack, hurt, death | Integrated |
| ENEMY-EYE-WISP | Eye Wisp | Longan / ลำไย | P1 | Detailed true-alpha seven-action body plus four detached longan seed-bolt/impact/beam VFX strips are in Review at `art_source/generated/enemies/eye_wisp/`; body uses 700 x 800 cells/lower visual guide 740, while VFX uses clean 700 x 700 cells with stable silhouettes, hashes and provenance; runtime integration and gameplay validation remain | Hover/fly, aim tell, seed-bolt attack, beam attack, hurt, death | Review |
| ENEMY-CAPSULE-HUSK | Capsule Husk | Santol / กระท้อน | P0 | Detailed true-alpha seven-action source set at `art_source/generated/enemies/capsule_husk/`; normalized 4 x 1 strips use 700 x 800 cells and baseline 740; runtime integration remains | Idle/move, armored charge, exposed-core attack, hurt, death, shell-break tell | Review |

Production sets must expose consistent damage/hurt timing while preserving distinct silhouettes and attack tells. Color swaps alone do not count as separate families.

Before an enemy or boss advances from `Missing`/`Placeholder` to `Review`, its
source package must include a fruit identity sheet naming the primary Thai
fruit, at least three mapped structures, the gameplay-bearing structure, and a
grayscale silhouette check. Missing fruit evidence blocks art-state promotion.
The sheet also records `fruit_identity_id`, English/Thai common names,
local-growth or cultural-reference notes, dominant gameplay-scale read, and any
secondary fruit used by a boss. Roots, vines, fungi, and alien tissue are
supporting biology and cannot substitute for the primary fruit identity.

## 5. Boss Assets

[ASSET-BOSS-01]

| Asset ID | Level | Fruit identity | Priority | Required production package | State |
|---|---:|---|---:|---|---|
| BOSS-THORN-MATRIARCH | 1 | Rambutan queen cluster | P0 | Detailed true-alpha nine-action body, rolling mine/burst, spinning hair-thorn/impact, telegraphed lane hazard, three-state portrait, intro/HUD frames and phase markers are in Review at `art_source/generated/bosses/thorn_matriarch/`; runtime integration, remaining final VFX/SFX and gameplay validation remain | Review |
| BOSS-MAW-SOVEREIGN | 2 | Durian crown + mangosteen anatomy | P0 | Detailed true-alpha twelve-action body, five detached projectile/hazard sets, three-state portrait strip, intro/HUD frames and phase markers are in Review at `art_source/generated/bosses/maw_sovereign/`; fruit identity sheet, normalized grids, hashes and provenance are recorded; runtime integration, final VFX/SFX and gameplay validation remain | Review |
| BOSS-POSSESSED-BANYAN | 3 | Jackfruit + banyan fig | P0 | Detailed true-alpha thirteen-action body, six detached projectile/hazard/death-VFX sets, and a text-free presentation package are in Review at `art_source/generated/bosses/possessed_banyan/`; the presentation adds three portrait states, intro frame, compact HUD frame and three phase markers with validated alpha openings; identity sheets, normalized grids, hashes and provenance are recorded; runtime integration, final VFX/SFX and gameplay validation remain | Review |
| BOSS-ROOT-HYDRA | 4 | Nipa-palm fruit cluster | P0 | Complete fruit-identity, eleven-action/44-frame true-alpha body, seven detached projectile/telegraph/impact sets and text-free presentation package are in Review at `art_source/generated/bosses/root_hydra/`; portraits, intro/HUD frames and phase markers complete the four-origin Touhou-style source contract; runtime integration, final VFX/SFX and gameplay validation remain | Review |
| BOSS-ROOT-CORE-EYE | 5 | Longan eye cluster + dragon-fruit bracts | P0 | Complete fruit-identity, thirteen-action/52-frame true-alpha body contract, seven detached projectile/telegraph/impact strips and text-free presentation package are in Review at `art_source/generated/bosses/root_core_eye/`; portraits, intro/HUD frames and phase markers complete the five-origin plus central-pupil final-boss source contract with normalized grids, hashes and provenance; runtime integration, final VFX/SFX and gameplay validation remain | Review |

Each boss package includes phase-readable silhouettes, pre-damage telegraphs, hit/death feedback, boss-introduction presentation, health-bar elements, projectiles/hazards and source masters. Boss mechanics remain functional if presentation assets fail to load.

Projectile production sets require high-contrast shape coding, spawn and impact tells, editable masters, pooling-friendly atlases and named variants that map one-to-one to canonical boss `pattern_id` values. Level-specific sets may share technical shaders or particles, but not the same primary projectile silhouette and palette without a readability review.

## 6. World and Gameplay Assets

[ASSET-WORLD-01]

| Asset ID | Use | Priority | Current condition | State |
|---|---|---:|---|---|
| WORLD-PLATFORM-SET | Traversal surfaces | P0 | Level 1 pixel-art repeat tile integrated without bitmap stretching; biome variants remain | Integrated |
| WORLD-HAZARD-SET | Thorns, spores, roots, marsh, nexus hazards | P0 | Level 1 pixel-art thorn bed integrated with approved baseline/collision; biome variants and animation remain | Integrated |
| WORLD-SAMPLE | Living sample pickup | P0 | Pixel-art ACO sample canister integrated; hard edge approved at runtime scale | Integrated |
| WORLD-PROJECTILE-SET | Enemy/boss ranged attacks | P0 | Pixel-art Spitter projectile integrated with direction-aligned rotation; boss variants remain | Integrated |
| WORLD-EXTRACTION-PORTAL | Mission extraction | P0 | Pixel-art ACO extraction beacon integrated with localized world-space label; biome treatment/activation VFX remain | Integrated |
| WORLD-L1-GRASSLAND | Contaminated Grassland environment | P0 | Generated/current background candidates | Review |
| WORLD-L2-FOREST | Mutated Forest environment | P0 | A detailed high-resolution pixel-art source package is in Review at `art_source/generated/world/level_02_mutated_forest/`: five-layer parallax stack, seven-piece modular tile source set with mirrored/rotated derivatives specified, animated mangosteen spore vent, biome extraction beacon, Maw Bloom landmark and field-shrine prop; alpha/hash/provenance evidence is recorded, while runtime slicing, collisions, placement, memory and 1280 × 720 gameplay validation remain | Review |
| WORLD-L3-CAPSULE | Capsule 07 impact/root chamber | P0 | A detailed high-resolution pixel-art source package is in Review at `art_source/generated/world/level_03_capsule_07/`: five-layer cavern/shell parallax stack, seven-piece modular capsule-root tile source set with mirrored/rotated derivatives specified, animated santol seed-piston hazard, root-chamber extraction beacon and Capsule 07 seed-harvester landmark; alpha/hash/provenance evidence is recorded, while runtime slicing, collisions, placement, memory and 1280 × 720 gameplay validation remain | Review |
| WORLD-L4-MARSH | Devouring Root Marsh environment | P0 | A v2 candidate package is in Review at `art_source/generated/world/level_04_root_marsh/`: five marsh/nipa/conduit layers, seven modular root-mat sources, four-frame nutrient-root eruption, extraction beacon and conduit landmark; its records claim square pixels, stepped edges, limited ramps, gutters, hashes and rejection of painted v1, but the global audit found soft alpha and independent pixel-art approval is blocked; runtime slicing, collision, filtering, placement, memory and 1280 × 720 validation remain | Review |
| WORLD-L5-NEXUS | Alien Eye Nexus environment | P0 | A v2 candidate package is in Review at `art_source/generated/world/level_05_alien_eye_nexus/`: five-layer impossible-depth/longan-eye/dragon-bract stack, seven modular membrane/neural-root sources, animated four-frame sensory platform, extraction beacon and nexus landmark; its records claim square-pixel construction, stepped edges, limited ramps, gutters, hashes and rejection of painted v1, but the global audit found soft alpha and independent pixel-art approval is blocked; runtime slicing, collisions, filtering, placement, projectile readability, memory and 1280 × 720 validation remain | Review |
| LANDMARK-CAPSULE-07 | Capsule shell and subterranean seed | P0 | Detailed true-alpha Capsule 07 seed-harvester landmark source is in Review at `art_source/generated/world/level_03_capsule_07/landmarks/capsule_07_seed_harvester_v1.png`; it exposes the santol-like germination core, shell/scaffold silhouette and downward harvester roots without baked text, while runtime scale, placement, occlusion and midpoint reveal validation remain | Review |
| LANDMARK-ROOT-CONDUIT | Marsh nutrient conduit | P1 | Pixel-art source candidate `art_source/generated/world/level_04_root_marsh/landmarks/root_nutrient_conduit_v2.png` documents irrigation-gate scale, lower passage, salak/nipa context, hash and v1 rejection; hard-edge approval, runtime placement, collision/readability and performance validation remain | Review |
| LANDMARK-ALIEN-EYE | Awakened sensory nexus | P0 | Pixel-art source candidate `art_source/generated/world/level_05_alien_eye_nexus/landmarks/awakened_sensory_nexus_v2.png` documents longan seed-eye, dragon-fruit bract iris, biomass arteries, lower passage, hash and v1 rejection; hard-edge approval, runtime scale, placement, occlusion, projectile readability and performance validation remain | Review |

Each biome needs at least four parallax layers, gameplay ground/platforms, foreground framing, hazards, extraction treatment and a landmark without obscuring routes, enemies, objectives or the level-selection icon. Its primary tile kit includes straight runs, caps, inner/outer corners, slopes or equivalent traversal transitions, damaged/infested variants and collision-safe decorative overlays. A palette swap of another biome's primary tiles is not a complete world set.

## 7. UI and VFX Assets

[ASSET-UI-01]

| Asset ID | Use | Priority | Current condition | State |
|---|---|---:|---|---|
| UI-MENU-ATLAS | Menu/button/panel art | P0 | Generated atlas integrated provisionally | Review |
| UI-LEVEL-MAP | Five-level selection map | P0 | Generated map/atlas integrated; icons repositioned | Review |
| UI-HUD-ICON-ATLAS | Health, sample, objective and ability icons | P0 | Generated atlas integrated provisionally | Review |
| UI-DIALOGUE-FRAME | Briefing/debrief dialogue | P0 | Text-free true-alpha source and clean 2300 × 800 px normalized frame are in Review at `art_source/generated/ui/narrative/`; runtime slicing, portraits and bilingual fitting remain | Review |
| UI-RADIO-OVERLAY | Compact non-pausing radio | P0 | Native compact top-right mode is integrated below HUD/boss safe areas; a final text-free true-alpha pixel-art frame is in Review at `art_source/generated/ui/narrative/`; runtime skin replacement and bilingual fitting remain | Review |
| UI-BRIEFING-PANEL | Mission briefing presentation | P0 | Text-free true-alpha 1800 × 1000 px tactical briefing shell is in Review at `art_source/generated/ui/narrative/`; runtime composition and bilingual fitting remain | Review |
| UI-DEBRIEF-PANEL | Mission results/story presentation | P0 | Text-free true-alpha 1800 × 1000 px results/debrief shell is in Review at `art_source/generated/ui/narrative/`; runtime composition and bilingual fitting remain | Review |
| UI-BOSS-HUD | Boss name, phase and health | P0 | Text-free frames, portrait states and phase markers for all five bosses are in Review under their `art_source/generated/bosses/*/presentation/` packages; reusable runtime component, localization fitting and gameplay-scale validation remain | Review |
| UI-BOSS-INTRO | Boss introduction treatment | P1 | Text-free intro frames and portrait states for all five bosses are in Review under their presentation packages; reusable localized presentation, timing and 1280 x 720 validation remain | Review |
| UI-MASTERY | Operator mastery screen/components | P0 | Text-free true-alpha 1800 × 1000 px screen shell plus six clean 750 px rank-node states are in Review at `art_source/generated/ui/mastery/`; runtime data binding, interaction states and bilingual fitting remain | Review |
| VFX-CUTTER-SET | Swing, contact, charged/upgrade feedback | P0 | Four detached true-alpha four-frame strips for standard swing, organic contact, charged swing and upgrade activation are in Review at `art_source/generated/vfx/cutter/`; runtime still uses the old/provisional effect until timing and collision integration | Review |
| VFX-DAMAGE-SET | Player/enemy/boss hit and status feedback | P0 | Five detached true-alpha four-frame strips for player, organic, armored and final-boss-core hits plus a looping root-contamination status are in Review at `art_source/generated/vfx/damage/`; all use clean 800 px cells with hashes/provenance, while runtime event binding, scale, timing, blend mode and gameplay validation remain | Review |

UI source masters must support 1280×720, safe areas, keyboard focus, English expansion, Thai line breaking and pseudo-localization. Nine-slice or layout-native panels are preferred over stretched raster panels.

## 8. Audio Assets

[ASSET-AUDIO-01]

| Asset ID | Deliverable | Priority | Target | State |
|---|---|---:|---|---|
| AUDIO-UI-CLICK | UI confirmation/click | P0 | Current `click.wav`; verify license and final mix | Integrated |
| MUSIC-MENU-BASE | Menu/base loop | P1 | 1 seamless loop | Missing |
| MUSIC-LEVEL-01..05 | Biome music | P1 | 5 seamless level loops | Missing |
| MUSIC-BOSS-A | Organic boss suite | P1 | Reusable intro/loop/outro | Missing |
| MUSIC-BOSS-B | Nexus/final boss suite | P1 | Reusable intro/loop/outro | Missing |
| MUSIC-STINGERS | Victory and defeat | P1 | 2 short stingers | Missing |
| SFX-OPERATOR-SET | Movement, dash, hurt, death | P0 | Approximately 10 events | Missing |
| SFX-CUTTER-SET | Start, loop/swing, impact, upgrade variants | P0 | Approximately 8 events | Missing |
| SFX-ENEMY-BOSS-SET | Tells, attacks, hurt, death, phases | P0 | Approximately 14 events | Missing |
| SFX-WORLD-RADIO-UI | Pickups, portal, hazards, radio and UI | P0 | Approximately 8 events | Missing |

There are no voice-over assets. Dialogue readability must not depend on voice. Loops must be click-free; important attack tells must remain audible beneath music and cutter sounds.

## 9. Provenance and Evidence

[ASSET-PROVENANCE-01] Before an asset becomes Verified, its record must include:

- Creator/source and generation tool or commission reference.
- License and commercial-use status.
- Original prompt/reference provenance where applicable.
- Editable source and exported runtime file.
- Dimensions, format, import settings and memory estimate.
- Dependency list and localization impact.
- Technical validation result plus runtime screenshot/recording.
- Human visual/audio approval and date.

## 10. Required Count Summary

| Category | Release target |
|---|---:|
| Operator production animation sets | 4 × 8 animation groups minimum |
| Operator passive icons | 4 |
| Operator portraits | 4 × at least 2 expressions |
| NPC portraits | 3 × at least 3 expressions |
| Standard enemy families | 6 |
| Dedicated bosses | 5 |
| Complete biome/world sets | 5 |
| Narrative UI packages | Dialogue, radio, briefing, debrief, boss intro |
| Music | 1 menu, 5 level loops, 2 boss suites, 2 stingers |
| SFX | Approximately 40 event sounds |

State changes require evidence defined by [Validation Protocol](VALIDATION_PROTOCOL.md); integration alone does not justify Verified status.
