extends Node

const LEVEL_ONE := preload("res://Scenes/levels/level_01.tscn")
const PROJECTILE := preload("res://Scenes/gameplay/enemy_projectile.tscn")
const OUTPUT_PATH := "res://validation/screenshots/gate2_interaction_objects.png"


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
	for enemy: EnemyController in get_tree().get_nodes_in_group("Enemy"):
		enemy.visible = false
		enemy.process_mode = Node.PROCESS_MODE_DISABLED
	level.get_node("Pickups/Sample06").global_position = Vector2(2180, 520)
	var portal := level.get_node("Portal") as ExitPortal
	portal.set_active(true)
	var projectile := PROJECTILE.instantiate() as EnemyProjectile
	projectile.direction = Vector2.LEFT
	level.add_child(projectile)
	projectile.global_position = Vector2(2420, 540)
	projectile.process_mode = Node.PROCESS_MODE_DISABLED
	var player := get_tree().get_first_node_in_group("Player") as PlayerController
	player.global_position = Vector2(2300, 560)
	player.get_node("Camera2D").position_smoothing_enabled = false
	for frame in 30:
		await get_tree().process_frame
	var absolute_output := ProjectSettings.globalize_path(OUTPUT_PATH)
	DirAccess.make_dir_recursive_absolute(absolute_output.get_base_dir())
	var result := get_viewport().get_texture().get_image().save_png(absolute_output)
	if result == OK:
		print("INTERACTION OBJECT CAPTURE PASS: %s" % OUTPUT_PATH)
		get_tree().quit(0)
	else:
		push_error("Could not save interaction-object capture: %d" % result)
		get_tree().quit(1)
