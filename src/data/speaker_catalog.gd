class_name SpeakerCatalog
extends RefCounted

const SPEAKERS := {
	"commander_anan": {
		"display_name_key": "SPEAKER_ANAN",
		"portrait_id": "PORTRAIT-NPC-ANAN",
		"portrait_texture": preload("res://assets/portraits/npcs/commander_anan_neutral.png"),
		"expressions": ["neutral", "urgent", "relieved"],
		"dialogue_color": Color("d7c27a"),
		"radio_call_sign": "ACO-COMMAND",
	},
	"dr_mali": {
		"display_name_key": "SPEAKER_MALI",
		"portrait_id": "PORTRAIT-NPC-MALI",
		"portrait_texture": preload("res://assets/portraits/npcs/dr_mali_analytical.png"),
		"expressions": ["analytical", "alarmed", "hopeful"],
		"dialogue_color": Color("83d7b5"),
		"radio_call_sign": "ACO-XENO",
	},
	"technician_chai": {
		"display_name_key": "SPEAKER_CHAI",
		"portrait_id": "PORTRAIT-NPC-CHAI",
		"portrait_texture": preload("res://assets/portraits/npcs/technician_chai_neutral.png"),
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


static func get_speaker(speaker_id: String) -> Dictionary:
	return SPEAKERS.get(speaker_id, {}).duplicate(true)
