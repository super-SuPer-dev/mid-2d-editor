extends Node

const SAVE_PATH := "user://profile.json"
const SAVE_BACKUP_PATH := "user://profile.json.bak"
const SAVE_TEMP_PATH := "user://profile.json.tmp"
const CURRENT_VERSION := 2

signal profile_changed
signal save_completed
signal load_completed
signal operation_failed(message: String)

var profile: Dictionary = {}
var persistence_enabled: bool = true
var _test_profile_backup: Dictionary = {}


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
		"operator_mastery": {
			"tonkla": 0,
			"rin": 0,
			"khem": 0,
			"t800": 0,
		},
		"story_stage": 1,
		"seen_dialogue_sequences": [],
		"settings": {"master_volume": 0.8, "fullscreen": false, "language": "en", "immediate_dialogue_text": false},
	}


func save_game() -> bool:
	if not persistence_enabled:
		save_completed.emit()
		return true
	var temp_file := FileAccess.open(SAVE_TEMP_PATH, FileAccess.WRITE)
	if temp_file == null:
		operation_failed.emit("Could not open the profile for writing.")
		return false
	temp_file.store_string(JSON.stringify(profile, "\t"))
	temp_file.flush()
	temp_file.close()
	var primary_path := ProjectSettings.globalize_path(SAVE_PATH)
	var backup_path := ProjectSettings.globalize_path(SAVE_BACKUP_PATH)
	var temp_path := ProjectSettings.globalize_path(SAVE_TEMP_PATH)
	if FileAccess.file_exists(SAVE_PATH):
		if FileAccess.file_exists(SAVE_BACKUP_PATH):
			var remove_backup_error := DirAccess.remove_absolute(backup_path)
			if remove_backup_error != OK:
				DirAccess.remove_absolute(temp_path)
				operation_failed.emit("Could not rotate the profile backup.")
				return false
		var backup_error := DirAccess.rename_absolute(primary_path, backup_path)
		if backup_error != OK:
			DirAccess.remove_absolute(temp_path)
			operation_failed.emit("Could not protect the previous profile backup.")
			return false
	var replace_error := DirAccess.rename_absolute(temp_path, primary_path)
	if replace_error != OK:
		operation_failed.emit("Could not replace the profile atomically; the backup is available for recovery.")
		return false
	save_completed.emit()
	return true


func load_game() -> bool:
	profile = default_profile()
	var primary_profile: Variant = _read_profile_file(SAVE_PATH)
	var backup_profile: Variant = _read_profile_file(SAVE_BACKUP_PATH)
	var recovered_profile := _select_recovery_profile(primary_profile, backup_profile)
	if recovered_profile.is_empty() and (primary_profile != null or backup_profile != null):
		operation_failed.emit("The profile and its backup were invalid; defaults were restored.")
	elif recovered_profile.is_empty() and (FileAccess.file_exists(SAVE_PATH) or FileAccess.file_exists(SAVE_BACKUP_PATH)):
		operation_failed.emit("The profile could not be read; defaults were restored.")
	elif not _is_recoverable_profile(primary_profile) and _is_recoverable_profile(backup_profile):
		operation_failed.emit("The primary profile was invalid; backup recovery was used.")
	if not recovered_profile.is_empty():
		_merge_profile(_migrate_profile(recovered_profile))
	if not CharacterCatalog.CHARACTERS.has(str(profile["selected_character"])):
		profile["selected_character"] = CharacterCatalog.DEFAULT_CHARACTER
	GameManager.select_character(str(profile["selected_character"]))
	apply_settings()
	load_completed.emit()
	profile_changed.emit()
	return true


func _read_profile_file(path: String) -> Variant:
	if not FileAccess.file_exists(path):
		return null
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return null
	return JSON.parse_string(file.get_as_text())


func _select_recovery_profile(primary_profile: Variant, backup_profile: Variant) -> Dictionary:
	if _is_recoverable_profile(primary_profile):
		return primary_profile.duplicate(true)
	if _is_recoverable_profile(backup_profile):
		return backup_profile.duplicate(true)
	return {}


func _is_recoverable_profile(candidate: Variant) -> bool:
	return candidate is Dictionary and not candidate.is_empty()


func _merge_profile(loaded: Dictionary) -> void:
	profile = _merge_dictionary(profile, loaded)
	profile["version"] = CURRENT_VERSION


func _merge_dictionary(defaults: Dictionary, loaded: Dictionary) -> Dictionary:
	var merged := defaults.duplicate(true)
	for key in loaded:
		if not merged.has(key):
			continue
		if merged[key] is Dictionary and loaded[key] is Dictionary:
			merged[key] = _merge_dictionary(merged[key], loaded[key])
		else:
			merged[key] = loaded[key]
	return merged


