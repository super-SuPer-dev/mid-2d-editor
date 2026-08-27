# ทะเบียนทรัพยากรเกม

**เวอร์ชัน:** 2.0  
**สถานะ:** Production inventory ที่ต้องอัปเดตต่อเนื่อง  
**เอกสารหลัก:** [Asset Register ภาษาอังกฤษ](../ASSET_REGISTER.md) เป็นฉบับอ้างอิงสูงสุด

ไฟล์ใน `Generated-Assets/` เป็น source candidate เท่านั้น ต้องตรวจเชิงเทคนิค อนุมัติภาพ ย้ายเข้า `Assets/` integrate และมีหลักฐานก่อนใช้เป็น production asset

## 1. สถานะและความสำคัญ

[ASSET-STATE-01]

`Missing → Placeholder → Review → Integrated → Verified → Release-ready`

- Missing: ยังไม่มี
- Placeholder: มีตัวแทนชั่วคราว
- Review: มี candidate รอตรวจ/อนุมัติ
- Integrated: runtime อ้างอิง production candidate แล้ว
- Verified: acceptance check ผ่าน Windows/Web
- Release-ready: คุณภาพ provenance localization และ release checks ผ่าน

P0 ขวางแคมเปญหรือกฎหมาย/การวางจำหน่าย, P1 จำเป็นต่อคุณภาพเปิดตัว, P2 เป็น polish ที่เลื่อนได้เมื่ออนุมัติขอบเขตเท่านั้น

Reference ภาพรวมแคมเปญ `ARTREF-CAMPAIGN-ANCHOR` อยู่สถานะ Review ที่ `art_refs/generated_campaign_style_anchor.png` ใช้กำหนด palette, depth, landmark, tile silhouette และภาษาชีวภาพต่างดาวของห้า biome เท่านั้น ห้ามใช้เป็น runtime asset และมี generation record อยู่ข้างไฟล์ภาพ

## 2. กฎเทคนิค

[ASSET-TECH-01]

ภาพ UI ห้ามฝังข้อความ, raster ต้องมี true alpha ไม่มี matte/halo/frame contamination, sprite sheet ระบุ cell/row/column/gutter/pivot/baseline และเท้าต้องไม่ลอย งานภาพใช้ high-resolution pixel art บน logical pixel grid พร้อมกลุ่มพิกเซลขอบคม, color ramp จำกัด และ integer nearest-neighbor scaling ห้าม photorealistic, painterly, soft airbrush, vector-smooth หรือ 3D/PBR look filtering ต้องรักษากลุ่มพิกเซลเหมือนกันบน Windows/Web, atlas/crop คุม memory, ID ไม่แปล, source แก้ไขได้ และ VFX/telegraph อ่านได้ทุก biome

## 3. ตัวละครและ Narrative

[ASSET-CHAR-01]

| Asset ID | ชื่อ | P | เกณฑ์หลัก | สถานะ |
|---|---|---:|---|---|
| CHAR-TONKLA-SHEET | Tonkla / ต้นกล้า | P0 | idle/run/jump/fall/attack/dash/hurt/death, alpha/baseline สะอาด | Review |
| CHAR-RIN-SHEET | Rin / ริน | P0 | animation contract เดียวกัน silhouette ชัด | Review |
| CHAR-KHEM-SHEET | Khem / เข้ม | P0 | contract เดียวกัน reach ขับด้วย data | Review |
| CHAR-T800-SHEET | T-800 | P0 | contract เดียวกัน damage readability | Review |
| ICON-PASSIVE-TONKLA | Field Recovery / ฟื้นฟูภาคสนาม | P1 | icon ไม่มีข้อความ | Missing |
| ICON-PASSIVE-RIN | Rapid Relay / รีเลย์ฉับไว | P1 | สื่อ dash cooldown | Missing |
| ICON-PASSIVE-KHEM | Wide Cut / คมกว้าง | P1 | สื่อพื้นที่โจมตี | Missing |
| ICON-PASSIVE-T800 | Reinforced Chassis / โครงเสริมเกราะ | P1 | สื่อ damage reduction | Missing |
| PORTRAIT-OP-TONKLA | ภาพต้นกล้า | P1 | อย่างน้อย 2 expression | Missing |
| PORTRAIT-OP-RIN | ภาพริน | P1 | อย่างน้อย 2 expression | Missing |
| PORTRAIT-OP-KHEM | ภาพเข้ม | P1 | อย่างน้อย 2 expression | Missing |
| PORTRAIT-OP-T800 | ภาพ T-800 | P1 | อย่างน้อย 2 expression | Missing |
| PORTRAIT-NPC-ANAN | ผู้การอนันต์ | P0 | integrate neutral anchor แล้ว; ยังขาด urgent/relieved | Integrated |
| PORTRAIT-NPC-MALI | ดร.มะลิ | P0 | integrate analytical anchor แล้ว; ยังขาด alarmed/hopeful | Integrated |
| PORTRAIT-NPC-CHAI | ช่างชัย | P0 | integrate neutral anchor แล้ว; ยังขาด amused/concerned | Integrated |

