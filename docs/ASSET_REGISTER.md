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
| ICON-PASSIVE-TONKLA | Field Recovery / ฟื้นฟูภาคสนาม | P1 | `art_source/generated/ui/operator_passives/passive_tonkla_field_recovery_normalized_v1.png` / `assets/ui/icons/passive_tonkla_field_recovery_normalized_v1.png` | Text-free binary-alpha icon is placed on the English character card and remains readable at 44 px | Tooltip keys | Integrated |
| ICON-PASSIVE-RIN | Rapid Evade / หลบฉับไว | P1 | `art_source/generated/ui/operator_passives/passive_rin_rapid_evade_normalized_v1.png` / `assets/ui/icons/passive_rin_rapid_evade_normalized_v1.png` | Text-free binary-alpha icon is placed on the English character card and remains readable at 44 px | Tooltip keys | Integrated |
| ICON-PASSIVE-KHEM | Wide Cut / คมกว้าง | P1 | `art_source/generated/ui/operator_passives/passive_khem_wide_cut_normalized_v1.png` / `assets/ui/icons/passive_khem_wide_cut_normalized_v1.png` | Text-free binary-alpha icon is placed on the English character card and remains readable at 44 px | Tooltip keys | Integrated |
| ICON-PASSIVE-T800 | Reinforced Chassis / โครงเสริมเกราะ | P1 | `art_source/generated/ui/operator_passives/passive_t800_reinforced_chassis_normalized_v1.png` / `assets/ui/icons/passive_t800_reinforced_chassis_normalized_v1.png` | Text-free binary-alpha icon is placed on the English character card and remains readable at 44 px | Tooltip keys | Integrated |
| PORTRAIT-OP-TONKLA | Tonkla Portrait / ภาพต้นกล้า | P1 | `art_source/generated/portraits/operators/operator_tonkla_portrait_states_normalized_v1.png` / `assets/portraits/operators/tonkla_portrait_states_normalized_v1.png` | Neutral + determined true-alpha states in clean 2 × 900 px cells; English dialogue selects the requested atlas frame | Speaker/display keys | Integrated |
| PORTRAIT-OP-RIN | Rin Portrait / ภาพริน | P1 | `art_source/generated/portraits/operators/operator_rin_portrait_states_normalized_v1.png` / `assets/portraits/operators/rin_portrait_states_normalized_v1.png` | Neutral + determined true-alpha states in clean 2 × 900 px cells; English dialogue selects the requested atlas frame | Speaker/display keys | Integrated |
| PORTRAIT-OP-KHEM | Khem Portrait / ภาพเข้ม | P1 | `art_source/generated/portraits/operators/operator_khem_portrait_states_normalized_v1.png` / `assets/portraits/operators/khem_portrait_states_normalized_v1.png` | Neutral + determined true-alpha states in clean 2 × 900 px cells; English dialogue selects the requested atlas frame | Speaker/display keys | Integrated |
| PORTRAIT-OP-T800 | T-800 Portrait / ภาพ T-800 | P1 | `art_source/generated/portraits/operators/operator_t800_portrait_states_normalized_v1.png` / `assets/portraits/operators/t800_portrait_states_normalized_v1.png` | Neutral + alert true-alpha states in clean 2 × 900 px cells; English dialogue selects the requested atlas frame | Speaker/display keys | Integrated |
| PORTRAIT-NPC-ANAN | Commander Anan / ผู้การอนันต์ | P0 | `art_source/generated/portraits/npcs/commander_anan_portrait_states_normalized_v1.png` / `assets/portraits/npcs/commander_anan_portrait_states_normalized_v1.png` | Neutral, urgent and relieved true-alpha states in clean 3 × 900 px cells; English dialogue selects expression by stable ID | Speaker name key | Integrated |
| PORTRAIT-NPC-MALI | Dr. Mali / ดร.มะลิ | P0 | `art_source/generated/portraits/npcs/dr_mali_portrait_states_normalized_v1.png` / `assets/portraits/npcs/dr_mali_portrait_states_normalized_v1.png` | Analytical, alarmed and hopeful true-alpha states in clean 3 × 900 px cells; English dialogue selects expression by stable ID | Speaker name key | Integrated |
| PORTRAIT-NPC-CHAI | Technician Chai / ช่างชัย | P0 | `art_source/generated/portraits/npcs/technician_chai_portrait_states_normalized_v1.png` / `assets/portraits/npcs/technician_chai_portrait_states_normalized_v1.png` | Neutral, amused and concerned true-alpha states in clean 3 × 900 px cells; English dialogue selects expression by stable ID | Speaker name key | Integrated |

