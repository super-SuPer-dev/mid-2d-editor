extends Control


func _ready() -> void:
	AudioManager.play_music(&"main_theme")
	LocalizationManager.language_changed.connect(_refresh_text)
	_refresh_text(LocalizationManager.current_language)


func _refresh_text(_locale: String) -> void:
	$Center/Content/Subtitle.text = LocalizationManager.text("MENU_SUBTITLE")
	$Center/Content/StartMission.text = LocalizationManager.text("MENU_START_MISSION")
	$Center/Content/FieldMap.text = LocalizationManager.text("MENU_FIELD_MAP")
	$Center/Content/Footer/Settings.text = LocalizationManager.text("MENU_SETTINGS")
	$Center/Content/Footer/Credits.text = LocalizationManager.text("MENU_CREDITS")
	$Center/Content/Footer/Exit.text = LocalizationManager.text("MENU_EXIT")


func _navigate(action: Callable) -> void:
	AudioManager.play_click()
	action.call()


func _on_start_pressed() -> void:
	_navigate(SceneManager.go_to_character_select)


func _on_field_map_pressed() -> void:
	_navigate(SceneManager.go_to_level_select)


func _on_settings_pressed() -> void:
	_navigate(SceneManager.go_to_settings)


func _on_credits_pressed() -> void:
	_navigate(SceneManager.go_to_credits)


func _on_exit_pressed() -> void:
	AudioManager.play_click()
	get_tree().quit()