## 4. ศัตรูมาตรฐาน

[ASSET-ENEMY-01]

| Asset ID | ผลไม้อ้างอิง | ชุดที่ต้องมี | สถานะ |
|---|---|---|---|
| ENEMY-THORNLING | เงาะ | มี source set แบบละเอียด true-alpha 6 action ที่ `Generated-Assets/enemies/thornling/`; normalized 4 x 1, cell 700 x 800, baseline 740; runtime ยังใช้ static idle เก่าและยังขาด integration/hit VFX | Review |
| ENEMY-SPITTER | มะกรูด | integrate idle anchor และ baseline แล้ว; ต้อง retrofit fruit cue และยังขาด move/ranged/hurt/death/projectile/impact | Integrated |
| ENEMY-MAW | มังคุดอ่อน | มี source set แบบละเอียด true-alpha 6 action ที่ `Generated-Assets/enemies/maw/`; normalized 4 x 1, cell 700 x 800, baseline 740; รอ fruit-read review และ integration | Review |
| ENEMY-ROOT-SKITTER | สละ | มี source set แบบละเอียด true-alpha 7 action ที่ `Generated-Assets/enemies/root_skitter/`; normalized 4 x 1, cell 700 x 800, baseline 740; รอ runtime integration | Review |
| ENEMY-EYE-WISP | ลำไย | มี body source set แบบละเอียด true-alpha 7 action ที่ `Generated-Assets/enemies/eye_wisp/`; normalized 4 x 1, cell 700 x 800, lower visual guide 740; ยังขาด projectile/VFX และ runtime integration | Review |
| ENEMY-CAPSULE-HUSK | กระท้อน | มี source set แบบละเอียด true-alpha 7 action ที่ `Generated-Assets/enemies/capsule_husk/`; normalized 4 x 1, cell 700 x 800, baseline 740; รอ runtime integration | Review |

## 5. บอส

[ASSET-BOSS-01]

| Asset ID | ด่าน | ผลไม้อ้างอิง | ชุด production | สถานะ |
|---|---:|---|---|---|
| BOSS-THORN-MATRIARCH | 1 | พวงราชินีเงาะ | integrate ภาพบอส true-alpha แล้ว; ต้อง retrofit fruit cue และยังขาด phases/hair-thorn hazards/projectiles/tells/portrait/death/VFX/SFX | Integrated |
| BOSS-MAW-SOVEREIGN | 2 | มงกุฎทุเรียน + กายมังคุด | armored rind/bloom phases, spore rain, rotating five-way, aimed seed burst, tells, portrait, HUD, death | Missing |
| BOSS-POSSESSED-BANYAN | 3 | ขนุน + ลูกไทร | trunk/fibrous-fruit/possession phases, seed columns, diagonal roots, sticky sap | Placeholder |
| BOSS-ROOT-HYDRA | 4 | พวงลูกจาก | segmented heads/root lanes, crossfire/rings/lane walls, conduit hazards/phase states | Missing |
| BOSS-ROOT-CORE-EYE | 5 | พวงตาลำไย + กลีบแก้วมังกร | seed-eye/core phases, spirals/aimed rings/bract curtains, beams, roots, core exposure, ending death | Missing |

ชุดกระสุนต้องใช้ shape coding ที่ contrast สูง มี spawn/impact tell, editable master, atlas ที่เหมาะกับ pooling และ variant name ที่จับคู่กับ `pattern_id` แบบหนึ่งต่อหนึ่ง แต่ละด่านใช้ shader/particle เชิงเทคนิคร่วมได้ แต่ห้ามใช้ silhouette และ palette หลักเดียวกันโดยไม่ผ่าน readability review

## 6. โลกและ Gameplay

[ASSET-WORLD-01]

