extends Node

signal god_mode_changed(mode: bool)
signal debug_mode_changed(mode: bool)
signal player_data_changed

var is_god_mode : bool = false
var is_debug_mode : bool = false

var coin = 0


func add_coin(value: int):
	if value == null: return
	if value <= 0: return
	coin += value
	debug("Coin Added: %d" % coin)
	player_data_changed.emit()


func remove_coin(value: int):
	if value == null: return
	if value <= 0: return
	if (coin - value) < 0: return
	coin -= value
	debug("Coin Removed: %d" % coin)
	player_data_changed.emit()


func toggle_god_mode(mode = null):
	if mode != null:
		is_god_mode = mode
	else:
		is_god_mode = !is_god_mode
		debug("God Mode: %s" % is_god_mode)
	god_mode_changed.emit(is_god_mode)


func toggle_debug_mode(mode = null):
	if mode != null:
		is_debug_mode = mode
	else:
		is_debug_mode = !is_debug_mode

	print("Debug Mode: %s" % is_debug_mode)
	debug_mode_changed.emit(is_debug_mode)


func debug(text: String):
	if is_debug_mode:
		print(text)
