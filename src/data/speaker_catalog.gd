class_name SpeakerCatalog
extends RefCounted

const SPEAKERS := {
	"commander_anan": {
		"display_name_key": "SPEAKER_ANAN",
		"portrait_id": "PORTRAIT-NPC-ANAN",
		"portrait_texture": "res://assets/portraits/npcs/commander_anan_neutral.png",
		"portrait_sheet": "res://assets/portraits/npcs/commander_anan_portrait_states_normalized_v1.png",
		"portrait_columns": 3,
		"expression_indices": {"neutral": 0, "urgent": 1, "relieved": 2},
		"expressions": ["neutral", "urgent", "relieved"],
		"dialogue_color": Color("d7c27a"),
		"radio_call_sign": "ACO-COMMAND",
	},
	"dr_mali": {
		"display_name_key": "SPEAKER_MALI",
		"portrait_id": "PORTRAIT-NPC-MALI",
		"portrait_texture": "res://assets/portraits/npcs/dr_mali_analytical.png",
		"portrait_sheet": "res://assets/portraits/npcs/dr_mali_portrait_states_normalized_v1.png",
		"portrait_columns": 3,
		"expression_indices": {"analytical": 0, "alarmed": 1, "hopeful": 2},
		"expressions": ["analytical", "alarmed", "hopeful"],
		"dialogue_color": Color("83d7b5"),
		"radio_call_sign": "ACO-XENO",
	},
	"technician_chai": {
		"display_name_key": "SPEAKER_CHAI",
		"portrait_id": "PORTRAIT-NPC-CHAI",
		"portrait_texture": "res://assets/portraits/npcs/technician_chai_neutral.png",
		"portrait_sheet": "res://assets/portraits/npcs/technician_chai_portrait_states_normalized_v1.png",
		"portrait_columns": 3,
		"expression_indices": {"neutral": 0, "amused": 1, "concerned": 2},
		"expressions": ["neutral", "amused", "concerned"],
		"dialogue_color": Color("e6a966"),
		"radio_call_sign": "ACO-TECH",
	},
	"selected_operator": {
		"display_name_key": "SPEAKER_OPERATOR",
		"portrait_id": "selected_operator",
		"expressions": ["neutral", "determined"],
		"dialogue_color": Color("f2f2e8"),
		"radio_call_sign": "ACO-FIELD",
	},
}

const OPERATOR_PORTRAITS := {
	"tonkla": {"portrait_sheet": "res://assets/portraits/operators/tonkla_portrait_states_normalized_v1.png", "portrait_columns": 2, "expression_indices": {"neutral": 0, "determined": 1}},
	"rin": {"portrait_sheet": "res://assets/portraits/operators/rin_portrait_states_normalized_v1.png", "portrait_columns": 2, "expression_indices": {"neutral": 0, "determined": 1}},
	"khem": {"portrait_sheet": "res://assets/portraits/operators/khem_portrait_states_normalized_v1.png", "portrait_columns": 2, "expression_indices": {"neutral": 0, "determined": 1}},
	"t800": {"portrait_sheet": "res://assets/portraits/operators/t800_portrait_states_normalized_v1.png", "portrait_columns": 2, "expression_indices": {"neutral": 0, "alert": 1}},
}


static func get_speaker(speaker_id: String) -> Dictionary:
	return SPEAKERS.get(speaker_id, {}).duplicate(true)


static func get_portrait_texture(speaker_id: String, expression: String = "neutral") -> Texture2D:
	var config: Dictionary = {}
	if speaker_id == "selected_operator":
		config = OPERATOR_PORTRAITS.get(CharacterCatalog.resolve_character_id(GameManager.selected_character_id), {})
	else:
		config = SPEAKERS.get(speaker_id, {})
	var sheet_value: Variant = config.get("portrait_sheet")
	var sheet: Texture2D = sheet_value if sheet_value is Texture2D else null
	if sheet == null and sheet_value is String and not str(sheet_value).is_empty():
		sheet = GameManager.load_runtime_texture(str(sheet_value))
	if sheet == null:
		var portrait_value: Variant = config.get("portrait_texture")
		if portrait_value is String and not str(portrait_value).is_empty():
			return GameManager.load_runtime_texture(str(portrait_value))
		return portrait_value if portrait_value is Texture2D else null
	var columns := maxi(1, int(config.get("portrait_columns", 1)))
	var indices: Dictionary = config.get("expression_indices", {})
	var column := int(indices.get(expression, 0))
	column = clampi(column, 0, columns - 1)
	var cell_size := Vector2(float(sheet.get_width()) / columns, float(sheet.get_height()))
	var frame := AtlasTexture.new()
	frame.atlas = sheet
	frame.region = Rect2(Vector2(column * cell_size.x, 0.0), cell_size)
	frame.filter_clip = true
	return frame