## 4. Standard Enemy Assets

[ASSET-ENEMY-01]

| Asset ID | Family | Fruit identity | Priority | Runtime/source status | Required set | State |
|---|---|---|---:|---|---|---|
| ENEMY-THORNLING | Thornling | Rambutan / เงาะ | P0 | Detailed true-alpha six-action body plus a detached four-frame rambutan contact-hit VFX source are in Review at `art_source/generated/enemies/thornling/`; idle/run plus contact-attack strip are promoted at `assets/enemies/standard/thornling/` with 700 × 800 cells, 740 px baseline, binary alpha, nearest filtering and deterministic 4/7/8 fps presentation. Attack tell, hurt, death, contact-hit VFX, gameplay tuning and human art review remain open; see the English provenance record. | Idle/run, contact attack, attack tell, hurt, death, contact-hit VFX | Integrated |
| ENEMY-SPITTER | Spitter | Makrut lime / มะกรูด | P0 | Detailed true-alpha seven-action body plus four detached makrut seed/glob/impact VFX strips are in Review at `art_source/generated/enemies/spitter/`; idle/walk plus seed-burst cast are promoted at `assets/enemies/standard/spitter/` with 700 × 800 cells, 740 px baseline, binary alpha, nearest filtering and deterministic 4/7/8 fps presentation. Pressure tell, juice lob, hurt, death, VFX, gameplay tuning and human art review remain open; see the English provenance record. | Idle/walk, seed-burst cast, pressure tell, juice lob, hurt, death, seed/glob/impact VFX | Integrated |
| ENEMY-MAW | Maw | Young mangosteen / มังคุดอ่อน | P0 | Detailed true-alpha six-action source set at `art_source/generated/enemies/maw/`; idle/move strips are promoted at `assets/enemies/standard/maw/` with 700 × 800 cells, 740 px baseline, binary alpha, nearest filtering and deterministic grounded animation. Bite, hurt, death, anticipation/recovery art, gameplay tuning and human fruit-read review remain open; see the English provenance record. | Idle/move, bite, hurt, death, anticipation/recovery | Integrated |
| ENEMY-ROOT-SKITTER | Root Skitter | Salak / สละ | P1 | Seven-action source set at `art_source/generated/enemies/root_skitter/` is promoted to a quantized runtime pilot at `assets/enemies/standard/root_skitter/`; idle/scuttle use 4 × 700 × 800 cells, 740 px baseline, binary alpha and nearest filtering. Remaining action binding and human silhouette/motion review are open; see the English provenance record in the runtime folder. | Idle/scuttle pilot, burrow tell, burrow, emerge attack, hurt, death | Integrated |
| ENEMY-EYE-WISP | Eye Wisp | Longan / ลำไย | P1 | Seven-action body plus detached longan seed-bolt/impact/beam VFX remain in Review at `art_source/generated/enemies/eye_wisp/`; hover and fly are promoted to `assets/enemies/standard/eye_wisp/` with 4 × 700 × 800 cells, y = 740 lower guide, binary alpha and nearest filtering. Remaining attack/action binding, VFX integration and human silhouette review are open; see the English provenance record. | Hover/fly pilot, aim tell, seed-bolt attack, beam attack, hurt, death | Integrated |
| ENEMY-CAPSULE-HUSK | Capsule Husk | Santol / กระท้อน | P0 | Detailed true-alpha seven-action source set at `art_source/generated/enemies/capsule_husk/`; idle/move strips are promoted at `assets/enemies/standard/capsule_husk/` with 700 × 800 cells, 740 px baseline, binary alpha, nearest filtering and deterministic grounded animation. Armored charge, exposed-core attack, hurt, death, shell-break tell, gameplay tuning and human fruit-read review remain open; see the English provenance record. | Idle/move, armored charge, exposed-core attack, hurt, death, shell-break tell | Integrated |

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
| BOSS-THORN-MATRIARCH | 1 | Rambutan queen cluster | P0 | Detailed true-alpha nine-action body, rolling mine/burst, spinning hair-thorn/impact, telegraphed lane hazard, three-state portrait, intro/HUD frames and phase markers are in Review at `art_source/generated/bosses/thorn_matriarch/`; armored/exposed idle plus fan-cast and mine-cast strips are promoted at `assets/enemies/bosses/thorn_matriarch/` with 1000 × 900 cells, 840 px baseline, binary alpha, nearest filtering and pattern-signal binding. Remaining action/projectile/presentation art, VFX/SFX and human boss-feel review remain open; see the English provenance record. | Integrated |
| BOSS-MAW-SOVEREIGN | 2 | Durian crown + mangosteen anatomy | P0 | Detailed true-alpha twelve-action body, five detached projectile/hazard sets, three-state portrait strip, intro/HUD frames and phase markers are in Review at `art_source/generated/bosses/maw_sovereign/`; armored/exposed idle plus spore, rotating-volley and aimed-volley cast strips are promoted at `assets/enemies/bosses/maw_sovereign/` with 1000 × 900 cells, 840 px baseline, binary alpha, nearest filtering and pattern-signal binding. Remaining death/projectile/presentation art, VFX/SFX and human boss-feel review remain open; see the English provenance record. | Integrated |
| BOSS-POSSESSED-BANYAN | 3 | Jackfruit + banyan fig | P0 | Detailed true-alpha thirteen-action body, six detached projectile/hazard/death-VFX sets, and a text-free presentation package are in Review at `art_source/generated/bosses/possessed_banyan/`; armored/exposed idle plus seed-column and diagonal-root cast strips are promoted at `assets/enemies/bosses/possessed_banyan/` with 1000 × 900 cells, 840 px baseline, binary alpha, nearest filtering and pattern-signal binding. Remaining death/projectile/presentation art, VFX/SFX and human boss-feel review remain open; see the English provenance record. | Integrated |
| BOSS-ROOT-HYDRA | 4 | Nipa-palm fruit cluster | P0 | Complete fruit-identity, eleven-action/44-frame body, seven detached projectile/telegraph/impact sets and text-free presentation package remain in Review at `art_source/generated/bosses/root_hydra/`; armored/exposed idle plus crossfire, radial-ring and lane-wall cast pilots are promoted at `assets/enemies/bosses/root_hydra/` with 1000 × 900 cells, 840 px baseline, binary alpha, nearest filtering, phase-2 exposure and pattern-signal binding. Remaining death/projectile/presentation art, audio and human boss-feel review are open; see the English provenance record. | Integrated |
| BOSS-ROOT-CORE-EYE | 5 | Longan eye cluster + dragon-fruit bracts | P0 | Complete fruit-identity, thirteen-action/52-frame body contract, seven detached projectile/telegraph/impact strips and text-free presentation package remain in Review at `art_source/generated/bosses/root_core_eye/`; sealed/exposed idle plus spiral, aimed-seed and bract-curtain cast pilots and a four-frame longan-seed projectile pilot are promoted at `assets/enemies/bosses/root_core_eye/` with binary alpha, nearest filtering, phase-2 exposure, pattern-signal binding and pooled reset coverage. Remaining action/projectile/presentation art, audio and human final-boss review are open; see the English provenance record. | Integrated |

