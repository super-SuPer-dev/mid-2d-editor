# แผนพัฒนา

**เวอร์ชัน:** 2.0  
**สถานะ:** Roadmap สำหรับการผลิต  
**เอกสารหลัก:** [Development Plan ภาษาอังกฤษ](../DEVELOPMENT_PLAN.md) เป็นฉบับอ้างอิงสูงสุด

แผนนี้จัดงานเป็น gate สำหรับนักพัฒนาเดี่ยวที่ใช้ agent ช่วยทำงาน ไม่กำหนดสัปดาห์ตายตัว Gate ปิดเมื่อมีหลักฐานครบเท่านั้น

## 1. สภาพโครงการปัจจุบัน

[DEV-AUDIT-01] Build ปัจจุบันเป็น prototype ที่มีแกนเล่นใช้งานได้ แต่ยังไม่ใช่แคมเปญสมบูรณ์

| ด้าน | มีแล้ว | ช่องว่างก่อนวางจำหน่าย |
|---|---|---|
| การเล่น | วิ่ง กระโดด แดช โจมตี damage pickup quota mission controller 3 phase, boss lifecycle แบบ gated และ extraction | ปรับ encounter ทั้งแคมเปญ, ทดสอบ retry/recovery, accessibility และ feel บน platform วางจำหน่าย |
| แคมเปญ | 3 ด่าน | ปรับด่าน 1–3 และสร้างด่าน 4–5 |
| เจ้าหน้าที่ | 4 คน ใช้ระบบร่วม | passive, Mastery, animation production set |
| ศัตรู/บอส | behavior ศัตรู 3 แบบ, Thorn Matriarch 2 phase ตาม HP และข้อมูล phase/pattern/cap แบบ pooled ของบอส 5 ตัวผ่าน validator | ศัตรูอีก 3 ตระกูล, roster เฉพาะ biome และ behavior/art/animation/hazard/tuning ของบอสเฉพาะ 5 ตัวพร้อม human feel approval |
| Progression | implement Base Technology, Operator Mastery, save schema v2, migration ID/track เก่า และการเลื่อน story stage แล้ว | ปรับ economy/milestone, ทดสอบ recovery และตรวจ persistence ตลอดแคมเปญ |
| Story/Localization | มี English-default/live switching/fallback, ตารางสองภาษา 3 ชุด, briefing/radio/boss/debrief แบบ data-driven พร้อม one-shot state และตรวจ runtime handoff ด่าน 1 แล้ว | เติมเนื้อเรื่องด่าน 2–5, ตรวจ trigger/pacing, pseudo-localization, human Thai/story review และหลักฐาน parity บน Windows/Web |
| ภาพ/เสียง | สำรวจ generated PNG 474 ไฟล์และเปิดได้ 474/474 แต่ normalized candidate ทั้ง 188 ไฟล์ไม่ผ่าน hard-edge alpha gate; runtime ยังมี placeholder มาก | แก้/คัดเลือก candidate, ตรวจ grid/animation ราย package, integrate งานที่อนุมัติ แล้วตรวจภาพและ memory บน Windows/Web; เพลงและ ~40 SFX |
| QA | smoke test แบบไม่เขียน save จริงครอบคลุม 4 ตัวละคร, catalog/story reference 5 ด่าน, runtime 3 ด่าน, boss pattern, migration v1→v2, one-shot state และ language fallback | runtime ด่าน 4–5, retry/recovery, pseudo-localization, export, performance และ soak |

## 2. หลักการผลิต

