extends Control


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		_return_to_menu()


func _on_back_pressed() -> void:
	_return_to_menu()


func _return_to_menu() -> void:
	AudioManager.play_click()
	SceneManager.go_to_main_menu()
