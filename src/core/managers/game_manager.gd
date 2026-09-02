extends Node

signal god_mode_changed(enabled: bool)
signal debug_mode_changed(enabled: bool)
signal player_movement_changed(enabled: bool)
signal currency_changed(current_amount: int, change: int)
signal player_data_changed
signal run_started(level_id: String)
signal objective_changed(defeated: int, required: int)
signal mission_phase_changed(phase: StringName)
signal boss_requested(boss_id: String, boss_name_key: String)
signal boss_health_changed(current_health: int, maximum_health: int)
signal boss_phase_changed(current_phase: int, phase_count: int)
signal run_finished(won: bool)

const PHASE_CLEAR_THREATS := &"CLEAR_THREATS"
const PHASE_BOSS_ACTIVE := &"BOSS_ACTIVE"
const PHASE_EXTRACTION := &"EXTRACTION"

var is_god_mode: bool = false
var is_debug_mode: bool = false
var can_player_move: bool = true
var coin: int = 0
var selected_character_id: String = CharacterCatalog.DEFAULT_CHARACTER
var current_level_id: String = "level_01"
var defeated_enemies: int = 0
var required_enemies: int = 0
var run_active: bool = false
var mission_phase: StringName = PHASE_CLEAR_THREATS
var current_boss_id: String = ""
var current_boss_name_key: String = ""
var current_boss_phase: int = 1
var current_boss_phase_count: int = 1
var runtime_texture_cache: Dictionary = {}


func load_runtime_texture(path: String) -> Texture2D:
	if runtime_texture_cache.has(path):
		return runtime_texture_cache[path] as Texture2D
	# CACHE_MODE_REUSE shares textures with Godot's global resource cache so the
	# first spawn of each enemy type does not load a second copy of every set.
	var texture := ResourceLoader.load(path, "Texture2D", ResourceLoader.CACHE_MODE_REUSE) as Texture2D
	if texture != null:
		runtime_texture_cache[path] = texture
	else:
		push_error("Runtime texture failed to load: %s" % path)
	return texture


func clear_runtime_texture_cache() -> void:
	runtime_texture_cache.clear()


func select_character(character_id: String) -> void:
	selected_character_id = CharacterCatalog.resolve_character_id(character_id)
	player_data_changed.emit()


func start_level(level_id: String) -> void:
	current_level_id = level_id
	var level_data := LevelCatalog.get_level(level_id)
	required_enemies = int(level_data.get("threat_quota", level_data.get("required_kills", 0)))
	defeated_enemies = 0
	current_boss_id = str(level_data.get("boss_id", ""))
	current_boss_name_key = str(level_data.get("boss_name_key", ""))
	current_boss_phase = 1
	current_boss_phase_count = 1
	mission_phase = PHASE_CLEAR_THREATS
	coin = 0
	run_active = true
	set_player_movement_enabled(true)
	currency_changed.emit(coin, 0)
	objective_changed.emit(defeated_enemies, required_enemies)
	mission_phase_changed.emit(mission_phase)
	run_started.emit(level_id)


func register_enemy_defeated() -> void:
	if not run_active or mission_phase != PHASE_CLEAR_THREATS:
		return
	defeated_enemies += 1
	objective_changed.emit(defeated_enemies, required_enemies)
	if is_objective_complete():
		_start_boss_phase()


func _start_boss_phase() -> void:
	if mission_phase != PHASE_CLEAR_THREATS:
		return
	mission_phase = PHASE_BOSS_ACTIVE
	mission_phase_changed.emit(mission_phase)
	boss_requested.emit(current_boss_id, current_boss_name_key)


func update_boss_health(current_health: int, maximum_health: int) -> void:
	if mission_phase == PHASE_BOSS_ACTIVE:
		boss_health_changed.emit(current_health, maximum_health)


func update_boss_phase(current_phase: int, phase_count: int) -> void:
	current_boss_phase = maxi(current_phase, 1)
	current_boss_phase_count = maxi(phase_count, 1)
	if mission_phase == PHASE_BOSS_ACTIVE:
		boss_phase_changed.emit(current_boss_phase, current_boss_phase_count)


func register_boss_defeated() -> void:
	if mission_phase != PHASE_BOSS_ACTIVE:
		return
	mission_phase = PHASE_EXTRACTION
	mission_phase_changed.emit(mission_phase)


func is_objective_complete() -> bool:
	return defeated_enemies >= required_enemies


func can_extract() -> bool:
	return mission_phase == PHASE_EXTRACTION


func finish_run(won: bool) -> void:
	if not run_active:
		return
	run_active = false
	set_player_movement_enabled(false)
	run_finished.emit(won)


func add_coin(amount: int) -> bool:
	if amount <= 0:
		return false
	coin += amount
	currency_changed.emit(coin, amount)
	player_data_changed.emit()
	return true


func remove_coin(amount: int) -> bool:
	if amount <= 0 or amount > coin:
		return false
	coin -= amount
	currency_changed.emit(coin, -amount)
	player_data_changed.emit()
	return true


func set_coin(amount: int) -> void:
	var old_amount := coin
	coin = maxi(amount, 0)
	currency_changed.emit(coin, coin - old_amount)
	player_data_changed.emit()


func set_player_movement_enabled(enabled: bool) -> void:
	can_player_move = enabled
	player_movement_changed.emit(enabled)


func toggle_disable_player_movement(mode: Variant = null) -> void:
	set_player_movement_enabled(not can_player_move if mode == null else bool(mode))


func toggle_god_mode(enabled: Variant = null) -> void:
	is_god_mode = not is_god_mode if enabled == null else bool(enabled)
	god_mode_changed.emit(is_god_mode)


func toggle_debug_mode(enabled: Variant = null) -> void:
	is_debug_mode = not is_debug_mode if enabled == null else bool(enabled)
	debug_mode_changed.emit(is_debug_mode)


func reset_run() -> void:
	coin = 0
	defeated_enemies = 0
	run_active = false
	mission_phase = PHASE_CLEAR_THREATS
	current_boss_id = ""
	current_boss_name_key = ""
	current_boss_phase = 1
	current_boss_phase_count = 1
	set_player_movement_enabled(true)


func debug(message: String) -> void:
	if is_debug_mode:
		print(message)
