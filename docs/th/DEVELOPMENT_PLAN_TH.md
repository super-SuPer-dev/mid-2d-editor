# แผนพัฒนา

**เวอร์ชัน:** 2.0  
**สถานะ:** Roadmap สำหรับการผลิต  
**เอกสารหลัก:** [Development Plan ภาษาอังกฤษ](../DEVELOPMENT_PLAN.md) เป็นฉบับอ้างอิงสูงสุด

แผนนี้จัดงานเป็น gate สำหรับนักพัฒนาเดี่ยวที่ใช้ agent ช่วยทำงาน ไม่กำหนดสัปดาห์ตายตัว Gate ปิดเมื่อมีหลักฐานครบเท่านั้น

## 1. สภาพโครงการปัจจุบัน

[DEV-AUDIT-01] Build ปัจจุบันเป็น prototype ที่มีแกนเล่นใช้งานได้ แต่ยังไม่ใช่แคมเปญสมบูรณ์

| ด้าน | มีแล้ว | ช่องว่างก่อนวางจำหน่าย |
|---|---|---|
| การเล่น | วิ่ง กระโดด แดช โจมตี damage pickup quota portal | mission phase และ boss lifecycle มาตรฐาน |
| แคมเปญ | 3 ด่าน | ปรับด่าน 1–3 และสร้างด่าน 4–5 |
| เจ้าหน้าที่ | 4 คน ใช้ระบบร่วม | passive, Mastery, animation production set |
| ศัตรู/บอส | behavior ศัตรู 3 แบบและบอสขยายชั่วคราว | ศัตรูอีก 2 ตระกูลและบอสเฉพาะ 5 ตัว |
| Progression | อัปเกรดรวมและแทร็กซ้ำรายตัว | Base Technology + Mastery และ migration v2 |
| Story/Localization | ยังไม่มี narrative flow; string แข็งหลายจุด | English-default, Thai parity, dialogue/story state |
| ภาพ/เสียง | generated/provisional และ placeholder มาก; click sound เดียว | production art, Levels 4–5, เพลงและ ~40 SFX |
| QA | smoke test 4 ตัวละคร/3 ด่าน | 5 ด่าน บอส dialogue migration export |

## 2. หลักการผลิต

- [DEV-PRINCIPLE-01] ล็อก ID และ data contract ก่อนสร้าง content ที่พึ่งพา
- [DEV-PRINCIPLE-02] ด่าน 1 เป็น production slice และมาตรฐานคุณภาพ
- [DEV-PRINCIPLE-03] งาน agent ทุกชิ้นต้อง review/test/rollback แยกได้
- [DEV-PRINCIPLE-04] Generated asset ยังเป็น provisional จนผ่าน technical และ visual review
- [DEV-PRINCIPLE-05] มนุษย์ต้องอนุมัติน้ำเสียงเรื่อง คำแปลไทย แอนิเมชัน ภาพ boss feel accessibility และ balance
- [DEV-PRINCIPLE-06] เขียนอังกฤษก่อนและส่งภาษาไทยใน feature slice เดียวกัน

## 3. สัญญางาน Agent

[DEV-TASK-01] งานต้องระบุ: objective, inputs/Requirement IDs, permitted files, outputs, required tests, localization impact, evidence, rollback condition และ human review ห้ามเปลี่ยน canonical ID หรือแตะไฟล์นอกขอบเขตโดยเงียบ

## 4. Roadmap ตาม Gate

### Gate 0 — ล็อกการออกแบบและเนื้อเรื่อง

[DEV-GATE-00]

จัดทำเอกสารอังกฤษ 4 ฉบับและไทย 4 ฉบับ ล็อก NPC/operator/enemy/boss/level/localization IDs, glossary, ห้า act และ asset inventory  
**ออก Gate:** เอกสารเชื่อมถึงกัน, ID อังกฤษ/ไทยตรงกัน, story/scope ผ่าน human review, asset ที่ทราบมีใน register และ Must-have ไม่กำกวม

### Gate 1 — รากฐานการผลิต

[DEV-GATE-01]

สร้าง localization CSV, English default/live selector/fallback, mission phases, boss signals, dialogue/story data, passives, Mastery, save v2 migration และ automated validation ห้าด่าน  
**ออก Gate:** โปรไฟล์ใหม่/เก่าโหลดปลอดภัย, สลับภาษาทันทีและจำค่า, test mission ผ่าน 3 phases, dialogue skip ให้ผลเหมือนอ่านจบ, contract tests ผ่าน

### Gate 2 — Production Slice ด่าน 1

[DEV-GATE-02]