Each boss package includes phase-readable silhouettes, pre-damage telegraphs, hit/death feedback, boss-introduction presentation, health-bar elements, projectiles/hazards and source masters. Boss mechanics remain functional if presentation assets fail to load.

Projectile production sets require high-contrast shape coding, spawn and impact tells, editable masters, pooling-friendly atlases and named variants that map one-to-one to canonical boss `pattern_id` values. Level-specific sets may share technical shaders or particles, but not the same primary projectile silhouette and palette without a readability review.

## 6. World and Gameplay Assets

[ASSET-WORLD-01]

| Asset ID | Use | Priority | Current condition | State |
|---|---|---:|---|---|
| WORLD-PLATFORM-SET | Traversal surfaces | P0 | Level 1 pixel-art repeat tile integrated without bitmap stretching; biome variants remain | Integrated |
| WORLD-HAZARD-SET | Thorns, spores, roots, marsh, nexus hazards | P0 | Level 1 pixel-art thorn bed remains the baseline; generated four-frame spore-vent, santol-piston, nutrient-root and sensory-collapse strips are now integrated into Levels 2–5 through the shared DamageHazard animation contract with nearest filtering. Final VFX variants, collision alignment, memory and human pixel-art review remain open | Integrated |
| WORLD-SAMPLE | Living sample pickup | P0 | Pixel-art ACO sample canister integrated; hard edge approved at runtime scale | Integrated |
| WORLD-PROJECTILE-SET | Enemy/boss ranged attacks | P0 | Pixel-art Spitter projectile integrated with direction-aligned rotation; boss variants remain | Integrated |
| WORLD-EXTRACTION-PORTAL | Mission extraction | P0 | Pixel-art ACO extraction beacon integrated with localized world-space label; biome treatment/activation VFX remain | Integrated |
| WORLD-L1-GRASSLAND | Contaminated Grassland environment | P0 | Generated/current background candidates | Review |
| WORLD-L2-FOREST | Mutated Forest environment | P0 | A detailed high-resolution pixel-art source package is in Review at `art_source/generated/world/level_02_mutated_forest/`; its five-layer sky/tree-line/canopy/trunk/foreground parallax pilot is integrated through `scenes/backgrounds/forest_generated_parallax.tscn` with nearest filtering and aspect-preserving scales. Seven-piece modular tiles, animated mangosteen spore vent, biome extraction beacon, Maw Bloom landmark and field-shrine prop remain in Review; placement, memory, 1280 × 720 composition and human pixel-art validation remain open | Integrated |
| WORLD-L3-CAPSULE | Capsule 07 impact/root chamber | P0 | A detailed high-resolution pixel-art source package is in Review at `art_source/generated/world/level_03_capsule_07/`; its five-layer cavern/shell/membrane/buttress/foreground parallax pilot is integrated through `scenes/backgrounds/capsule_generated_parallax.tscn` with nearest filtering and aspect-preserving scales. Seven-piece modular tiles, animated santol seed-piston hazard, root-chamber extraction beacon and Capsule 07 seed-harvester landmark remain in Review; placement, memory, 1280 × 720 composition and human pixel-art validation remain open | Integrated |
| WORLD-L4-MARSH | Devouring Root Marsh environment | P0 | A v2 candidate package is in Review at `art_source/generated/world/level_04_root_marsh/`; its five-layer storm/reed/conduit/buttress/foreground parallax pilot is integrated through `scenes/backgrounds/marsh_generated_parallax.tscn` with nearest filtering and aspect-preserving scales. Seven modular root-mat sources, four-frame nutrient-root eruption, extraction beacon and conduit landmark remain in Review; placement, memory, 1280 × 720 composition and human pixel-art validation remain open | Integrated |
| WORLD-L5-NEXUS | Alien Eye Nexus environment | P0 | A v2 candidate package is in Review at `art_source/generated/world/level_05_alien_eye_nexus/`; its five-layer impossible-depth/neural-lattice/longan-eye/dragon-bract/foreground parallax pilot is integrated through `scenes/backgrounds/nexus_generated_parallax.tscn` with nearest filtering and aspect-preserving scales. Seven modular membrane/neural-root sources, four-frame sensory platform, extraction beacon and nexus landmark remain in Review; placement, projectile readability, memory, 1280 × 720 composition and human pixel-art validation remain open | Integrated |
| LANDMARK-MAW-BLOOM | Maw Bloom lair | P0 | Generated 1536 × 1024 true-alpha Maw Bloom landmark is integrated behind the Level 2 boss arena at a 0.34 presentation scale with no collision; source/runtime provenance is recorded in the Level 2 world record. Final occlusion, composition and human pixel-art review remain open | Integrated |
| LANDMARK-CAPSULE-07 | Capsule shell and subterranean seed | P0 | Generated 1224 × 1285 true-alpha Capsule 07 seed-harvester landmark is integrated behind the Level 3 midpoint/boss route at a 0.34 presentation scale with no collision; source/runtime provenance is recorded in the Level 3 world record. Final occlusion, composition and human pixel-art review remain open | Integrated |
| LANDMARK-ROOT-CONDUIT | Marsh nutrient conduit | P1 | Generated 1536 × 1024 nutrient-conduit landmark is integrated behind the Level 4 boss arena at a 0.34 presentation scale with no collision; source/runtime provenance is recorded in the Level 4 world record. Final occlusion, composition, collision/readability and performance validation remain open | Integrated |
| LANDMARK-ALIEN-EYE | Awakened sensory nexus | P0 | Generated 1536 × 1024 awakened sensory nexus landmark is integrated behind the Level 5 final arena at a 0.34 presentation scale with no collision; source/runtime provenance is recorded in the Level 5 world record. Final occlusion, composition, projectile readability and performance validation remain open | Integrated |