- [DEV-PRINCIPLE-01] ล็อก ID และ data contract ก่อนสร้าง content ที่พึ่งพา
- [DEV-PRINCIPLE-02] ด่าน 1 เป็น production slice และมาตรฐานคุณภาพ
- [DEV-PRINCIPLE-03] งาน agent ทุกชิ้นต้อง review/test/rollback แยกได้
- [DEV-PRINCIPLE-04] Generated asset ยังเป็น provisional จนผ่าน technical และ visual review
- [DEV-PRINCIPLE-05] มนุษย์ต้องอนุมัติน้ำเสียงเรื่อง คำแปลไทย แอนิเมชัน ภาพ boss feel accessibility และ balance
- [DEV-PRINCIPLE-06] เขียนอังกฤษก่อนและส่งภาษาไทยใน feature slice เดียวกัน
- [DEV-PRINCIPLE-07] ทุกด่านออกแบบให้จบใน 5–7 นาที และต้องมีจังหวะ traversal, encounter mix, enemy roster, tile kit, background stack และรูปแบบบอสที่แตกต่างกัน
- [DEV-PRINCIPLE-08] Hollow Knight และ Castlevania เป็น reference หลักด้าน feel; Touhou เป็น reference รองเฉพาะ projectile phase บางช่วง วิเคราะห์หลักการได้แต่ production content ต้องเป็นต้นฉบับทั้งภาพ กลไก และเนื้อเรื่อง
- [DEV-PRINCIPLE-09] รูปทรงผลไม้ท้องถิ่นไทยเป็นธีมหลักที่บังคับใช้กับศัตรูอินทรีย์และบอส ทุกตระกูลต้องล็อกผลไม้อ้างอิง silhouette วัสดุ และกลไกก่อนผลิตแอนิเมชัน ห้ามลดความอ่านง่ายในการต่อสู้หรือใช้เพียงการย้อมสี
- [DEV-PRINCIPLE-10] การอนุมัติ concept ศัตรู/บอสต้องมี fruit identity sheet ที่จับคู่โครงสร้างผลไม้อย่างน้อย 3 อย่างกับกายวิภาคศัตรู และอย่างน้อย 1 อย่างกับ gameplay งานพืชต่างดาวทั่วไป ผลไม้ที่เพียงติดบนตัว และ body เดิมที่ย้อมสีใหม่ห้ามเข้าสู่ขั้น animation
- [DEV-PRINCIPLE-11] Generated-source audit เป็นหลักฐาน ไม่ใช่การอนุมัติ sprite, tile, portrait และ UI แบบทึบต้องแก้ soft-alpha blocker ก่อน integrate จำนวนมาก ส่วน translucent VFX ที่ตั้งใจใช้ต้องบันทึกข้อยกเว้นและทดสอบความอ่านง่ายใน runtime

## 3. สัญญางาน Agent

[DEV-TASK-01] งานต้องระบุ: objective, inputs/Requirement IDs, permitted files, outputs, required tests, localization impact, evidence, rollback condition และ human review ห้ามเปลี่ยน canonical ID หรือแตะไฟล์นอกขอบเขตโดยเงียบ

## 4. Roadmap ตาม Gate

### Gate 0 — ล็อกการออกแบบและเนื้อเรื่อง

[DEV-GATE-00]

จัดทำเอกสารอังกฤษ 4 ฉบับและไทย 4 ฉบับ ล็อก NPC/operator/enemy/boss/level/localization IDs, inspiration hierarchy, originality boundary, glossary, ห้า act, งบเวลา 5–7 นาที, เมทริกซ์การกลายพันธุ์จากผลไม้ท้องถิ่นไทย, biome diversity matrix, boss pattern IDs, projectile caps และ asset inventory พร้อมกำหนดผู้รับผิดชอบ/แนวทางแก้ blocker จาก generated-source audit ห้ามเรียก candidate ว่า production-ready จาก file integrity เพียงอย่างเดียว
**ออก Gate:** เอกสารเชื่อมถึงกัน, ID อังกฤษ/ไทยตรงกัน, story/scope ผ่าน human review, enemy bible ผลไม้ไทยกำหนดผลไม้ โครงสร้างที่แปลงเป็นกายวิภาค/กลไก และ silhouette role ของศัตรูอินทรีย์/บอสทุกตัวครบ, asset ที่ทราบมีใน register และ Must-have ไม่กำกวม

