# Asset Register

**Project:** ACO: Capsule 07  
**Version:** 2.0  
**Status:** Living production inventory  
**Authority:** English is authoritative. See [Thai companion](th/ASSET_REGISTER_TH.md).

This register records the assets required to ship the five-level campaign. Paths beginning with `Generated-Assets/` are source candidates only. They are not production-approved until validated, reviewed, moved into `Assets/`, integrated and evidenced.

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
at `art_refs/generated_campaign_style_anchor.png`. It establishes five-biome
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

## 3. Character and Narrative Assets

[ASSET-CHAR-01]

| Asset ID | English / Thai display | Priority | Source / runtime | Acceptance summary | Localization | State |
|---|---|---:|---|---|---|---|
| CHAR-TONKLA-SHEET | Tonkla / ต้นกล้า | P0 | `Generated-Assets/character/` / current character runtime | Idle, run, jump, fall, attack, dash, hurt, death; clean alpha, stable feet/pivot | Name/description only | Review |
| CHAR-RIN-SHEET | Rin / ริน | P0 | `Generated-Assets/character/` / current character runtime | Same shared animation contract; visually distinct silhouette | Name/description only | Review |
| CHAR-KHEM-SHEET | Khem / เข้ม | P0 | `Generated-Assets/character/` / current character runtime | Same shared animation contract; attack reach remains data-driven | Name/description only | Review |
| CHAR-T800-SHEET | T-800 / T-800 | P0 | `Generated-Assets/character/` / current character runtime | Same shared animation contract; mechanical damage readability | Name/description only | Review |
| ICON-PASSIVE-TONKLA | Field Recovery / ฟื้นฟูภาคสนาม | P1 | TBD / `Assets/UI/icons/` | Clear at HUD/mastery sizes, no text | Tooltip keys | Missing |
| ICON-PASSIVE-RIN | Rapid Relay / รีเลย์ฉับไว | P1 | TBD / `Assets/UI/icons/` | Clear dash/cooldown meaning, no text | Tooltip keys | Missing |
| ICON-PASSIVE-KHEM | Wide Cut / คมกว้าง | P1 | TBD / `Assets/UI/icons/` | Clear attack-area meaning, no text | Tooltip keys | Missing |
| ICON-PASSIVE-T800 | Reinforced Chassis / โครงเสริมเกราะ | P1 | TBD / `Assets/UI/icons/` | Clear mitigation meaning, no text | Tooltip keys | Missing |
| PORTRAIT-OP-TONKLA | Tonkla Portrait / ภาพต้นกล้า | P1 | TBD / `Assets/Portraits/operators/` | Neutral + determined expressions; radio crop safe | Speaker/display keys | Missing |
| PORTRAIT-OP-RIN | Rin Portrait / ภาพริน | P1 | TBD / `Assets/Portraits/operators/` | Neutral + determined expressions; radio crop safe | Speaker/display keys | Missing |
| PORTRAIT-OP-KHEM | Khem Portrait / ภาพเข้ม | P1 | TBD / `Assets/Portraits/operators/` | Neutral + determined expressions; radio crop safe | Speaker/display keys | Missing |
| PORTRAIT-OP-T800 | T-800 Portrait / ภาพ T-800 | P1 | TBD / `Assets/Portraits/operators/` | Neutral + alert expressions; radio crop safe | Speaker/display keys | Missing |
| PORTRAIT-NPC-ANAN | Commander Anan / ผู้การอนันต์ | P0 | Generated anchor / `Assets/Portraits/npcs/commander_anan_neutral.png` | Neutral anchor integrated; urgent and relieved expressions remain | Speaker name key | Integrated |
| PORTRAIT-NPC-MALI | Dr. Mali / ดร.มะลิ | P0 | Generated anchor / `Assets/Portraits/npcs/dr_mali_analytical.png` | Analytical anchor integrated; alarmed and hopeful expressions remain | Speaker name key | Integrated |
| PORTRAIT-NPC-CHAI | Technician Chai / ช่างชัย | P0 | Generated anchor / `Assets/Portraits/npcs/technician_chai_neutral.png` | Neutral anchor integrated; amused and concerned expressions remain | Speaker name key | Integrated |

