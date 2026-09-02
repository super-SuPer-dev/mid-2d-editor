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

var _loading_root: Control
var _loading_progress: ProgressBar
var _loading_label: Label
var _pending_scene_path: String = ""


func _ready() -> void:
	layer = 100
	process_mode = Node.PROCESS_MODE_ALWAYS
	_build_loading_screen()
	set_process(false)


func _process(_delta: float) -> void:
	if _pending_scene_path.is_empty():
		set_process(false)
		return
	var status := ResourceLoader.load_threaded_get_status(_pending_scene_path)
	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			var progress: Array = []
			ResourceLoader.load_threaded_get_status(_pending_scene_path, progress)
			if _loading_progress != null and not progress.is_empty():
				var percentage := clampf(float(progress[0]) * 100.0, 0.0, 100.0)
				_loading_progress.value = percentage
				if _loading_label != null:
					_loading_label.text = "LOADING %d%%" % int(percentage)
		ResourceLoader.THREAD_LOAD_LOADED:
			var packed_scene := ResourceLoader.load_threaded_get(_pending_scene_path) as PackedScene
			_pending_scene_path = ""
			set_process(false)
			if packed_scene == null:
				_finish_scene_change_failed(ERR_CANT_OPEN)
				return
			var error := get_tree().change_scene_to_packed(packed_scene)
			packed_scene = null
			if error != OK:
				push_error("Could not switch to scene (error %d)." % error)
				changing_scene = false
				_hide_loading_screen()
				scene_change_failed.emit(_last_requested_path, error)
			else:
				changing_scene = false
				call_deferred("_hide_loading_screen_after_scene_ready")
		ResourceLoader.THREAD_LOAD_FAILED, ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			var failed_path := _pending_scene_path
			_pending_scene_path = ""
			set_process(false)
			push_error("Could not load scene '%s'." % failed_path)
			_finish_scene_change_failed(ERR_CANT_OPEN)


var _last_requested_path: String = ""


func load_scene(scene_path: String) -> void:
	if changing_scene:
		return
	if not ResourceLoader.exists(scene_path, "PackedScene"):
		push_error("Scene does not exist: %s" % scene_path)
		scene_change_failed.emit(scene_path, ERR_FILE_NOT_FOUND)
		return
	changing_scene = true
	_last_requested_path = scene_path
	scene_change_started.emit(scene_path)
	get_tree().paused = false
	# Drop completed-scene cache references before loading the next scene. Nodes
	# in the outgoing scene still own their textures until the tree swap, while
	# dynamic spawns in the new scene can share its scoped cache normally.
	GameManager.clear_runtime_texture_cache()
	_show_loading_screen()
	_pending_scene_path = scene_path
	call_deferred("_begin_threaded_load")


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


func _begin_threaded_load() -> void:
	await get_tree().process_frame
	if _pending_scene_path.is_empty() or not changing_scene:
		return
	var request_error := ResourceLoader.load_threaded_request(
		_pending_scene_path,
		"PackedScene",
		true,
		ResourceLoader.CACHE_MODE_REUSE
	)
	if request_error != OK:
		var failed_path := _pending_scene_path
		_pending_scene_path = ""
		set_process(false)
		push_error("Could not start loading scene '%s' (error %d)." % [failed_path, request_error])
		_finish_scene_change_failed(request_error)
		return
	set_process(true)


func _show_loading_screen() -> void:
	if _loading_progress != null:
		_loading_progress.value = 0.0
	if _loading_label != null:
		_loading_label.text = "LOADING 0%"
	if _loading_root != null:
		_loading_root.visible = true


func _hide_loading_screen() -> void:
	if _loading_root != null:
		_loading_root.visible = false


func _hide_loading_screen_after_scene_ready() -> void:
	await get_tree().process_frame
	_hide_loading_screen()


func _finish_scene_change_failed(error_code: int) -> void:
	changing_scene = false
	_hide_loading_screen()
	scene_change_failed.emit(_last_requested_path, error_code)


func _build_loading_screen() -> void:
	_loading_root = Control.new()
	_loading_root.name = "LoadingScreen"
	_loading_root.set_anchors_preset(Control.PRESET_FULL_RECT)
	_loading_root.visible = false
	_loading_root.mouse_filter = Control.MOUSE_FILTER_STOP
	_loading_root.process_mode = Node.PROCESS_MODE_ALWAYS

	var background := ColorRect.new()
	background.name = "Background"
	background.color = Color(0.05, 0.07, 0.06)
	background.set_anchors_preset(Control.PRESET_FULL_RECT)
	background.mouse_filter = Control.MOUSE_FILTER_STOP
	_loading_root.add_child(background)

	_loading_label = Label.new()
	_loading_label.name = "Title"
	_loading_label.text = "LOADING"
	_loading_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_loading_label.set_anchors_preset(Control.PRESET_CENTER_TOP)
	_loading_label.position = Vector2(-100, 300)
	_loading_label.size = Vector2(200, 40)
	_loading_root.add_child(_loading_label)

	_loading_progress = ProgressBar.new()
	_loading_progress.name = "Progress"
	_loading_progress.min_value = 0.0
	_loading_progress.max_value = 100.0
	_loading_progress.show_percentage = false
	_loading_progress.set_anchors_preset(Control.PRESET_CENTER)
	_loading_progress.position = Vector2(-200, 20)
	_loading_progress.size = Vector2(400, 14)
	_loading_root.add_child(_loading_progress)

	add_child(_loading_root)