### Gate 1 — รากฐานการผลิต

[DEV-GATE-01]

สร้าง localization CSV, English default/live selector/fallback, mission phases, boss signals, dialogue/story data, passives, Mastery, save v2 migration และ automated validation ห้าด่าน ขยาย level data ให้มี encounter segments, enemy roster, tile/background kit IDs, boss pattern set และ projectile cap พร้อมระบบกระสุนบอสแบบ pooled ที่มี telegraph/recovery/safe-route/cleanup contract
**ออก Gate:** โปรไฟล์ใหม่/เก่าโหลดปลอดภัย, สลับภาษาทันทีและจำค่า, test mission ผ่าน 3 phases, dialogue skip ให้ผลเหมือนอ่านจบ, contract tests ผ่าน

**หลักฐาน implementation — 2026-08-30:** Foundation code ถูก implement แล้ว Headless smoke suite ผ่านโดยใช้ save แบบ in-memory ที่ไม่แตะ profile จริง และตรวจ migration v1→v2, การเลื่อน story stage, one-shot state ไม่ซ้ำ, story reference ครบทั้ง 5 ด่าน, localization fallback, mission 3 phases และ projectile cap ของบอสแบบ pooled ตัว validator ผ่าน 165 English/Thai entries และปฏิเสธ scene text ที่ไม่ใช่ key การตรวจผ่าน Godot MCP ยืนยันว่า fresh-profile main menu แสดง English งาน persistence ระดับ release, pseudo-localization และ parity Windows/Web อยู่ใน Gate หลัง

### Gate 2 — Production Slice ด่าน 1

[DEV-GATE-02]

redesign Contaminated Grassland ให้มีสามช่วงก่อนบอสและจบใน 5–7 นาที ผลิต Thorn Matriarch พร้อมกระสุน fan/lane สำหรับสอนผู้เล่น, briefing/radio/boss/debrief/operator barks สองภาษา, tile/parallax ชนบท, roster ศัตรู, VFX, เพลง, SFX และแทน placeholder P0 ของด่าน 1
**ออก Gate:** เล่นตั้งแต่ briefing ถึง debrief บน Windows/Web ใน 5–7 นาที movement/melee response, enemy placement, atmosphere และ boss punish window ถึงมาตรฐาน reference หลักโดยไม่ลอก protected expression ไม่มีทางเดินว่างหรือยืด combat, Thornling เงาะ, Spitter มะกรูด และ Thorn Matriarch พิสูจน์มาตรฐานเอกลักษณ์ผลไม้ไทยในขนาด gameplay, safe route/projectile cap ผ่าน และได้มาตรฐานภาพ/เสียง/UI/เรื่อง/บอสที่อนุมัติ ไม่มี P0/P1

**ความคืบหน้า implementation — 2026-08-30:** ขยาย route ด่าน 1 จาก 2,700 เป็น 4,300 px และเพิ่ม encounter gate ใช้ซ้ำได้ 3 ช่วงโดยแบ่งภัยคุกคาม 2/3/3 รวมศัตรูมาตรฐาน 8 ตัว platform 9 จุด thorn hazard 4 จุด sample 6 ชิ้น และ pacing budget 375 วินาที Test อัตโนมัติยืนยันการ assign ศัตรูไม่ซ้ำ การ activate จาก player overlap จริง การเปิด barrier, quota → boss → extraction, projectile cleanup และระยะก้าวกระโดด Godot MCP live play ยืนยัน gate แรกปลุก Thornling ทั้งสองตัวแล้ว Thorn Matriarch ใช้สัญญา 2 phase ตามพลังชีวิต: phase 1 ใช้ fan สามทางที่อ่านง่าย เมื่อเหลือครึ่งชีวิตจึงเริ่ม phase alternating lane โดยล้างกระสุนของบอสทั้งหมดก่อน telegraph ใหม่ และ HUD สองภาษาแสดง phase ปัจจุบัน Smoke suite ตรวจการเลือก pattern ตาม phase, การส่ง state ผ่าน GameManager, cleanup ตอนเปลี่ยน phase, การยิงใน phase 2, cap, shutdown และ defeat ส่วน Godot MCP live inspection ยืนยัน `Phase 1/2 → Phase 2/2` พร้อมกระสุน active เป็นศูนย์ตรงจุดเปลี่ยน ยังต้อง timed human playtest 5–7 นาที, final art/animation, เพลง/SFX, หลักฐาน Windows/Web, การอนุมัติ safe route/punish window และ human feel review ก่อนปิด Gate 2

