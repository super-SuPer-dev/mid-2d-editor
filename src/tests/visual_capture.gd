extends Node

const LEVEL_ONE := preload("res://Scenes/levels/level_01.tscn")
const OUTPUT_PATH := "res://validation/screenshots/gate2_thorn_matriarch.png"


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
	get_tree().paused = false
	for enemy: EnemyController in get_tree().get_nodes_in_group("Enemy"):
		if not enemy.is_boss:
			enemy.take_damage(999, Vector2.RIGHT)
	await get_tree().process_frame
	await get_tree().process_frame
	dialogue.visible = false
	dialogue.pending_sequences.clear()
	dialogue.radio_timer.stop()
	get_tree().paused = false
	var player := get_tree().get_first_node_in_group("Player") as PlayerController
	player.global_position = Vector2(2100, 560)
	player.get_node("Camera2D").position_smoothing_enabled = false
	for frame in 30:
		await get_tree().process_frame
	var absolute_output := ProjectSettings.globalize_path(OUTPUT_PATH)
	DirAccess.make_dir_recursive_absolute(absolute_output.get_base_dir())
	var result := get_viewport().get_texture().get_image().save_png(absolute_output)
	if result == OK:
		print("VISUAL CAPTURE PASS: %s" % OUTPUT_PATH)
		get_tree().quit(0)
	else:
		push_error("Could not save visual capture: %d" % result)
		get_tree().quit(1)
