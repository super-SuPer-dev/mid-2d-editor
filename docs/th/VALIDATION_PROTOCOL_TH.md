# ระเบียบความสมบูรณ์และการตรวจสอบ

**เวอร์ชัน:** 2.0  
**สถานะ:** ข้อบังคับสำหรับ Gate และ Release  
**เอกสารหลัก:** [Validation Protocol ภาษาอังกฤษ](../VALIDATION_PROTOCOL.md) เป็นฉบับอ้างอิงสูงสุด

## 1. Traceability

[VAL-TRACE-01] ผลทดสอบทุกชิ้นต้องอ้าง Requirement ID, build และ platform อย่างน้อยหนึ่งรายการ ID หลักเป็นอังกฤษ ไม่เปลี่ยนตามภาษา

`Requirement ID → implementation/data IDs → test → evidence → defect/approval → readiness score`

ไม่มีหลักฐานให้คะแนนสูงกว่า Integrated (2) ไม่ได้

## 2. คะแนนความพร้อม

[VAL-SCORE-01]

0 Missing, 1 Placeholder, 2 Integrated, 3 Verified, 4 Release-ready

สูตรน้ำหนัก: Systems 25% + Content/Narrative 25% + Art/UI 20% + Audio 10% + QA 15% + Release 5%

Release ต้อง readiness ≥90%, Must-have/P0 ทุกชิ้น ≥Verified, ไม่มี P0/P1, localization English/Thai ครบ และ Windows/Web ผ่าน suite ที่กำหนด

## 3. ระดับ Defect

[VAL-DEFECT-01]

- P0: data loss, security/legal, เปิดไม่ได้หรือจบแคมเปญไม่ได้ — หยุด promotion/release
- P1: soft-lock, progression/story หลักเสีย, controls/UI ใช้ไม่ได้, Must-have หาย — หยุด Gate ที่เกี่ยวข้อง
- P2: defect ชัดแต่มี workaround — ต้อง triage/assign ก่อน promote
- P3: cosmetic/text/polish เล็กน้อย — เลื่อนได้เมื่อมี owner/rationale

Defect ที่เปิดใหม่ทำให้ evidence/score เดิมหมดอายุจน retest

## 4. Evidence Bundle

[VAL-EVIDENCE-01] ทุก Gate เก็บ build/commit/date/tester/platform, command/output/exit code, test/Requirement IDs, screenshot 1280×720 สองภาษา, recording สำหรับ timing/phase, save fixtures, asset technical report, defects/scores และ human approvals

## 5. Automated Validation

[VAL-AUTO-01] Must-have contract แตกต้องทำให้ test fail และ exit non-zero

### Catalog/Scene

- operators 4 และ levels 5 โหลดได้ ID unique
- ทุกด่านมี quota, boss ID/name key, biome, briefing/radio/debrief และ phases
- ทุกด่านมี encounter segments, enemy roster, tile/background kit IDs, boss pattern set และ projectile cap
- scene/texture/audio/localization/dialogue references มีจริง
- canonical ID ไม่แปล

### Mission/Gameplay

- เริ่ม `CLEAR_THREATS`, quota เปิดบอสครั้งเดียวเป็น `BOSS_ACTIVE`, บอสแพ้จึง `EXTRACTION`
- portal จบก่อนบอสไม่ได้; death/retry ไม่ให้ reward หรือ story flag ซ้ำ
- route ผ่านได้ด้วย operator configuration ที่ช้าที่สุด
- passive ถูกตัวและเคารพ min/max
- Base Technology/Mastery จำกัด 0–5 และหัก currency ครั้งเดียว

### Save/Migration

- profile ใหม่ schema v2 และ English default
- legacy save เก็บ currency/upgrades/operator/campaign progress ถูกต้อง
- duplicate Blade/Engine/Armor retire ตาม mapping
- language/mastery/story/seen sequences จำหลัง restart
- field เสีย fallback โดยไม่ลบข้อมูลดี และ recovery ใช้ backup policy

### Dialogue/Localization

- key English/Thai และ placeholders ตรงกันสองทาง
- sequence entry/trigger/completion action ตรงกัน
- speaker/expression/next references ถูกต้อง
- ไม่มี raw user-facing string นอก diagnostic ที่อนุญาต

## 6. ตรวจ Gameplay

[VAL-GAMEPLAY-01] ทดสอบทุก operator × level: briefing/skip, movement/jump/fall/dash/attack, route/collision/camera/hazard, quota/death/sample, radio 3 ครั้ง, boss intro/phases/telegraph/defeat/retry, extraction/debrief/reward/unlock, death ก่อน/ระหว่าง/หลังบอส, pause/settings/language และยืนยันไม่มี soft-lock

