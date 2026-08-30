extends CanvasLayer

const MAIN_MENU := "res://scenes/ui/main_menu.tscn"
const CHARACTER_SELECT := "res://scenes/ui/character_select.tscn"
const LEVEL_SELECT := "res://scenes/ui/level_select.tscn"
const SETTINGS := "res://scenes/ui/settings.tscn"
const CREDITS := "res://scenes/ui/credits.tscn"
const UPGRADES := "res://scenes/ui/upgrades.tscn"
const CHARACTER_UPGRADES := "res://scenes/ui/character_upgrades.tscn"
const GAME_LEVELS := {
	"level_01": "res://scenes/levels/level_01.tscn",
	"level_02": "res://scenes/levels/level_02.tscn",
	"level_03": "res://scenes/levels/level_03.tscn",
	"level_04": "res://scenes/levels/level_04.tscn",
	"level_05": "res://scenes/levels/level_05.tscn",
}

signal scene_change_started(scene_path: String)
signal scene_change_failed(scene_path: String, error_code: int)

var changing_scene: bool = false


func load_scene(scene_path: String) -> void:
	if changing_scene:
		return
	if not ResourceLoader.exists(scene_path, "PackedScene"):
		push_error("Scene does not exist: %s" % scene_path)
		scene_change_failed.emit(scene_path, ERR_FILE_NOT_FOUND)
		return
	changing_scene = true
	scene_change_started.emit(scene_path)
	get_tree().paused = false
	var error := get_tree().change_scene_to_file(scene_path)
	changing_scene = false
	if error != OK:
		push_error("Could not load scene '%s' (error %d)." % [scene_path, error])
		scene_change_failed.emit(scene_path, error)


func load_scene_without_transition(scene_path: String) -> void:
	load_scene(scene_path)


func go_to_main_menu() -> void:
	load_scene(MAIN_MENU)


func go_to_character_select() -> void:
	load_scene(CHARACTER_SELECT)


func go_to_level_select() -> void:
	load_scene(LEVEL_SELECT)


func go_to_settings() -> void:
	load_scene(SETTINGS)


func go_to_credits() -> void:
	load_scene(CREDITS)


func go_to_upgrades() -> void:
	load_scene(UPGRADES)


func go_to_character_upgrades() -> void:
	load_scene(CHARACTER_UPGRADES)


func play_level(level_id: String) -> void:
	GameManager.start_level(level_id)
	load_scene(GAME_LEVELS.get(level_id, GAME_LEVELS["level_01"]))


func restart_level() -> void:
	play_level(GameManager.current_level_id)