ผลิต Contaminated Grassland, Thorn Matriarch, briefing/radio/boss/debrief/operator barks สองภาษา, VFX, เพลง, SFX และแทน placeholder P0 ของด่าน 1  
**ออก Gate:** เล่นตั้งแต่ briefing ถึง debrief บน Windows/Web, ได้มาตรฐานภาพ/เสียง/UI/เรื่อง/บอสที่อนุมัติ, ไม่มี P0/P1

### Gate 3 — ปรับด่าน 2–3

[DEV-GATE-03]

นำมาตรฐานด่าน 1 ไปใช้กับ Mutated Forest และ Roots Beneath Capsule 07 เพิ่ม Maw Bloom Sovereign, Possessed Banyan, hazards, art/audio และ midpoint reveal  
**ออก Gate:** ด่าน 1–3 เป็น arc เสถียร บอส/ฉากต่างกัน เส้นทางผ่านได้ทุกเจ้าหน้าที่ และ retry/unlock/story ไม่เสีย

### Gate 4 — สร้างด่าน 4–5

[DEV-GATE-04]

สร้าง Devouring Root Marsh, Alien Eye Nexus, Root Hydra, Root-Core Eye, ศัตรูท้ายเกม landmark ตอนจบ และสถานะหลังจบเกม  
**ออก Gate:** เล่นแคมเปญห้าด่านจบโดยไม่ใช้ developer intervention และตอนจบเล่นครั้งเดียวถูกลำดับ

### Gate 5 — ขัดเกลาแคมเปญ

[DEV-GATE-05]

บาลานซ์ economy/technology/mastery/passives, cutter feel, telegraph, VFX, animation, dialogue pacing, tutorial, accessibility, UI, mix และคำแปล พร้อม pseudo-localization  
**ออก Gate:** playtime/difficulty ตามเป้า ภาษาไทย/อังกฤษอนุมัติ asset Must-have อย่างน้อย Verified และ readiness ≥85%

### Gate 6 — เตรียม Release

[DEV-GATE-06]

ทำ regression, full campaign, save recovery, 30-minute soak, performance/memory/browser/Windows export/Unicode/docs/provenance  
**ออก Gate:** readiness ≥90%, Must-have ไม่มีต่ำกว่า Verified, ไม่มี P0/P1, localization ครบ และ release sign-off

## 5. ลำดับพึ่งพา

1. IDs, glossary, save contract
2. localization, mission/boss/story contracts และ tests
3. ด่าน 1 production slice
4. pipeline ที่นำกลับใช้ได้
5. ด่าน 2–3
6. ด่าน 4–5 และตอนจบ
7. balance/accessibility/localization/release

งาน concept art, music exploration และร่างคำแปลทำคู่ขนานได้ แต่ integration ต้องรอ contract ที่เกี่ยวข้อง

## 6. Workstream และหลักฐาน

Systems ต้องมี test/migration logs; Gameplay ต้องมี encounter recording/input tests; Narrative ต้องมี entry-ID parity และ tone review; Art/UI ต้องมี provenance/alpha/grid report/1280×720 screenshots; Audio ต้องมี loop/mix/platform capture; QA ต้องมี evidence bundle และ release report

## 7. ความเสี่ยง

| ID | ความเสี่ยง | วิธีลด |
|---|---|---|
| DEV-RISK-01 | บอสเฉพาะ 5 ตัวเกินกำลัง solo | ใช้ lifecycle interface ร่วมและอนุมัติมาตรฐานด่าน 1 ก่อน |
| DEV-RISK-02 | sprite มี bleed/halo/baseline ลอย | ตรวจ grid/alpha/gutter/pivot/motion ก่อน integration |
| DEV-RISK-03 | hardcoded text สร้างหนี้ localization | key-first และ parity test ตั้งแต่ Gate 1 |
| DEV-RISK-04 | Web memory สูงจาก texture | atlas budget/import profile ทุก Gate |
| DEV-RISK-05 | radio บังการต่อสู้ | compact safe area และ screenshot review |
| DEV-RISK-06 | migration ทำ progress หาย | versioned fixtures/backup/recovery |
| DEV-RISK-07 | agent ทับงานอื่น | permitted-file list และ diff review |

## 8. Definition of Ready

Requirement/data IDs ถูกล็อก, dependency/permitted files ชัด, มี English text/key intent, ระบุ Thai impact, asset register entry, test cases, rollback และ reviewer

## 9. Definition of Done

[DEV-DONE-01] Feature เสร็จเมื่อ code/content, English/Thai, save behavior, tests, evidence, docs และ asset state อัปเดตพร้อมกัน การทำงานได้เฉพาะใน editor ยังไม่ถือว่าเสร็จ

ใช้ [Validation Protocol](VALIDATION_PROTOCOL_TH.md) และ [Asset Register](ASSET_REGISTER_TH.md) เป็นเกณฑ์ปิดงาน

