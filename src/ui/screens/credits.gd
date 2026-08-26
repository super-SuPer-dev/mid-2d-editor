extends Control


func _ready() -> void:
	LocalizationManager.language_changed.connect(_refresh_text)
	_refresh_text(LocalizationManager.current_language)


func _refresh_text(_locale: String) -> void:
	$Center/Panel/Margin/Content/Title.text = LocalizationManager.text("CREDITS_TITLE")
	$Center/Panel/Margin/Content/ThankYou.text = LocalizationManager.text("CREDITS_THANKS")
	$Center/Panel/Margin/Content/Back.text = LocalizationManager.text("UI_BACK_MENU")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		_return_to_menu()


func _on_back_pressed() -> void:
	_return_to_menu()


func _return_to_menu() -> void:
	AudioManager.play_click()
	SceneManager.go_to_main_menu()
