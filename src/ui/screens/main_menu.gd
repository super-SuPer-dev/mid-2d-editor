extends Control


func _navigate(action: Callable) -> void:
	AudioManager.play_click()
	action.call()


func _on_start_pressed() -> void:
	_navigate(SceneManager.go_to_character_select)


func _on_field_map_pressed() -> void:
	_navigate(SceneManager.go_to_level_select)


func _on_upgrades_pressed() -> void:
	_navigate(SceneManager.go_to_upgrades)


func _on_settings_pressed() -> void:
	_navigate(SceneManager.go_to_settings)


func _on_exit_pressed() -> void:
	AudioManager.play_click()
	get_tree().quit()