**หลักฐาน narrative handoff — 2026-08-30:** Radio ตาม quota ทั้ง 3 sequence ของด่าน 1 ถูก request ครั้งเดียวตามลำดับ canonical และไม่ pause เกม เมื่อหลายสายเข้า queue พร้อมกัน Thorn Matriarch และ projectile runner จะยังปิดอยู่จน radio queue เดินถึง boss introduction และผู้เล่นจบ introduction นั้น HUD ก่อนสู้ถูก initialize ด้วยพลังชีวิตเต็มและสัญญา `Phase 1/2` ที่ถูกต้องแทนค่า default เก่า Test อัตโนมัติตรวจลำดับ การซ้ำ pause state การไม่ activate ก่อน intro ข้อมูล HUD preview และการ activate หลัง intro ครบทุกด่านที่ implement แล้ว Godot MCP live inspection ยืนยัน radio แบบ compact ที่ `Threats 2/8` จากนั้น boss introduction แบบ pause ขณะบอสยังไม่ทำงาน พลังชีวิตเต็มและแสดง `Phase 1/2`; เมื่อจบ introduction ทั้งบอสและ runner จึง active

### Gate 3 — ปรับด่าน 2–3

[DEV-GATE-03]

ทำ graybox 5–7 นาทีแยกสำหรับ Mutated Forest และ Roots Beneath Capsule 07 แต่ละด่านมี route, tile/parallax kit, landmark, hazard และ enemy roster เฉพาะ เพิ่ม Maw Bloom Sovereign แบบยิง spore rain/rotating volley/aimed burst และ Possessed Banyan แบบ seed columns/diagonal root lines/arena control พร้อม art/audio และ midpoint reveal
**ออก Gate:** ด่าน 1–3 เป็น arc เสถียร บอส/ฉากต่างกัน เส้นทางผ่านได้ทุกเจ้าหน้าที่ และ retry/unlock/story ไม่เสีย

### Gate 4 — สร้างด่าน 4–5

[DEV-GATE-04]

สร้างเส้นทาง 5–7 นาทีแยกสำหรับ Devouring Root Marsh และ Alien Eye Nexus พร้อม traversal, tile/parallax, foreground, hazard, roster และ landmark เฉพาะ ผลิต Root Hydra แบบ multi-origin crossfire/rings/lane walls และ Root-Core Eye แบบ spirals/aimed rings/bullet curtains พร้อมศัตรูท้ายเกม ตอนจบ และสถานะหลังจบเกม
**ออก Gate:** เล่นแคมเปญห้าด่านจบโดยไม่ใช้ developer intervention และตอนจบเล่นครั้งเดียวถูกลำดับ

### Gate 5 — ขัดเกลาแคมเปญ

[DEV-GATE-05]

บาลานซ์ economy/technology/mastery/passives, cutter feel, telegraph, VFX, animation, dialogue pacing, tutorial, accessibility, UI, mix และคำแปล พร้อม pseudo-localization  
**ออก Gate:** ทุกด่านจบใน 5–7 นาทีโดยไม่เพิ่ม HP หรือทางเดินว่าง กระสุนบอสอ่านง่ายและ performance ผ่าน แต่ละ biome ผ่าน diversity review ภาษาไทย/อังกฤษอนุมัติ asset Must-have อย่างน้อย Verified และ readiness ≥85%