## 4. Standard Enemy Assets

[ASSET-ENEMY-01]

| Asset ID | Family | Fruit identity | Priority | Runtime/source status | Required set | State |
|---|---|---|---:|---|---|---|
| ENEMY-THORNLING | Thornling | Rambutan / เงาะ | P0 | Detailed true-alpha six-action source set at `Generated-Assets/enemies/thornling/`; normalized 4 x 1 strips use 700 x 800 cells and baseline 740; old static idle remains integrated while runtime retrofit and hit VFX remain | Idle/run, attack tell, attack, hurt, death, contact-hit VFX | Review |
| ENEMY-SPITTER | Spitter | Makrut lime / มะกรูด | P0 | Detailed true-alpha seven-action body source set at `Generated-Assets/enemies/spitter/`; normalized 4 x 1 strips use 700 x 800 cells and baseline 740; old static idle remains integrated while projectiles/VFX and runtime retrofit remain | Idle/walk, pressure tell, seed burst, juice lob, hurt, death, seed/glob/impact VFX | Review |
| ENEMY-MAW | Maw | Young mangosteen / มังคุดอ่อน | P0 | Detailed true-alpha six-action source set at `Generated-Assets/enemies/maw/`; normalized 4 x 1 strips use 700 x 800 cells and baseline 740; fruit-read review and runtime integration remain | Idle/move, bite, hurt, death, anticipation/recovery | Review |
| ENEMY-ROOT-SKITTER | Root Skitter | Salak / สละ | P1 | Detailed true-alpha seven-action source set at `Generated-Assets/enemies/root_skitter/`; normalized 4 x 1 strips use 700 x 800 cells and baseline 740; runtime integration remains | Idle/scuttle, burrow tell, burrow, emerge attack, hurt, death | Review |
| ENEMY-EYE-WISP | Eye Wisp | Longan / ลำไย | P1 | Detailed true-alpha seven-action body source set at `Generated-Assets/enemies/eye_wisp/`; normalized 4 x 1 strips use 700 x 800 cells and lower visual guide 740; detached projectile/VFX and runtime integration remain | Hover/fly, aim tell, seed-bolt attack, beam attack, hurt, death | Review |
| ENEMY-CAPSULE-HUSK | Capsule Husk | Santol / กระท้อน | P0 | Detailed true-alpha seven-action source set at `Generated-Assets/enemies/capsule_husk/`; normalized 4 x 1 strips use 700 x 800 cells and baseline 740; runtime integration remains | Idle/move, armored charge, exposed-core attack, hurt, death, shell-break tell | Review |

Production sets must expose consistent damage/hurt timing while preserving distinct silhouettes and attack tells. Color swaps alone do not count as separate families.

Before an enemy or boss advances from `Missing`/`Placeholder` to `Review`, its
source package must include a fruit identity sheet naming the primary Thai
fruit, at least three mapped structures, the gameplay-bearing structure, and a
grayscale silhouette check. Missing fruit evidence blocks art-state promotion.

## 5. Boss Assets

[ASSET-BOSS-01]