func _migrate_profile(loaded_profile: Dictionary) -> Dictionary:
	var migrated := loaded_profile.duplicate(true)
	if int(migrated.get("version", 1)) < 2:
		migrated["selected_character"] = CharacterCatalog.resolve_character_id(str(migrated.get("selected_character", CharacterCatalog.DEFAULT_CHARACTER)))
		var mastery := {"tonkla": 0, "rin": 0, "khem": 0, "t800": 0}
		var legacy_tracks: Dictionary = migrated.get("character_upgrade_levels", {})
		var id_map := {"tonkla": "tonkla", "ranger": "rin", "villager": "khem", "t800": "t800"}
		for legacy_id: String in id_map:
			var track: Dictionary = legacy_tracks.get(legacy_id, {})
			var converted_rank := maxi(int(track.get("blade", 0)), maxi(int(track.get("engine", 0)), int(track.get("armor", 0))))
			mastery[id_map[legacy_id]] = clampi(converted_rank, 0, 5)
		migrated["operator_mastery"] = mastery
		migrated.erase("character_upgrade_levels")
		migrated["story_stage"] = 1
		migrated["seen_dialogue_sequences"] = []
		var settings: Dictionary = migrated.get("settings", {})
		settings["language"] = LocalizationManager.DEFAULT_LANGUAGE
		settings["immediate_dialogue_text"] = bool(settings.get("immediate_dialogue_text", false))
		migrated["settings"] = settings
		migrated["version"] = 2
	return migrated


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
	var completed_act := LevelCatalog.get_level_number(level_id)
	if completed_act > 0:
		profile["story_stage"] = maxi(
			int(profile.get("story_stage", 1)),
			mini(completed_act + 1, LevelCatalog.LEVEL_ORDER.size())
		)
	var unlocked: Array = profile["unlocked_levels"]
	if not next_level.is_empty() and next_level not in unlocked:
		unlocked.append(next_level)
	profile_changed.emit()
	save_game()


func begin_test_session(profile_override: Dictionary = {}) -> void:
	if persistence_enabled:
		_test_profile_backup = profile.duplicate(true)
	persistence_enabled = false
	profile = default_profile()
	if not profile_override.is_empty():
		_merge_profile(profile_override)
	GameManager.select_character(str(profile["selected_character"]))
	LocalizationManager.set_language(str(profile["settings"]["language"]))
	profile_changed.emit()


func end_test_session() -> void:
	if persistence_enabled:
		return
	profile = _test_profile_backup.duplicate(true) if not _test_profile_backup.is_empty() else default_profile()
	_test_profile_backup.clear()
	persistence_enabled = true
	GameManager.select_character(str(profile["selected_character"]))
	LocalizationManager.set_language(str(profile.get("settings", {}).get("language", LocalizationManager.DEFAULT_LANGUAGE)))
	profile_changed.emit()


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


func get_mastery_rank(character_id: String = "") -> int:
	var resolved_id := CharacterCatalog.resolve_character_id(character_id if not character_id.is_empty() else GameManager.selected_character_id)
	return clampi(int(profile.get("operator_mastery", {}).get(resolved_id, 0)), 0, 5)


func get_mastery_cost(character_id: String = "") -> int:
	return 3 + get_mastery_rank(character_id) * 3


func purchase_mastery(character_id: String = "") -> bool:
	var requested_id := character_id if not character_id.is_empty() else GameManager.selected_character_id
	if not CharacterCatalog.CHARACTERS.has(requested_id) and requested_id not in ["ranger", "villager"]:
		return false
	var resolved_id := CharacterCatalog.resolve_character_id(requested_id)
	if not CharacterCatalog.CHARACTERS.has(resolved_id):
		return false
	var current_rank := get_mastery_rank(resolved_id)
	if current_rank >= 5:
		return false
	var cost := get_mastery_cost(resolved_id)
	if int(profile["total_crystals"]) < cost:
		return false
	profile["total_crystals"] = int(profile["total_crystals"]) - cost
	profile["operator_mastery"][resolved_id] = current_rank + 1
	profile_changed.emit()
	save_game()
	return true


func get_character_upgrade_level(_upgrade_id: String, character_id: String = "") -> int:
	return get_mastery_rank(character_id)


func get_character_upgrade_cost(_upgrade_id: String, character_id: String = "") -> int:
	return get_mastery_cost(character_id)


func purchase_character_upgrade(_upgrade_id: String, character_id: String = "") -> bool:
	return purchase_mastery(character_id)


func set_master_volume(value: float) -> void:
	profile["settings"]["master_volume"] = clampf(value, 0.0, 1.0)
	apply_settings()
	save_game()


func set_fullscreen(enabled: bool) -> void:
	profile["settings"]["fullscreen"] = enabled
	apply_settings()
	save_game()


func set_language(locale: String) -> void:
	var normalized := LocalizationManager.normalize_language(locale)
	profile["settings"]["language"] = normalized
	LocalizationManager.set_language(normalized)
	profile_changed.emit()
	save_game()


func set_immediate_dialogue_text(enabled: bool) -> void:
	profile["settings"]["immediate_dialogue_text"] = enabled
	profile_changed.emit()
	save_game()


func apply_settings() -> void:
	var settings: Dictionary = profile.get("settings", {})
	var volume := float(settings.get("master_volume", 0.8))
	AudioServer.set_bus_volume_db(0, linear_to_db(maxf(volume, 0.001)))
	var mode := DisplayServer.WINDOW_MODE_FULLSCREEN if bool(settings.get("fullscreen", false)) else DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode(mode)
	LocalizationManager.set_language(str(settings.get("language", LocalizationManager.DEFAULT_LANGUAGE)))


func erase_progress() -> void:
	profile = default_profile()
	GameManager.select_character(CharacterCatalog.DEFAULT_CHARACTER)
	apply_settings()
	profile_changed.emit()
	save_game()
