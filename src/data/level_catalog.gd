class_name LevelCatalog
extends RefCounted

## Mission metadata only. Physical layouts are authored in Scenes/levels/*.tscn.
const LEVEL_ORDER: Array[String] = ["level_01", "level_02", "level_03"]

const LEVELS := {
	"level_01": {
		"name": "CONTAMINATED GRASSLAND",
		"subtitle": "Trace the fallen alien seed",
		"location": "NORTHEAST FIELD • DAY 05",
		"size": Vector2(2700, 720),
		"required_kills": 4,
		"next_level": "level_02",
		"background": Color("71808a"),
		"accent": Color("7fae4d"),
	},
	"level_02": {
		"name": "MUTATED FOREST",
		"subtitle": "Burn through the spore canopy",
		"location": "QUARANTINE ZONE • DUSK",
		"size": Vector2(3300, 800),
		"required_kills": 6,
		"next_level": "level_03",
		"background": Color("273d39"),
		"accent": Color("50a876"),
	},
	"level_03": {
		"name": "ALIEN ROOT CAVE",
		"subtitle": "Sever the possessed banyan heart",
		"location": "ROOT DEPTH 03 • SIGNAL LOST",
		"size": Vector2(2900, 720),
		"required_kills": 5,
		"next_level": "",
		"background": Color("241d25"),
		"accent": Color("a75ba9"),
	},
}


static func get_level(level_id: String) -> Dictionary:
	return LEVELS.get(level_id, LEVELS[LEVEL_ORDER[0]]).duplicate(true)


static func get_level_number(level_id: String) -> int:
	return LEVEL_ORDER.find(level_id) + 1
