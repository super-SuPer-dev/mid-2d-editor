class_name CharacterCatalog
extends RefCounted

const DEFAULT_CHARACTER := "tonkla"
const SHEET_COLUMNS := 4
const SHEET_ROWS := 5
const FRAME_INSET := 8.0

const CHARACTERS := {
	"tonkla": {
		"name": "ต้นกล้า",
		"role": "เจ้าหน้าที่ ACO",
		"description": "ผู้เชี่ยวชาญเครื่องตัดหญ้าสมดุล พร้อมรับมือทุกสถานการณ์",
		"max_health": 8,
		"move_speed": 190.0,
		"jump_velocity": -570.0,
		"attack_damage": 2,
		"dash_speed": 470.0,
		"color": Color("8fbd52"),
		"skin": Color("c68b59"),
		"uniform": Color("343a2f"),
		"art_texture": preload("res://Generated-Assets/character/generated/tonkla-codex-final.png"),
		"frame_inset": 0.0,
		"idle_visual_y": -9.0,
		"run_visual_y": -9.0,
	},
	"ranger": {
		"name": "ริน",
		"role": "หน่วยลาดตระเวน",
		"description": "ทหารลาดตระเวนว่องไว โจมตีแล้วเปลี่ยนตำแหน่งได้รวดเร็ว",
		"max_health": 6,
		"move_speed": 225.0,
		"jump_velocity": -610.0,
		"attack_damage": 2,
		"dash_speed": 545.0,
		"color": Color("5f91bd"),
		"skin": Color("bd8058"),
		"uniform": Color("263d32"),
		"art_texture": preload("res://Generated-Assets/character/fixed/jintana.png"),
	},
	"villager": {
		"name": "เข้ม",
		"role": "อาสาสมัครอีสาน",
		"description": "ผู้รอดชีวิตจอมแกร่ง เหวี่ยงเครื่องตัดหญ้าได้กว้างและรุนแรง",
		"max_health": 9,
		"move_speed": 170.0,
		"jump_velocity": -550.0,
		"attack_damage": 3,
		"dash_speed": 410.0,
		"color": Color("c89a4b"),
		"skin": Color("b97848"),
		"uniform": Color("33445a"),
		"art_texture": preload("res://Generated-Assets/character/fixed/esan-farmer.png"),
	},
	"t800": {
		"name": "ที-800",
		"role": "จักรกลสังเคราะห์",
		"description": "จักรกลหุ้มเกราะ ทนทานสูงและทรงพลังอย่างไม่หยุดยั้ง",
		"max_health": 12,
		"move_speed": 155.0,
		"jump_velocity": -530.0,
		"attack_damage": 3,
		"dash_speed": 390.0,
		"color": Color("9a6ac7"),
		"skin": Color("a9adb0"),
		"uniform": Color("44484a"),
		"art_texture": preload("res://Generated-Assets/character/fixed/t800.png"),
	},
}


static func get_character(character_id: String) -> Dictionary:
	return CHARACTERS.get(character_id, CHARACTERS[DEFAULT_CHARACTER]).duplicate(true)


static func get_ids() -> Array[String]:
	var ids: Array[String] = []
	ids.assign(CHARACTERS.keys())
	return ids


static func get_sprite_frame(texture: Texture2D, column: int, row: int, inset: float = FRAME_INSET) -> AtlasTexture:
	var cell_size := Vector2(
		float(texture.get_width()) / SHEET_COLUMNS,
		float(texture.get_height()) / SHEET_ROWS
	)
	var frame := AtlasTexture.new()
	frame.atlas = texture
	frame.region = Rect2(
		Vector2(column * cell_size.x, row * cell_size.y) + Vector2.ONE * inset,
		cell_size - Vector2.ONE * inset * 2.0
	)
	frame.filter_clip = true
	return frame
