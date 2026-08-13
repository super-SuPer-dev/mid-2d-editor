extends Node

const SAVE_PATH := "user://profile.json"
const CURRENT_VERSION := 1

signal profile_changed
signal save_completed
signal load_completed
signal operation_failed(message: String)

var profile: Dictionary = {}


func _ready() -> void:
	load_game()


func default_profile() -> Dictionary:
	return {
		"version": CURRENT_VERSION,
		"selected_character": CharacterCatalog.DEFAULT_CHARACTER,
		"unlocked_levels": ["level_01"],
		"completed_levels": [],
		"best_crystals": {},
		"total_crystals": 0,
		"upgrade_levels": {"blade": 0, "engine": 0, "armor": 0},
		"character_upgrade_levels": {
			"tonkla": {"blade": 0, "engine": 0, "armor": 0},
			"ranger": {"blade": 0, "engine": 0, "armor": 0},
			"villager": {"blade": 0, "engine": 0, "armor": 0},
			"t800": {"blade": 0, "engine": 0, "armor": 0},
		},
		"settings": {"master_volume": 0.8, "fullscreen": false},
	}


func save_game() -> bool:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		operation_failed.emit("Could not open the profile for writing.")
		return false
	file.store_string(JSON.stringify(profile, "\t"))
	save_completed.emit()
	return true


func load_game() -> bool:
	profile = default_profile()
	if FileAccess.file_exists(SAVE_PATH):
		var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file == null:
			operation_failed.emit("Could not open the profile for reading.")
			return false
		var parsed: Variant = JSON.parse_string(file.get_as_text())
		if parsed is Dictionary:
			_merge_profile(parsed)
		else:
			operation_failed.emit("The profile was invalid; defaults were restored.")
	if not CharacterCatalog.CHARACTERS.has(str(profile["selected_character"])):
		profile["selected_character"] = CharacterCatalog.DEFAULT_CHARACTER
	GameManager.select_character(str(profile["selected_character"]))
	apply_settings()
	load_completed.emit()
	profile_changed.emit()
	return true


func _merge_profile(loaded: Dictionary) -> void:
	for key in profile.keys():
		if loaded.has(key):
			if profile[key] is Dictionary and loaded[key] is Dictionary:
				for nested_key in loaded[key].keys():
					profile[key][nested_key] = loaded[key][nested_key]
			else:
				profile[key] = loaded[key]


func set_selected_character(character_id: String) -> void:
	profile["selected_character"] = character_id
	GameManager.select_character(character_id)
	profile_changed.emit()
	save_game()


func complete_level(level_id: String, crystals: int) -> void:
	var completed: Array = profile["completed_levels"]
	if level_id not in completed:
		completed.append(level_id)
	profile["total_crystals"] = int(profile["total_crystals"]) + crystals
	var best: Dictionary = profile["best_crystals"]
	best[level_id] = maxi(int(best.get(level_id, 0)), crystals)
	var next_level := str(LevelCatalog.get_level(level_id).get("next_level", ""))
	var unlocked: Array = profile["unlocked_levels"]
	if not next_level.is_empty() and next_level not in unlocked:
		unlocked.append(next_level)
	profile_changed.emit()
	save_game()


func is_level_unlocked(level_id: String) -> bool:
	return level_id in profile.get("unlocked_levels", [])


func get_upgrade_level(upgrade_id: String) -> int:
	return int(profile.get("upgrade_levels", {}).get(upgrade_id, 0))


func get_upgrade_cost(upgrade_id: String) -> int:
	return 4 + get_upgrade_level(upgrade_id) * 4


func purchase_upgrade(upgrade_id: String) -> bool:
	if upgrade_id not in ["blade", "engine", "armor"]:
		return false
	var current_level := get_upgrade_level(upgrade_id)
	if current_level >= 5:
		return false
	var cost := get_upgrade_cost(upgrade_id)
	if int(profile["total_crystals"]) < cost:
		return false
	profile["total_crystals"] = int(profile["total_crystals"]) - cost
	profile["upgrade_levels"][upgrade_id] = current_level + 1
	profile_changed.emit()
	save_game()
	return true


func get_character_upgrade_level(upgrade_id: String, character_id: String = "") -> int:
	var resolved_character_id := character_id if not character_id.is_empty() else GameManager.selected_character_id
	var all_levels: Dictionary = profile.get("character_upgrade_levels", {})
	var character_levels: Dictionary = all_levels.get(resolved_character_id, {})
	return int(character_levels.get(upgrade_id, 0))


func get_character_upgrade_cost(upgrade_id: String, character_id: String = "") -> int:
	return 3 + get_character_upgrade_level(upgrade_id, character_id) * 3


func purchase_character_upgrade(upgrade_id: String, character_id: String = "") -> bool:
	if upgrade_id not in ["blade", "engine", "armor"]:
		return false
	var resolved_character_id := character_id if not character_id.is_empty() else GameManager.selected_character_id
	if not CharacterCatalog.CHARACTERS.has(resolved_character_id):
		return false
	var current_level := get_character_upgrade_level(upgrade_id, resolved_character_id)
	if current_level >= 5:
		return false
	var cost := get_character_upgrade_cost(upgrade_id, resolved_character_id)
	if int(profile["total_crystals"]) < cost:
		return false
	profile["total_crystals"] = int(profile["total_crystals"]) - cost
	var all_levels: Dictionary = profile["character_upgrade_levels"]
	if not all_levels.has(resolved_character_id):
		all_levels[resolved_character_id] = {"blade": 0, "engine": 0, "armor": 0}
	var character_levels: Dictionary = all_levels[resolved_character_id]
	character_levels[upgrade_id] = current_level + 1
	all_levels[resolved_character_id] = character_levels
	profile["character_upgrade_levels"] = all_levels
	profile_changed.emit()
	save_game()
	return true


func set_master_volume(value: float) -> void:
	profile["settings"]["master_volume"] = clampf(value, 0.0, 1.0)
	apply_settings()
	save_game()


func set_fullscreen(enabled: bool) -> void:
	profile["settings"]["fullscreen"] = enabled
	apply_settings()
	save_game()


func apply_settings() -> void:
	var settings: Dictionary = profile.get("settings", {})
	var volume := float(settings.get("master_volume", 0.8))
	AudioServer.set_bus_volume_db(0, linear_to_db(maxf(volume, 0.001)))
	var mode := DisplayServer.WINDOW_MODE_FULLSCREEN if bool(settings.get("fullscreen", false)) else DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode(mode)


func erase_progress() -> void:
	profile = default_profile()
	GameManager.select_character(CharacterCatalog.DEFAULT_CHARACTER)
	apply_settings()
	profile_changed.emit()
	save_game()
