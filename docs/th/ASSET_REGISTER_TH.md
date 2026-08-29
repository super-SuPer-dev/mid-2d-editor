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
| ICON-PASSIVE-TONKLA | Field Recovery / ฟื้นฟูภาคสนาม | P1 | source true-alpha ไม่มีข้อความ 1400 px อ่านได้ที่ 64 px; ยังขาด runtime import/mastery state | Review |
| ICON-PASSIVE-RIN | Rapid Evade / หลบฉับไว | P1 | source true-alpha 1400 px สื่อ dash/cooldown ชัดที่ 64 px; ยังขาด runtime import/mastery state | Review |
| ICON-PASSIVE-KHEM | Wide Cut / คมกว้าง | P1 | source true-alpha 1400 px สื่อพื้นที่โจมตีชัดที่ 64 px; ยังขาด runtime import/mastery state | Review |
| ICON-PASSIVE-T800 | Reinforced Chassis / โครงเสริมเกราะ | P1 | source true-alpha 1400 px สื่อ damage reduction ชัดที่ 64 px; ยังขาด runtime import/mastery state | Review |
| PORTRAIT-OP-TONKLA | ภาพต้นกล้า | P1 | source true-alpha neutral/determined แบบ 2 × 900 px ขอบสะอาดและ radio-crop safe; ยังขาด runtime integration | Review |
| PORTRAIT-OP-RIN | ภาพริน | P1 | source true-alpha neutral/determined แบบ 2 × 900 px ขอบสะอาดและ radio-crop safe; ยังขาด runtime integration | Review |
| PORTRAIT-OP-KHEM | ภาพเข้ม | P1 | source true-alpha neutral/determined แบบ 2 × 900 px ขอบสะอาดและ radio-crop safe; ยังขาด runtime integration | Review |
| PORTRAIT-OP-T800 | ภาพ T-800 | P1 | source true-alpha neutral/alert แบบ 2 × 900 px ขอบสะอาดและ radio-crop safe; ยังขาด runtime integration | Review |
| PORTRAIT-NPC-ANAN | ผู้การอนันต์ | P0 | source true-alpha neutral/urgent/relieved ครบแบบ 3 × 900 px; runtime ยังใช้ neutral anchor เดิมและยังขาด full integration | Review |
| PORTRAIT-NPC-MALI | ดร.มะลิ | P0 | source true-alpha analytical/alarmed/hopeful ครบแบบ 3 × 900 px; runtime ยังใช้ analytical anchor เดิมและยังขาด full integration | Review |
| PORTRAIT-NPC-CHAI | ช่างชัย | P0 | source true-alpha neutral/amused/concerned ครบแบบ 3 × 900 px; runtime ยังใช้ neutral anchor เดิมและยังขาด full integration | Review |

## 4. ศัตรูมาตรฐาน

[ASSET-ENEMY-01]

| Asset ID | ผลไม้อ้างอิง | ชุดที่ต้องมี | สถานะ |
|---|---|---|---|
| ENEMY-THORNLING | เงาะ | body true-alpha แบบละเอียด 6 action และ contact-hit VFX เงาะแยก 4 เฟรมอยู่ใน Review ที่ `Generated-Assets/enemies/thornling/`; body ใช้ cell 700 x 800 baseline 740 และ VFX ใช้ cell 700 x 700 ที่ขอบสะอาดพร้อม hash/provenance; runtime ยังใช้ static idle เก่าและยังขาด integration/gameplay validation | Review |
| ENEMY-SPITTER | มะกรูด | body true-alpha แบบละเอียด 7 action และ seed/glob/impact VFX มะกรูดแยก 4 ชุดอยู่ใน Review ที่ `Generated-Assets/enemies/spitter/`; body ใช้ cell 700 x 800 baseline 740 ส่วน VFX ใช้ cell จัตุรัส 700/800 px ที่ขอบสะอาด มี silhouette, hash และ provenance แยกชัดเจน; runtime ยังใช้ static idle เก่าและยังขาด integration/gameplay validation | Review |
| ENEMY-MAW | มังคุดอ่อน | มี source set แบบละเอียด true-alpha 6 action ที่ `Generated-Assets/enemies/maw/`; normalized 4 x 1, cell 700 x 800, baseline 740; รอ fruit-read review และ integration | Review |
| ENEMY-ROOT-SKITTER | สละ | มี source set แบบละเอียด true-alpha 7 action ที่ `Generated-Assets/enemies/root_skitter/`; normalized 4 x 1, cell 700 x 800, baseline 740; รอ runtime integration | Review |
| ENEMY-EYE-WISP | ลำไย | body true-alpha แบบละเอียด 7 action และ seed-bolt/impact/beam VFX ลำไยแยก 4 ชุดอยู่ใน Review ที่ `Generated-Assets/enemies/eye_wisp/`; body ใช้ cell 700 x 800 และ lower visual guide 740 ส่วน VFX ใช้ cell 700 x 700 ที่ขอบสะอาด มี silhouette คงที่, hash และ provenance ครบ; ยังขาด runtime integration/gameplay validation | Review |
| ENEMY-CAPSULE-HUSK | กระท้อน | มี source set แบบละเอียด true-alpha 7 action ที่ `Generated-Assets/enemies/capsule_husk/`; normalized 4 x 1, cell 700 x 800, baseline 740; รอ runtime integration | Review |