| Asset ID | Level | Fruit identity | Priority | Required production package | State |
|---|---:|---|---:|---|---|
| BOSS-THORN-MATRIARCH | 1 | Rambutan queen cluster | P0 | Detailed true-alpha nine-action body, rolling mine/burst, spinning hair-thorn/impact, telegraphed lane hazard, three-state portrait, intro/HUD frames and phase markers are in Review at `Generated-Assets/bosses/thorn_matriarch/`; runtime integration, remaining final VFX/SFX and gameplay validation remain | Review |
| BOSS-MAW-SOVEREIGN | 2 | Durian crown + mangosteen anatomy | P0 | Detailed true-alpha twelve-action body source set is in Review at `Generated-Assets/bosses/maw_sovereign/`: armored/exposed idles, move, bite tell/attack, spore/rotating/aimed/summon casts, phase break, hurt and death on 900 x 900 cells; detached projectile/VFX, portrait/HUD, runtime integration and SFX remain | Review |
| BOSS-POSSESSED-BANYAN | 3 | Jackfruit + banyan fig | P0 | Current generic scaled behavior replaced by trunk/fibrous-fruit/possession phases, seed-column and diagonal-root-line projectiles, sticky sap zones, tells, portrait, death sequence | Placeholder |
| BOSS-ROOT-HYDRA | 4 | Nipa-palm fruit cluster | P0 | Multiple segmented fruit heads/root lanes, crossfire/ring/lane-wall projectiles, conduit hazards, phase damage states, portrait, death sequence | Missing |
| BOSS-ROOT-CORE-EYE | 5 | Longan eye cluster + dragon-fruit bracts | P0 | Sensory-core phases, seed-eye spirals/aimed rings/bract curtains, beam/root hazards, final flesh-core exposure, portrait, campaign-ending death sequence | Missing |

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
| WORLD-L2-FOREST | Mutated Forest environment | P0 | Provisional reuse/tint and authored layout | Placeholder |
| WORLD-L3-CAPSULE | Capsule 07 impact/root chamber | P0 | Provisional reuse/tint and authored layout | Placeholder |
| WORLD-L4-MARSH | Devouring Root Marsh environment | P0 | No production set | Missing |
| WORLD-L5-NEXUS | Alien Eye Nexus environment | P0 | No production set | Missing |
| LANDMARK-CAPSULE-07 | Capsule shell and subterranean seed | P0 | No final landmark | Missing |
| LANDMARK-ROOT-CONDUIT | Marsh nutrient conduit | P1 | No final landmark | Missing |
| LANDMARK-ALIEN-EYE | Awakened sensory nexus | P0 | No final landmark | Missing |

Each biome needs at least four parallax layers, gameplay ground/platforms, foreground framing, hazards, extraction treatment and a landmark without obscuring routes, enemies, objectives or the level-selection icon. Its primary tile kit includes straight runs, caps, inner/outer corners, slopes or equivalent traversal transitions, damaged/infested variants and collision-safe decorative overlays. A palette swap of another biome's primary tiles is not a complete world set.

## 7. UI and VFX Assets

[ASSET-UI-01]

| Asset ID | Use | Priority | Current condition | State |
|---|---|---:|---|---|
| UI-MENU-ATLAS | Menu/button/panel art | P0 | Generated atlas integrated provisionally | Review |
| UI-LEVEL-MAP | Five-level selection map | P0 | Generated map/atlas integrated; icons repositioned | Review |
| UI-HUD-ICON-ATLAS | Health, sample, objective and ability icons | P0 | Generated atlas integrated provisionally | Review |
| UI-DIALOGUE-FRAME | Briefing/debrief dialogue | P0 | Not present | Missing |
| UI-RADIO-OVERLAY | Compact non-pausing radio | P0 | Native compact top-right mode integrated below HUD/boss safe areas; runtime evidence at `validation/screenshots/gate2_radio_overlay.png`; final portrait expressions and pixel-art frame remain | Placeholder |
| UI-BRIEFING-PANEL | Mission briefing presentation | P0 | Not present | Missing |
| UI-DEBRIEF-PANEL | Mission results/story presentation | P0 | Not present | Missing |
| UI-BOSS-HUD | Boss name, phase and health | P0 | Text-free Thorn Matriarch frame, portrait states and phase markers are in Review at `Generated-Assets/bosses/thorn_matriarch/presentation/`; reusable runtime component and other boss skins remain | Review |
| UI-BOSS-INTRO | Boss introduction treatment | P1 | Text-free Thorn Matriarch intro frame and portrait states are in Review at `Generated-Assets/bosses/thorn_matriarch/presentation/`; reusable localized presentation and other boss skins remain | Review |
| UI-MASTERY | Operator mastery screen/components | P0 | Not present | Missing |
| VFX-CUTTER-SET | Swing, contact, charged/upgrade feedback | P0 | Old/provisional attack effect | Placeholder |
| VFX-DAMAGE-SET | Player/enemy/boss hit and status feedback | P0 | Minimal/provisional | Placeholder |

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
