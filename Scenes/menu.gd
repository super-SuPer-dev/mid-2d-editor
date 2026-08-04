extends Control

func _on_new_game_btn_pressed() -> void:
	AudioManager.click_sfx.play()
	SceneManager.load_scene_without_transition("res://Scenes/test.tscn")


func _on_exit_btn_pressed() -> void:
	AudioManager.click_sfx.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()
