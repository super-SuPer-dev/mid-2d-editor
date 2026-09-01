class_name CharacterCatalog
extends RefCounted

const DEFAULT_CHARACTER := "tonkla"
const CHARACTER_ORDER: Array[String] = ["tonkla", "rin", "khem", "t800"]
const SHEET_COLUMNS := 4
const SHEET_ROWS := 5
const FRAME_INSET := 0.0

const CHARACTERS := {
	"tonkla": {
		"name_key": "CHAR_TONKLA_NAME",
		"role_key": "CHAR_TONKLA_ROLE",
		"description_key": "CHAR_TONKLA_DESC",
		"passive_id": "field_recovery",
		"max_health": 8,
		"move_speed": 190.0,
		"jump_velocity": -570.0,
		"attack_damage": 2,
		"dash_speed": 470.0,
		"color": Color("8fbd52"),
		"skin": Color("c68b59"),
		"uniform": Color("343a2f"),
		"art_texture": "res://assets/characters/operators/tonkla_sprite_sheet_generated_v4.png",
		"frame_inset": 0.0,
		"idle_visual_y": -8.75,
		"run_visual_y": -8.75,
	},
	"rin": {
		"name_key": "CHAR_RIN_NAME",
		"role_key": "CHAR_RIN_ROLE",
		"description_key": "CHAR_RIN_DESC",
		"passive_id": "rapid_relay",
		"max_health": 6,
		"move_speed": 225.0,
		"jump_velocity": -610.0,
		"attack_damage": 2,
		"dash_speed": 545.0,
		"color": Color("5f91bd"),
		"skin": Color("bd8058"),
		"uniform": Color("263d32"),
		"art_texture": "res://assets/characters/operators/rin_sprite_sheet_generated_v4.png",
	},
	"khem": {
		"name_key": "CHAR_KHEM_NAME",
		"role_key": "CHAR_KHEM_ROLE",
		"description_key": "CHAR_KHEM_DESC",
		"passive_id": "wide_cut",
		"max_health": 9,
		"move_speed": 170.0,
		"jump_velocity": -550.0,
		"attack_damage": 3,
		"dash_speed": 410.0,
		"color": Color("c89a4b"),
		"skin": Color("b97848"),
		"uniform": Color("33445a"),
		"art_texture": "res://assets/characters/operators/khem_sprite_sheet_generated_v4.png",
	},
	"t800": {
		"name_key": "CHAR_T800_NAME",
		"role_key": "CHAR_T800_ROLE",
		"description_key": "CHAR_T800_DESC",
		"passive_id": "reinforced_chassis",
		"max_health": 12,
		"move_speed": 155.0,
		"jump_velocity": -530.0,
		"attack_damage": 3,
		"dash_speed": 390.0,
		"color": Color("9a6ac7"),
		"skin": Color("a9adb0"),
		"uniform": Color("44484a"),
		"art_texture": "res://assets/characters/operators/t800_sprite_sheet_generated_v4.png",
	},
}


static func get_character(character_id: String) -> Dictionary:
	var character: Dictionary = CHARACTERS.get(resolve_character_id(character_id), CHARACTERS[DEFAULT_CHARACTER]).duplicate(true)
	var art_path := str(character.get("art_texture", ""))
	if not art_path.is_empty():
		character["art_texture"] = GameManager.load_runtime_texture(art_path)
	return character


static func get_ids() -> Array[String]:
	return CHARACTER_ORDER.duplicate()


static func resolve_character_id(character_id: String) -> String:
	match character_id:
		"ranger":
			return "rin"
		"villager":
			return "khem"
	return character_id if CHARACTERS.has(character_id) else DEFAULT_CHARACTER


static func get_passive_strength(character_id: String, mastery_rank: int) -> float:
	var rank := clampi(mastery_rank, 0, 5)
	match resolve_character_id(character_id):
		"tonkla":
			return 2.0 if rank >= 3 else 3.0
		"rin":
			return 0.25 + rank * 0.03
		"khem":
			return 0.25 + rank * 0.05
		"t800":
			return 2.0 if rank >= 3 else 1.0
	return 0.0


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