เก็บเวลา completion และเวลาแยกแต่ละช่วง, deaths, damage, currency และ boss phase duration ทุกด่านเป้า 5–7 นาทีตั้งแต่ผู้เล่นควบคุมจน extraction สำหรับผู้เล่นครั้งแรกที่มีทักษะพื้นฐาน แคมเปญแรกเป้า 35–50 นาทีรวม briefing/debrief/menu ตามปกติ เส้นทางบังคับต้องมีอย่างน้อยสามช่วงก่อนบอส และห้ามเดินเกิน 20 วินาทีโดยไม่มีทางเลือก traversal, threat, reward หรือ story cue

### ตรวจ Boss Projectile และ Danmaku

[VAL-BULLET-01] รูปแบบที่ได้รับแรงบันดาลใจจาก Touhou ผ่านได้เมื่อยังอ่านง่ายใน side-scrolling platformer เท่านั้น

- ทุก volley มาจาก `pattern_id` หลักและทำซ้ำเพื่อหา defect ได้
- บันทึก telegraph/active/recovery; ช่วงหนาแน่นยาว 3–6 วินาทีและมี recovery อย่างน้อย 0.75 วินาที
- ทุก pattern มี safe route ที่ไปถึงได้และกว้างอย่างน้อย 1.75 เท่าของความกว้างผู้เล่นสำหรับ operator configuration ที่ช้าที่สุด
- กระสุนห้ามเกิดทับผู้เล่น หลังขอบกล้องที่หลบไม่ได้ หรือใต้ UI สำคัญ
- cap กระสุนพร้อมกัน: ด่าน 1 = 18, ด่าน 2 = 32, ด่าน 3 = 36, ด่าน 4 = 48, ด่าน 5 = 64
- เปลี่ยน phase, บอสตาย, ผู้เล่นตาย/retry และออก scene ต้องล้างกระสุนเจ้าของทั้งหมดและยกเลิก emitter ที่รออยู่
- silhouette, สี, motion และ warning ของกระสุนต้องแยกจากฉาก pickup ตัวศัตรู และ cutter VFX
- capture Windows/Web ต้องยืนยัน 60 FPS ที่ cap ขณะ enemy, VFX และ radio UI ทำงานพร้อมกัน

## 7. ตรวจเนื้อเรื่อง

[VAL-STORY-01]

- briefing ถูก stage และเล่นครั้งเดียวอย่างปลอดภัย
- skip ให้ gameplay/story state เท่ากับอ่านจบ
- retry ไม่ทำ one-shot/reward/unlock ซ้ำ
- radio ไม่ pause/แย่ง input/บัง HUD หรือ telegraph
- boss intro ถูกครั้ง, debrief จบก่อน unlock presentation
- operator bark ตรงคนและไม่แทนข้อมูลสำคัญ
- English/Thai entry IDs/triggers/conditions/actions เหมือนกัน
- reveal เรียง: coordinated signal → data spores → seed/relay/harvester → sensory core → dormant fragment
- มนุษย์อนุมัติน้ำเสียง ความเหมาะสมทางวัฒนธรรม ความชัดวิทยาศาสตร์ และ sequel hook

## 8. ตรวจ Localization

[VAL-LOC-01]

- profile ใหม่เป็น English; Settings มี `English`/`ไทย` และจำค่า
- สลับภาษาอัปเดตหน้าปัจจุบันโดยไม่เสีย progress
- translation หาย fallback English และมี warning
- UI/objective/tutorial/name/description/dialogue/HUD ใช้ keys
- dynamic text ใช้ placeholders ไม่พึ่งลำดับ string concatenation
- Latin/Thai glyph, combining mark, punctuation และ line break ถูกต้อง
- pseudo-localization ขยายอย่างน้อย 35%
- Windows/Web แสดง Unicode/font fallback เทียบเท่า
- ภาพ UI ไม่มีข้อความฝัง
- คำแปลไทยผ่าน human fluency/tone review

## 9. ตรวจ Asset และภาพ

[VAL-ASSET-01]

