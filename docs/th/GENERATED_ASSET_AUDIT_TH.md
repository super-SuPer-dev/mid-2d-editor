# รายงานตรวจ Generated Asset

**โครงการ:** Low Attitude Warrior  
**วันที่ตรวจ:** 2026-08-30  
**ขอบเขต:** `art_source/generated/`  
**เอกสารหลัก:** [Generated Asset Audit ภาษาอังกฤษ](../GENERATED_ASSET_AUDIT.md) เป็นฉบับอ้างอิงสูงสุด

รายงานนี้ตรวจ source candidate เท่านั้น ไม่ใช่การอนุมัติ production ไฟล์ generated ยังอยู่นอก runtime import tree ของ Godot และคงสถานะ `Review` จนผ่านการตรวจภาพ การ integrate แพลตฟอร์ม และ human review

## 1. ผลการตรวจ

| รายการ | ผล | หลักฐาน / ความหมาย |
|---|---|---|
| PNG inventory | ผ่าน | 474 ไฟล์ รวม 831,196,936 bytes |
| การ decode และขนาด | ผ่าน | 474/474 ไฟล์เปิดได้ ไม่พบขนาดผิด ไฟล์ว่าง ภาพโปร่งใสทั้งภาพ หรือ texture เกิน 16,384 px |
| การมี transparency | ผ่านแบบมีเงื่อนไข | 456 ไฟล์มี pixel โปร่งใส; 18 ไฟล์ทึบเป็น background/map ที่ไม่จำเป็นต้องมี alpha โดยธรรมชาติ |
| geometry ของ normalized strip | ผ่านชั่วคราว | ไฟล์ชื่อ `_normalized_` ทั้ง 188 ไฟล์มีความกว้างหารสี่ลงตัว แต่ยังต้องตรวจ cell mapping, gutter, pivot และ baseline ราย package |
| alpha ขอบคมแบบ pixel art | ติด blocker | normalized candidate ทั้ง 188 ไฟล์มี pixel กึ่งโปร่งใสมากกว่า 2% ขัดกับเกณฑ์ hard cluster ปัจจุบันสำหรับ sprite, tile, portrait และ UI แบบทึบ |
| provenance record | ยังไม่ครบ | มี Markdown record 40 ไฟล์ แต่การตรวจนี้ยังยืนยัน coverage แบบหนึ่งต่อหนึ่งสำหรับ PNG ทั้ง 474 ไฟล์ไม่ได้ |
| runtime import/filtering | ยังไม่ตรวจ | `art_source/` ถูกตัดออกจาก Godot import ต้องคัดเลือกและ promote ก่อนตรวจ runtime |
| ภาพและ memory บน Windows/Web | ยังไม่ตรวจ | ต้องมี asset ที่ integrate แล้ว ภาพจับ 1280 x 720 และ platform build |
| การอนุมัติทิศทางภาพ | ติด blocker | สไตล์ high-resolution pixel art, silhouette, ความต่อเนื่อง animation และ transparency ที่ตั้งใจใช้ต้องผ่าน human visual review |

คำว่า `true alpha` ในรายงานนี้หมายถึงมี pixel โปร่งใสเท่านั้น ไม่ได้แปลว่าขอบสะอาด เป็น binary ไม่มี halo หรือผ่านเกณฑ์ pixel art แล้ว

## 2. คำตัดสิน

source library ผ่านความสมบูรณ์ระดับไฟล์พื้นฐาน แต่ยังไม่ผ่าน production-readiness gate รายงานนี้ไม่เลื่อน generated candidate ใดเป็น `Verified` หรือ `Release-ready` และทุกชิ้นยังคงสถานะ `Review`

pixel กึ่งโปร่งใสอาจตั้งใจใช้กับ glow, smoke, projectile trail หรือ VFX อื่นได้ แต่ต้องมีข้อยกเว้น VFX ที่บันทึกไว้และทดสอบความอ่านง่ายใน runtime ส่วน character/enemy/boss body, tile, landmark, portrait และ ornament UI แบบทึบต้องลบ soft alpha, quantize ที่ logical resolution หรือ generate ใหม่ก่อนอนุมัติ integration

## 3. งานแก้ไขที่ต้องทำ

1. แบ่ง candidate ทุกชิ้นเป็น opaque pixel art, translucent VFX ที่ตั้งใจ, full background หรือ reference ที่ไม่ใช้ใน runtime
2. generate ใหม่หรือ quantize opaque pixel art ที่ logical resolution แล้ว upscale ด้วย nearest-neighbor
3. ตรวจ cell count, gutter, frame contamination, crop, pivot, foot baseline และ timing ของทุก animation package
4. promote เฉพาะ candidate ที่อนุมัติไป `assets/` ตั้ง nearest filtering และลดพื้นที่โปร่งใสที่กิน memory
5. จับภาพทุกหน้าจอและ asset ใน gameplay ที่ 1280 x 720 ทั้ง English/Thai บน Windows/Web
6. ต้องมี human approval สำหรับ art direction, animation smoothness, silhouette, fruit identity และความอ่านง่ายของกระสุนบอสก่อนเลื่อนเกิน `Integrated`

## 4. ผลต่อความคืบหน้า

- สำรวจ source และตรวจ file integrity: เสร็จ
- ความสอดคล้องกับขอบ pixel art: ติด blocker
- runtime integration: รอแก้และคัดเลือก candidate
- platform verification: รอ integration
- สถานะรวมของ generated source: `Review`