Each biome needs at least four parallax layers, gameplay ground/platforms, foreground framing, hazards, extraction treatment and a landmark without obscuring routes, enemies, objectives or the level-selection icon. Its primary tile kit includes straight runs, caps, inner/outer corners, slopes or equivalent traversal transitions, damaged/infested variants and collision-safe decorative overlays. A palette swap of another biome's primary tiles is not a complete world set.

## 7. UI and VFX Assets

[ASSET-UI-01]

| Asset ID | Use | Priority | Current condition | State |
|---|---|---:|---|---|
| UI-MENU-ATLAS | Menu/button/panel art | P0 | Generated atlas integrated provisionally | Review |
| UI-LEVEL-MAP | Five-level selection map | P0 | Generated map/atlas integrated; icons repositioned | Review |
| UI-HUD-ICON-ATLAS | Health, sample, objective and ability icons | P0 | Generated atlas integrated provisionally | Review |
| UI-DIALOGUE-FRAME | Briefing/debrief dialogue | P0 | Generated text-free 2300 × 800 binary-alpha frame is integrated as the full-mode dialogue StyleBoxTexture skin; portrait insertion and bilingual fitting remain open | Integrated |
| UI-RADIO-OVERLAY | Compact non-pausing radio | P0 | Generated text-free 2300 × 800 binary-alpha frame is integrated as the compact radio StyleBoxTexture skin below HUD/boss safe areas; bilingual fitting remains open | Integrated |
| UI-BRIEFING-PANEL | Mission briefing presentation | P0 | Generated text-free 1800 × 1000 binary-alpha shell is integrated for briefing dialogue mode with English/Thai-safe content margins; full-screen tactical composition remains open | Integrated |
| UI-DEBRIEF-PANEL | Mission results/story presentation | P0 | Generated text-free 1800 × 1000 binary-alpha shell is integrated for debrief dialogue mode with English/Thai-safe content margins; full-screen results composition remains open | Integrated |
| UI-BOSS-HUD | Boss name, phase and health | P0 | Text-free frames, portrait states and phase markers for all five bosses are in Review under their `art_source/generated/bosses/*/presentation/` packages; reusable runtime component, localization fitting and gameplay-scale validation remain | Review |
| UI-BOSS-INTRO | Boss introduction treatment | P1 | Text-free intro frames and portrait states for all five bosses are in Review under their presentation packages; reusable localized presentation, timing and 1280 x 720 validation remain | Review |
| UI-MASTERY | Operator mastery screen/components | P0 | Text-free true-alpha 1800 × 1000 px screen shell plus six clean 750 px rank-node states are in Review at `art_source/generated/ui/mastery/`; runtime data binding, interaction states and bilingual fitting remain | Review |
| VFX-CUTTER-SET | Swing, contact, charged/upgrade feedback | P0 | Generated swing-arc and organic-contact strips are integrated from `assets/vfx/cutter/` with four 800 px frames, nearest filtering, binary alpha and event hooks on player attack/enemy damage. Charged-swing and upgrade-activation variants remain in Review | Integrated |
| VFX-DAMAGE-SET | Player/enemy/boss hit and status feedback | P0 | Five generated four-frame strips are integrated from `assets/vfx/damage/`: player, organic, armored, boss-core and looping root-contamination effects use binary alpha, nearest filtering and health/hazard event hooks. Final blend mode, duration tuning and human readability review remain open | Integrated |

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