Source ต้องบันทึก dimensions/format/color/alpha/editable master, grid/cell/gutter, crop/pivot, provenance/license Runtime ต้องไม่มี halo/matte/neighboring frame/seam/bleed; เท้าไม่ลอย; animation timing ลื่นและอ่านได้; filtering ไม่ blur; panel ไม่ยืด; ตรวจทุกหน้าที่ 1280×720 ใน English/Thai/pseudo; level icon ไม่บัง landmark; telegraph เห็นชัด; วัด Web texture memory จริง แต่ละ biome ต้องมี parallax อย่างน้อย 4 ชั้น, foreground, landmark, primary tile kit ที่มี caps/corners/transitions, hazard และ extraction treatment เฉพาะ ห้ามผ่าน diversity review ด้วย palette swap หรือ primary tiles ร่วมกันเพียงอย่างเดียว ทุกด่านต้องเพิ่ม enemy family ใหม่หรือ mechanic variant ที่มีความหมาย

- ศัตรูอินทรีย์และบอสทุกตัวต้องมีผลไม้ไทยหลักที่อนุมัติแล้ว โดย source sheet จับคู่โครงสร้างผลไม้อย่างน้อย 3 อย่างกับกายวิภาค และอย่างน้อย 1 อย่างกับกลไก
- เอกลักษณ์ผลไม้ต้องยังอ่านได้ในการตรวจ silhouette/value โดยไม่พึ่งสีเพียงอย่างเดียว งานพืชต่างดาวทั่วไป ผลไม้ที่เพียงติดบนตัว และ palette-only variant ไม่ผ่าน
- กระสุนและ hazard ที่ดัดแปลงจากผลไม้ต้องแยกจาก pickup, ฉาก, VFX ผู้เล่น และกันเองได้ที่ขนาด gameplay

### ตรวจแรงบันดาลใจและความเป็นต้นฉบับ

[VAL-REFERENCE-01]

- ตรวจ movement response, melee spacing, enemy placement, atmosphere และ boss rhythm เทียบกับหลักการ Hollow Knight/Castlevania ที่อนุมัติ
- Build ไม่ต้องสร้างโลก Metroidvania เชื่อมต่อกัน แคมเปญสั้นเส้นตรงห้าด่านยังเป็นมาตรฐาน
- ความหนาแน่นแบบ Touhou ปรากฏเฉพาะ boss phase ที่อนุมัติและห้ามแทน combat platform-ประชิดปกติ
- map, room layout, silhouette, animation pose, UI frame, icon, dialogue, music และ attack pattern ต้องผ่าน originality review; การลอกที่จดจำได้ทำให้ Gate ไม่ผ่าน
- screenshot อ้างอิงใช้ภายในเพื่ออธิบายหลักการได้ แต่ห้าม trace, ship หรือใช้เป็น texture ของ asset ขั้นสุดท้าย

## 10. ตรวจเสียง

เพลง loop ไม่มี click/gap, cutter/threat/boss tells แยกได้, repetition ไม่เกิด pitch artifact รุนแรง, event ไม่ trigger ซ้ำ, scene/pause/retry ไม่ซ้อน loop, Windows/Web timing ใกล้เคียง และทุกไฟล์มี provenance/license

## 11. Performance และ Stability

[VAL-PERF-01]

60 FPS ที่ 1280×720, Web peak memory <512 MB, ทดสอบ worst-case enemy/projectile/VFX/boss/radio และค้างที่ projectile cap ของแต่ละด่านอย่างน้อย 60 วินาทีโดย pooled node count ต้องนิ่ง soak 30 นาทีรวม retry/language/scene transition และต้องไม่มี node/audio/tween รั่ว error spam save เสีย หรือ input หาย

## 12. Platform Matrix

Windows export: new game, migration, full campaign, settings, recovery, soak  
Web supported browsers: new game, campaign smoke, Unicode/font, audio unlock, memory, persistence  
Keyboard/mouse และ reference layout 1280×720 เป็นขั้นต่ำ

## 13. Release Sign-off

[VAL-RELEASE-01]

- [ ] Gate 0–6 มีหลักฐานครบ
- [ ] readiness ≥90%; Must-have/P0 ≥Verified; ไม่มี P0/P1
- [ ] ด่าน 1–5, บอส, passives, Mastery, ตอนจบผ่าน
- [ ] ทุกด่านผ่านเป้า 5–7 นาทีและ biome diversity review
- [ ] boss pattern ทุกชุดผ่าน safe route, cap, cleanup และ performance Windows/Web
- [ ] new profile/migration/recovery ผ่าน
- [ ] English/Thai key/placeholder/dialogue/glossary parity ผ่าน
- [ ] English default และ live language persistence ผ่าน
- [ ] 1280×720 ไม่มี stretch/blur/halo/clipping
- [ ] Windows/Web performance/memory/Unicode/audio/soak ผ่าน
- [ ] provenance/license/release approvals ครบ
- [ ] links/IDs/states/document parity ผ่าน
- [ ] human approval ด้าน story/Thai/art/animation/boss/accessibility/balance ครบ
