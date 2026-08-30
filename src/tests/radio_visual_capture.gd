extends Node

const LEVEL_ONE := preload("res://scenes/levels/level_01.tscn")
const OUTPUT_PATH := "res://validation/screenshots/gate2_radio_overlay.png"


func _ready() -> void:
	AudioManager.muted_for_tests = true
	SaveManager.profile["seen_dialogue_sequences"] = []
	GameManager.select_character("tonkla")
	GameManager.start_level("level_01")
	var level := LEVEL_ONE.instantiate()
	add_child(level)
	for _frame in 8:
		await get_tree().process_frame
	var dialogue := level.get_node("HUD/Root/DialogueOverlay") as DialogueOverlay
	if dialogue.visible:
		dialogue._on_skip_pressed()
	await get_tree().process_frame
	dialogue.show_sequence("level_01_radio_signal")
	for _frame in 8:
		await get_tree().process_frame
	if not dialogue.visible or dialogue.panel.anchor_left != 1.0:
		push_error("Compact radio overlay was not visible for capture.")
		get_tree().quit(1)
		return
	var absolute_output := ProjectSettings.globalize_path(OUTPUT_PATH)
	DirAccess.make_dir_recursive_absolute(absolute_output.get_base_dir())
	var result := get_viewport().get_texture().get_image().save_png(absolute_output)
	if result == OK:
		print("RADIO CAPTURE PASS: %s" % OUTPUT_PATH)
		get_tree().quit(0)
	else:
		push_error("Could not save radio capture: %d" % result)
		get_tree().quit(1)