| Asset ID | การใช้ | สถานะ |
|---|---|---|
| WORLD-PLATFORM-SET | integrate repeat tile แบบ pixel art ของด่าน 1 โดยไม่ยืดภาพแล้ว; ยังขาด biome variants | Integrated |
| WORLD-HAZARD-SET | integrate thorn bed แบบ pixel art ของด่าน 1 และ baseline/collision ผ่านแล้ว; ยังขาด biome variants/animation | Integrated |
| WORLD-SAMPLE | integrate sample canister แบบ pixel art และขอบภาพผ่านที่ runtime scale แล้ว | Integrated |
| WORLD-PROJECTILE-SET | integrate กระสุน Spitter แบบ pixel art และหมุนตามทิศทางแล้ว; ยังขาด boss variants | Integrated |
| WORLD-EXTRACTION-PORTAL | integrate ACO extraction beacon แบบ pixel art พร้อม localized label แล้ว; ยังขาด activation VFX/biome treatment | Integrated |
| WORLD-L1-GRASSLAND | Contaminated Grassland | Review |
| WORLD-L2-FOREST | Mutated Forest | Placeholder |
| WORLD-L3-CAPSULE | Capsule/root chamber | Placeholder |
| WORLD-L4-MARSH | Devouring Root Marsh | Missing |
| WORLD-L5-NEXUS | Alien Eye Nexus | Missing |
| LANDMARK-CAPSULE-07 | Capsule/seed | Missing |
| LANDMARK-ROOT-CONDUIT | nutrient conduit | Missing |
| LANDMARK-ALIEN-EYE | sensory nexus | Missing |

แต่ละ biome ต้องมี parallax อย่างน้อย 4 ชั้น, gameplay ground/platform, foreground, hazards, extraction และ landmark โดยไม่บัง route, enemy, objective หรือ level icon primary tile kit ต้องมี straight runs, caps, inner/outer corners, slope หรือ transition เทียบเท่า, damaged/infested variants และ decorative overlay ที่ collision ปลอดภัย การเปลี่ยน palette จาก biome อื่นอย่างเดียวไม่ถือเป็น world set ที่ครบ

## 7. UI และ VFX

[ASSET-UI-01]

| Asset ID | การใช้ | สถานะ |
|---|---|---|
| UI-MENU-ATLAS | menu/button/panel | Review |
| UI-LEVEL-MAP | แผนที่ 5 ด่าน | Review |
| UI-HUD-ICON-ATLAS | HUD icons | Review |
| UI-DIALOGUE-FRAME | dialogue | Missing |
| UI-RADIO-OVERLAY | integrate โหมด compact ด้านขวาบนใต้ safe area ของ HUD/บอสแล้ว; หลักฐาน runtime ที่ `validation/screenshots/gate2_radio_overlay.png`; ยังขาด portrait expressions และกรอบ pixel art ขั้นสุดท้าย | Placeholder |
| UI-BRIEFING-PANEL | briefing | Missing |
| UI-DEBRIEF-PANEL | debrief | Missing |
| UI-BOSS-HUD | boss name/phase/health | Missing |
| UI-BOSS-INTRO | boss introduction | Missing |
| UI-MASTERY | mastery screen | Missing |
| VFX-CUTTER-SET | cutter swing/contact | Placeholder |
| VFX-DAMAGE-SET | hit/status feedback | Placeholder |

UI ต้องรองรับ 1280×720, keyboard focus, safe area, English expansion, Thai line break และ pseudo-localization ใช้ nine-slice/container แทนการยืด raster

## 8. เสียง

[ASSET-AUDIO-01]

| Asset ID | เป้าหมาย | สถานะ |
|---|---|---|
| AUDIO-UI-CLICK | click ปัจจุบัน ตรวจ license/mix | Integrated |
| MUSIC-MENU-BASE | menu/base loop 1 | Missing |
| MUSIC-LEVEL-01..05 | level loops 5 | Missing |
| MUSIC-BOSS-A | organic boss suite | Missing |
| MUSIC-BOSS-B | nexus/final suite | Missing |
| MUSIC-STINGERS | victory/defeat 2 | Missing |
| SFX-OPERATOR-SET | movement/dash/hurt/death ~10 | Missing |
| SFX-CUTTER-SET | start/swing/impact/upgrade ~8 | Missing |
| SFX-ENEMY-BOSS-SET | tells/attacks/hurt/death/phases ~14 | Missing |
| SFX-WORLD-RADIO-UI | pickups/portal/hazard/radio/UI ~8 | Missing |

ไม่มี voice-over; loop ต้องไร้ click และเสียง telegraph ต้องได้ยินใน full mix

## 9. Provenance และหลักฐาน

[ASSET-PROVENANCE-01] ก่อน Verified ต้องมี creator/source/tool, license/commercial status, prompt/reference provenance, editable source/runtime export, dimensions/format/import/memory, dependencies/localization impact, technical result, runtime screenshot/recording และ human approval

## 10. สรุปจำนวน

4 operator animation sets (อย่างน้อย 8 กลุ่ม), 4 passive icons, 4 operator portraits ×2 expressions, 3 NPC portraits ×3 expressions, ศัตรู 6 ตระกูล, บอส 5 ตัว, world sets 5, narrative UI ครบ, เพลง 1 menu + 5 levels + 2 boss suites + 2 stingers และ SFX ประมาณ 40

การเปลี่ยนสถานะต้องมีหลักฐานตาม [Validation Protocol](VALIDATION_PROTOCOL_TH.md)
