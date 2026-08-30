class_name LevelCatalog
extends RefCounted

## Mission metadata only. Physical layouts are authored in scenes/levels/*.tscn.
const LEVEL_ORDER: Array[String] = ["level_01", "level_02", "level_03", "level_04", "level_05"]
const MISSION_SEGMENTS := ["entry", "encounter_a", "traversal_set_piece", "encounter_b", "boss", "extraction"]

const LEVELS := {
	"level_01": {
		"implemented": true,
		"name_key": "LEVEL_01_NAME", "subtitle_key": "LEVEL_01_SUBTITLE", "location_key": "LEVEL_01_LOCATION",
		"size": Vector2(4300, 720), "threat_quota": 8, "required_kills": 8, "sample_target": 6,
		"boss_id": "thorn_matriarch", "boss_name_key": "BOSS_THORN_MATRIARCH", "biome": "contaminated_grassland",
		"target_duration_seconds": Vector2i(300, 420), "encounter_segments": MISSION_SEGMENTS,
		"pacing_budget_seconds": {"briefing": 45, "traversal": 75, "encounters": 150, "boss": 90, "extraction": 15},
		"encounter_contracts": [
			{"encounter_id": "irrigation_bank", "x_range": Vector2(120, 1100), "threat_count": 2},
			{"encounter_id": "collapsed_crop_lane", "x_range": Vector2(1100, 2300), "threat_count": 3},
			{"encounter_id": "signal_root_approach", "x_range": Vector2(2300, 3420), "threat_count": 3},
		],
		"enemy_roster": ["thornling", "spitter"], "tile_kit_id": "grassland_field",
		"background_kit_id": "grassland_parallax", "boss_pattern_set": "thorn_matriarch_tutorial", "projectile_cap": 18,
		"briefing_sequence": "level_01_briefing", "radio_sequences": ["level_01_radio_signal", "level_01_radio_route", "level_01_radio_root"],
		"boss_sequence": "level_01_boss", "debrief_sequence": "level_01_debrief",
		"mission_phases": ["CLEAR_THREATS", "BOSS_ACTIVE", "EXTRACTION"],
		"next_level": "level_02", "background": Color("71808a"), "accent": Color("7fae4d"),
	},
	"level_02": {
		"implemented": true,
		"name_key": "LEVEL_02_NAME", "subtitle_key": "LEVEL_02_SUBTITLE", "location_key": "LEVEL_02_LOCATION",
		"size": Vector2(3300, 800), "threat_quota": 5, "required_kills": 5, "sample_target": 8,
		"boss_id": "maw_bloom_sovereign", "boss_name_key": "BOSS_MAW_SOVEREIGN", "biome": "mutated_forest",
		"target_duration_seconds": Vector2i(300, 420), "encounter_segments": MISSION_SEGMENTS,
		"enemy_roster": ["thornling", "spitter", "maw"], "tile_kit_id": "forest_canopy",
		"background_kit_id": "forest_parallax", "boss_pattern_set": "maw_sovereign_spore", "projectile_cap": 32,
		"briefing_sequence": "level_02_briefing", "radio_sequences": ["level_02_radio_01", "level_02_radio_02", "level_02_radio_03"],
		"boss_sequence": "level_02_boss", "debrief_sequence": "level_02_debrief",
		"mission_phases": ["CLEAR_THREATS", "BOSS_ACTIVE", "EXTRACTION"],
		"next_level": "level_03", "background": Color("273d39"), "accent": Color("50a876"),
	},
	"level_03": {
		"implemented": true,
		"name_key": "LEVEL_03_NAME", "subtitle_key": "LEVEL_03_SUBTITLE", "location_key": "LEVEL_03_LOCATION",
		"size": Vector2(2900, 720), "threat_quota": 5, "required_kills": 5, "sample_target": 5,
		"boss_id": "possessed_banyan", "boss_name_key": "BOSS_POSSESSED_BANYAN", "biome": "capsule_root_chamber",
		"target_duration_seconds": Vector2i(300, 420), "encounter_segments": MISSION_SEGMENTS,
		"enemy_roster": ["thornling", "spitter", "maw", "capsule_husk"], "tile_kit_id": "capsule_root_chamber",
		"background_kit_id": "root_cave_parallax", "boss_pattern_set": "possessed_banyan_control", "projectile_cap": 36,
		"briefing_sequence": "level_03_briefing", "radio_sequences": ["level_03_radio_01", "level_03_radio_02", "level_03_radio_03"],
		"boss_sequence": "level_03_boss", "debrief_sequence": "level_03_debrief",
		"mission_phases": ["CLEAR_THREATS", "BOSS_ACTIVE", "EXTRACTION"],
		"next_level": "level_04", "background": Color("241d25"), "accent": Color("a75ba9"),
	},
	"level_04": {
		"implemented": true,
		"name_key": "LEVEL_04_NAME", "subtitle_key": "LEVEL_04_SUBTITLE", "location_key": "LEVEL_04_LOCATION",
		"size": Vector2(3400, 800), "threat_quota": 6, "required_kills": 6, "sample_target": 8,
		"boss_id": "root_hydra", "boss_name_key": "BOSS_ROOT_HYDRA", "biome": "devouring_root_marsh",
		"target_duration_seconds": Vector2i(300, 420), "encounter_segments": MISSION_SEGMENTS,
		"enemy_roster": ["root_skitter", "marsh_spitter", "maw"], "tile_kit_id": "marsh_conduit",
		"background_kit_id": "marsh_parallax", "boss_pattern_set": "root_hydra_crossfire", "projectile_cap": 48,
		"briefing_sequence": "level_04_briefing", "radio_sequences": ["level_04_radio_01", "level_04_radio_02", "level_04_radio_03"],
		"boss_sequence": "level_04_boss", "debrief_sequence": "level_04_debrief",
		"mission_phases": ["CLEAR_THREATS", "BOSS_ACTIVE", "EXTRACTION"],
		"next_level": "level_05", "background": Color("263b35"), "accent": Color("72aa75"),
	},
	"level_05": {
		"implemented": true,
		"name_key": "LEVEL_05_NAME", "subtitle_key": "LEVEL_05_SUBTITLE", "location_key": "LEVEL_05_LOCATION",
		"size": Vector2(3600, 850), "threat_quota": 6, "required_kills": 6, "sample_target": 10,
		"boss_id": "root_core_eye", "boss_name_key": "BOSS_ROOT_CORE_EYE", "biome": "alien_eye_nexus",
		"target_duration_seconds": Vector2i(300, 420), "encounter_segments": MISSION_SEGMENTS,
		"enemy_roster": ["eye_wisp", "capsule_husk_elite", "mixed_elite"], "tile_kit_id": "eye_nexus",
		"background_kit_id": "nexus_parallax", "boss_pattern_set": "root_core_eye_final", "projectile_cap": 64,
		"briefing_sequence": "level_05_briefing", "radio_sequences": ["level_05_radio_01", "level_05_radio_02", "level_05_radio_03"],
		"boss_sequence": "level_05_boss", "debrief_sequence": "level_05_debrief",
		"mission_phases": ["CLEAR_THREATS", "BOSS_ACTIVE", "EXTRACTION"],
		"next_level": "", "background": Color("191427"), "accent": Color("d85bba"),
	},
}


static func get_level(level_id: String) -> Dictionary:
	return LEVELS.get(level_id, LEVELS[LEVEL_ORDER[0]]).duplicate(true)


static func get_level_number(level_id: String) -> int:
	return LEVEL_ORDER.find(level_id) + 1


static func get_display_name(level_id: String) -> String:
	return LocalizationManager.text(str(get_level(level_id).get("name_key", "LEVEL_01_NAME")))