### Gate 6 — เตรียม Release

[DEV-GATE-06]

ทำ regression, full campaign, save recovery, 30-minute soak, performance/memory/browser/Windows export/Unicode/docs/provenance  
**ออก Gate:** readiness ≥90%, Must-have ไม่มีต่ำกว่า Verified, ไม่มี P0/P1, localization ครบ และ release sign-off

## 5. ลำดับพึ่งพา

1. IDs, glossary, save contract
2. localization, mission/boss/story contracts และ tests
3. graybox ห้าด่าน, encounter timing budget และ boss-pattern laboratory
4. ด่าน 1 production slice และ farmland diversity kit
5. pipeline enemy/projectile/boss/content ที่พิสูจน์ด้วยด่าน 1
6. ด่าน 2–3 พร้อม biome kit และ roster เฉพาะ
7. ด่าน 4–5 และตอนจบ
8. balance/accessibility/localization/release

งาน concept art, music exploration และร่างคำแปลทำคู่ขนานได้ แต่ integration ต้องรอ contract ที่เกี่ยวข้อง

### 5.1 แพ็กเกจ Redesign ด่าน บอส และความหลากหลาย

[DEV-LEVEL-01] ทุกด่านส่งผ่าน milestone เดียวกันห้าขั้น: timing graybox, enemy/hazard pass, boss-pattern laboratory, biome art pass และ integrated timing/polish review

| ด่าน | เอกลักษณ์ traversal/encounter | เอกลักษณ์ผลไม้กลายพันธุ์ | เอกลักษณ์กระสุนบอส | ความหลากหลายภาพที่ต้องมี |
|---|---|---|---|---|
| 1 — Contaminated Grassland | คลองชลประทาน หลังคาฟาร์มเตี้ย และทางพืชผลทำลายได้ | Thornling เงาะ + Spitter มะกรูด | fan ขนหนามและ lane เมล็ดพร้อม recovery กว้าง | ชุดหญ้า/ดิน/คอนกรีต, prop ชนบท, parallax 4 ชั้น และ landmark ควันจุดตก |
| 2 — Mutated Forest | ทาง canopy แนวตั้ง ชั้นเห็ด และการตัดสินใจผ่านฝนสปอร์ | Maw มังคุดอ่อน + บอสมงกุฎทุเรียน | spore rain, rotating five-way, aimed seed burst | ชุดเปลือกไม้/มอส/เห็ด, canopy หนา, สปอร์เรืองแสง และ Maw Bloom landmark |
| 3 — Roots Beneath Capsule 07 | อุโมงค์จุดตก root lift และห้องต่อสู้สั้น | Capsule Husk กระท้อน + บอสขนุน-ไทร | เสาเมล็ดขนุนและ diagonal root lines | ชุดเปลือก capsule/root/membrane, ชั้นใต้ดิน และ seed landmark |
| 4 — Devouring Root Marsh | เกาะจม แพรากเคลื่อนที่ และเส้นทางสลับตามน้ำพิษ | Root Skitter สละ + Hydra พวงลูกจาก | multi-head cluster crossfire, expanding rings, moving lane walls | ชุดโคลน/กก/conduit, หมอก/น้ำหลายชั้น และ nutrient-conduit landmark |
| 5 — Alien Eye Nexus | eye platform เปลี่ยนตำแหน่ง elite remix และ final ascent กระชับ | Eye Wisp ลำไย + Root-Core Eye กลีบแก้วมังกร | seed-eye spirals, aimed rings, bullet curtains | ชุด membrane/neural-root/core, ชั้นลึกเต้นเป็นจังหวะ และ Root-Core Eye landmark |

ก่อนเริ่ม final art ทุก graybox ต้องบรรจุ entry, สามช่วงก่อนบอส, บอส 75–120 วินาที และ extraction ภายใน 5–7 นาที เส้นทาง sample เสริมเพิ่มได้ไม่เกิน 45 วินาที ห้ามเพิ่ม HP, ระยะเดิน หรือ wave ซ้ำเพียงเพื่อถ่วงเวลา

