class_name CharacterCatalog
extends RefCounted

const DEFAULT_CHARACTER := "tonkla"

const CHARACTERS := {
	"tonkla": {
		"name": "TONKLA",
		"role": "ACO Operator",
		"description": "Balanced mower specialist. Reliable in every situation.",
		"max_health": 8,
		"move_speed": 190.0,
		"jump_velocity": -390.0,
		"attack_damage": 2,
		"dash_speed": 470.0,
		"color": Color("8fbd52"),
		"skin": Color("c68b59"),
		"uniform": Color("343a2f"),
	},
	"ranger": {
		"name": "RIN",
		"role": "Ranger",
		"description": "Fast recon soldier trained to strike and reposition.",
		"max_health": 6,
		"move_speed": 225.0,
		"jump_velocity": -420.0,
		"attack_damage": 2,
		"dash_speed": 545.0,
		"color": Color("5f91bd"),
		"skin": Color("bd8058"),
		"uniform": Color("263d32"),
	},
	"villager": {
		"name": "KHEM",
		"role": "Isan Volunteer",
		"description": "Tough local survivor with powerful wide mower swings.",
		"max_health": 9,
		"move_speed": 170.0,
		"jump_velocity": -370.0,
		"attack_damage": 3,
		"dash_speed": 410.0,
		"color": Color("c89a4b"),
		"skin": Color("b97848"),
		"uniform": Color("33445a"),
	},
	"t800": {
		"name": "T-800",
		"role": "Synthetic",
		"description": "Armored machine with high endurance and relentless power.",
		"max_health": 12,
		"move_speed": 155.0,
		"jump_velocity": -345.0,
		"attack_damage": 3,
		"dash_speed": 390.0,
		"color": Color("9a6ac7"),
		"skin": Color("a9adb0"),
		"uniform": Color("44484a"),
	},
}


static func get_character(character_id: String) -> Dictionary:
	return CHARACTERS.get(character_id, CHARACTERS[DEFAULT_CHARACTER]).duplicate(true)


static func get_ids() -> Array[String]:
	var ids: Array[String] = []
	ids.assign(CHARACTERS.keys())
	return ids
