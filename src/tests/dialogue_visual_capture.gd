extends Node

const LEVEL_ONE := preload("res://scenes/levels/level_01.tscn")
const OUTPUT_PATH := "res://validation/screenshots/gate2_dialogue_anan.png"


func _ready() -> void:
	AudioManager.muted_for_tests = true
	SaveManager.profile["seen_dialogue_sequences"] = []
	GameManager.select_character("tonkla")
	GameManager.start_level("level_01")
	var level := LEVEL_ONE.instantiate()
	add_child(level)
	for frame in 8:
		await get_tree().process_frame
	var dialogue := level.get_node("HUD/Root/DialogueOverlay") as DialogueOverlay
	if not dialogue.visible:
		push_error("Dialogue overlay was not visible for capture.")
		get_tree().quit(1)
		return
	var absolute_output := ProjectSettings.globalize_path(OUTPUT_PATH)
	DirAccess.make_dir_recursive_absolute(absolute_output.get_base_dir())
	var result := get_viewport().get_texture().get_image().save_png(absolute_output)
	if result == OK:
		print("DIALOGUE CAPTURE PASS: %s" % OUTPUT_PATH)
		get_tree().quit(0)
	else:
		push_error("Could not save dialogue capture: %d" % result)
		get_tree().quit(1)