ก่อนศัตรูหรือบอสเลื่อนจาก `Missing`/`Placeholder` เป็น `Review` source package ต้องมี fruit identity sheet ที่ระบุผลไม้ไทยหลัก, structural mapping อย่างน้อย 3 จุด, จุดที่มีผลต่อ gameplay และ grayscale silhouette check หากขาดหลักฐานนี้ห้ามเลื่อนสถานะงานภาพ

## 5. บอส

[ASSET-BOSS-01]

| Asset ID | ด่าน | ผลไม้อ้างอิง | ชุด production | สถานะ |
|---|---:|---|---|---|
| BOSS-THORN-MATRIARCH | 1 | พวงราชินีเงาะ | ชุดตัวบอส true-alpha 9 action พร้อม mine/burst, hair-thorn/impact, lane hazard ที่มี tell, portrait 3 สถานะ, intro/HUD frame และ phase marker อยู่ใน Review ที่ `Generated-Assets/bosses/thorn_matriarch/`; ยังต้อง integrate runtime, ทำ VFX/SFX ที่เหลือ และตรวจ gameplay | Review |
| BOSS-MAW-SOVEREIGN | 2 | มงกุฎทุเรียน + กายมังคุด | body true-alpha แบบละเอียด 12 action, projectile/hazard แยก 5 ชุด, portrait 3 สถานะ, intro/HUD frame และ phase marker อยู่ใน Review ที่ `Generated-Assets/bosses/maw_sovereign/`; บันทึก fruit identity sheet, normalized grids, hashes และ provenance แล้ว; ยังขาด runtime integration, VFX/SFX ขั้นสุดท้าย และ gameplay validation | Review |
| BOSS-POSSESSED-BANYAN | 3 | ขนุน + ลูกไทร | body true-alpha แบบละเอียด 13 action, projectile/hazard/death-VFX แยก 6 ชุด และ presentation แบบไม่มีข้อความอยู่ใน Review ที่ `Generated-Assets/bosses/possessed_banyan/`; presentation มี portrait 3 สถานะ, intro frame, compact HUD frame และ phase marker 3 แบบ พร้อมตรวจ alpha opening แล้ว; บันทึก identity sheet, normalized grids, hashes และ provenance ครบ; ยังขาด runtime integration, VFX/SFX ขั้นสุดท้าย และ gameplay validation | Review |
| BOSS-ROOT-HYDRA | 4 | พวงลูกจาก | fruit identity, body true-alpha 11 action/44 เฟรม, projectile/telegraph/impact แยก 7 ชุด และ presentation แบบไม่มีข้อความครบอยู่ใน Review ที่ `Generated-Assets/bosses/root_hydra/`; portrait, intro/HUD frame และ phase marker ปิด source contract แบบ Touhou จาก 4 จุดยิง; ยังขาด runtime integration, VFX/SFX ขั้นสุดท้าย และ gameplay validation | Review |
| BOSS-ROOT-CORE-EYE | 5 | พวงตาลำไย + กลีบแก้วมังกร | fruit identity, body true-alpha 13 action/52 เฟรม, projectile/telegraph/impact แยก 7 ชุด และ presentation แบบไม่มีข้อความครบอยู่ใน Review ที่ `Generated-Assets/bosses/root_core_eye/`; portrait, intro/HUD frame และ phase marker ปิด source contract ของจุดยิงตายอด 5 จุดร่วมกับตากลาง พร้อม normalized grid, hash และ provenance; ยังขาด runtime integration, VFX/SFX ขั้นสุดท้าย และ gameplay validation | Review |

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
| UI-DIALOGUE-FRAME | source true-alpha ไม่มีข้อความ 2300 × 800 px อยู่ใน Review ที่ `Generated-Assets/ui/narrative/`; ยังขาด runtime slicing/portrait/ข้อความสองภาษา | Review |
| UI-RADIO-OVERLAY | runtime มีโหมด compact ด้านขวาบนแล้ว และกรอบ pixel art true-alpha ไม่มีข้อความอยู่ใน Review ที่ `Generated-Assets/ui/narrative/`; ยังขาด skin replacement/ข้อความสองภาษา | Review |
| UI-BRIEFING-PANEL | briefing shell true-alpha ไม่มีข้อความ 1800 × 1000 px อยู่ใน Review; ยังขาด runtime composition/ข้อความสองภาษา | Review |
| UI-DEBRIEF-PANEL | debrief/results shell true-alpha ไม่มีข้อความ 1800 × 1000 px อยู่ใน Review; ยังขาด runtime composition/ข้อความสองภาษา | Review |
| UI-BOSS-HUD | frame, portrait state และ phase marker แบบไม่มีข้อความของบอสครบทั้ง 5 ตัวอยู่ใน Review ใต้ `Generated-Assets/bosses/*/presentation/`; ยังต้องทำ reusable runtime component, ตรวจข้อความสองภาษา และ gameplay-scale validation | Review |
| UI-BOSS-INTRO | intro frame และ portrait state แบบไม่มีข้อความของบอสครบทั้ง 5 ตัวอยู่ใน Review; ยังต้องทำ presentation runtime ที่รองรับ localization, timing และตรวจที่ 1280 x 720 | Review |
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
