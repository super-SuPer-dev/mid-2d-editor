extends Node

signal god_mode_changed(enabled: bool)
signal debug_mode_changed(enabled: bool)
signal player_movement_changed(enabled: bool)
signal currency_changed(current_amount: int, change: int)
signal player_data_changed
signal run_started(level_id: String)
signal objective_changed(defeated: int, required: int)
signal run_finished(won: bool)

var is_god_mode: bool = false
var is_debug_mode: bool = false
var can_player_move: bool = true
var coin: int = 0
var selected_character_id: String = CharacterCatalog.DEFAULT_CHARACTER
var current_level_id: String = "level_01"
var defeated_enemies: int = 0
var required_enemies: int = 0
var run_active: bool = false


func select_character(character_id: String) -> void:
	selected_character_id = character_id if CharacterCatalog.CHARACTERS.has(character_id) else CharacterCatalog.DEFAULT_CHARACTER
	player_data_changed.emit()


func start_level(level_id: String) -> void:
	current_level_id = level_id
	var level_data := LevelCatalog.get_level(level_id)
	required_enemies = int(level_data.get("required_kills", 0))
	defeated_enemies = 0
	coin = 0
	run_active = true
	set_player_movement_enabled(true)
	currency_changed.emit(coin, 0)
	objective_changed.emit(defeated_enemies, required_enemies)
	run_started.emit(level_id)


func register_enemy_defeated() -> void:
	defeated_enemies += 1
	objective_changed.emit(defeated_enemies, required_enemies)


func is_objective_complete() -> bool:
	return defeated_enemies >= required_enemies


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
	set_player_movement_enabled(true)


func debug(message: String) -> void:
	if is_debug_mode:
		print(message)
