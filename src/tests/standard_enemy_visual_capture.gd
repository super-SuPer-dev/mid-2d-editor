extends Node

const LEVEL_ONE := preload("res://Scenes/levels/level_01.tscn")
const OUTPUT_PATH := "res://validation/screenshots/gate2_standard_enemies.png"
const WORLD_OUTPUT_PATH := "res://validation/screenshots/gate2_grassland_world.png"


func _ready() -> void:
	AudioManager.muted_for_tests = true
	GameManager.select_character("tonkla")
	GameManager.start_level("level_01")
	var level := LEVEL_ONE.instantiate()
	add_child(level)
	await get_tree().process_frame
	await get_tree().process_frame
	var dialogue := level.get_node("HUD/Root/DialogueOverlay") as DialogueOverlay
	if dialogue.visible:
		dialogue._on_skip_pressed()
	dialogue.visible = false
	dialogue.pending_sequences.clear()
	dialogue.radio_timer.stop()
	get_tree().paused = false
	# Place the review pair on the actual collision surfaces. Authored spawn
	# positions begin above platforms so live enemies can settle under gravity.
	level.get_node("Enemies/Thornling02").global_position = Vector2(900, 431)
	level.get_node("Enemies/Spitter").global_position = Vector2(1260, 541)
	for enemy: EnemyController in get_tree().get_nodes_in_group("Enemy"):
		enemy.combat_active = false
		enemy.process_mode = Node.PROCESS_MODE_DISABLED
		enemy.visible = true
	var player := get_tree().get_first_node_in_group("Player") as PlayerController
	player.global_position = Vector2(1040, 560)
	player.get_node("Camera2D").position_smoothing_enabled = false
	for frame in 30:
		await get_tree().process_frame
	var enemy_result := _save_capture(OUTPUT_PATH)
	player.global_position = Vector2(1370, 560)
	for frame in 10:
		await get_tree().process_frame
	var world_result := _save_capture(WORLD_OUTPUT_PATH)
	if enemy_result == OK and world_result == OK:
		print("STANDARD ENEMY CAPTURE PASS: %s" % OUTPUT_PATH)
		print("GRASSLAND WORLD CAPTURE PASS: %s" % WORLD_OUTPUT_PATH)
		get_tree().quit(0)
	else:
		push_error("Visual capture failed: enemies=%d world=%d" % [enemy_result, world_result])
		get_tree().quit(1)


func _save_capture(output_path: String) -> Error:
	var absolute_output := ProjectSettings.globalize_path(output_path)
	DirAccess.make_dir_recursive_absolute(absolute_output.get_base_dir())
	return get_viewport().get_texture().get_image().save_png(absolute_output)