ข้อมูล boss pattern ต้องมี `pattern_id`, phase, telegraph duration, active duration, recovery duration, projectile speed/range, projectile cap, spawn origins, safe-route rule และ cleanup event ใช้ cap ตาม [GDD-BULLET-01] และล้างกระสุนทั้งหมดเมื่อเปลี่ยน phase, บอสตาย, retry หรือออก scene

งาน asset ศัตรู/บอสทุกชิ้นต้องระบุผลไม้อ้างอิงหลักและอธิบายว่าเปลือก เมล็ด เนื้อ กลีบเลี้ยง พวง ยาง หรือรากช่วย silhouette, telegraph และการโจมตีอย่างไร Human art review ต้องปฏิเสธงานพืชต่างดาวทั่วไปก่อนผลิตแอนิเมชันเต็ม และควรเติม fruit cue ให้แอนิเมชันที่อนุมัติแล้วก่อนทิ้งทำใหม่

source package ของศัตรูแต่ละชุดต้องบันทึก `fruit_identity_id`, ชื่อผลไม้ภาษาอังกฤษ/ไทย, หลักฐานการปลูกหรือความคุ้นเคยในวัฒนธรรมท้องถิ่นไทย, structural mapping อย่างน้อย 3 จุด, mechanic mapping อย่างน้อย 1 จุด, จุดอ่านหลักในขนาด gameplay และหลักฐาน grayscale silhouette ราก เถาวัลย์ เห็ดรา และเนื้อเยื่อต่างดาวเป็นวัสดุรองเท่านั้น ศัตรูมาตรฐานในด่านเดียวกันห้ามใช้ผลไม้หลักซ้ำ บอสผสมได้ไม่เกิน 2 ผลไม้และต้องมีหนึ่งชนิดเด่นชัด

ลำดับผลิตของศัตรูแต่ละตระกูลคือ fruit identity sheet → ทดสอบ silhouette/value → key pose idle/attack → review ความอ่านง่ายในการเล่น → animation/projectile set เต็ม → runtime validation ห้ามเริ่ม full animation ก่อน sheet บันทึก structural mapping 3 จุดและ mechanic mapping 1 จุด ภาพถ่ายหรือข้อมูลผลไม้ใช้เป็น reference เท่านั้น งานที่ ship ต้องเป็นการกลายพันธุ์ต่างดาวต้นฉบับ

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
| DEV-RISK-08 | กระสุนบอสหนาแน่นไม่ยุติธรรมหรือทำ Web ช้า | cap, pooling, safe route คงที่, contrast test และ worst-case profile |
| DEV-RISK-09 | biome เป็นเพียง palette swap หรือ scope ความหลากหลายบาน | อนุมัติ tile/background/landmark kit และ roster matrix ต่อด่าน; reuse ระบบแต่ไม่ reuse visual identity |
| DEV-RISK-10 | ใช้ reference จนเหมือนการลอกหรือให้กระสุนแบบ Touhou กลบแกนเกม | แยกหลักการออกจาก protected expression, บังคับ ACO silhouette/map/UI/music/pattern ต้นฉบับ และจำกัดช่วง projectile-heavy |

## 8. Definition of Ready

Requirement/data IDs ถูกล็อก, dependency/permitted files ชัด, มี English text/key intent, ระบุ Thai impact, asset register entry, test cases, rollback และ reviewer

## 9. Definition of Done

[DEV-DONE-01] Feature เสร็จเมื่อ code/content, English/Thai, save behavior, tests, evidence, docs และ asset state อัปเดตพร้อมกัน การทำงานได้เฉพาะใน editor ยังไม่ถือว่าเสร็จ

ใช้ [Validation Protocol](VALIDATION_PROTOCOL_TH.md) และ [Asset Register](ASSET_REGISTER_TH.md) เป็นเกณฑ์ปิดงาน
