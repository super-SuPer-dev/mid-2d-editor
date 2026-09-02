extends Control

@onready var volume: HSlider = $Center/Panel/Content/VolumeRow/Volume
@onready var volume_value: Label = $Center/Panel/Content/VolumeRow/Value
@onready var fullscreen: CheckButton = $Center/Panel/Content/ToggleRow/Fullscreen
@onready var immediate_dialogue: CheckButton = $Center/Panel/Content/ToggleRow/ImmediateDialogue
@onready var reduced_flashing: CheckButton = $Center/Panel/Content/ToggleRow/ReducedFlashing
@onready var language: OptionButton = $Center/Panel/Content/LanguageRow/Language
@onready var reset_button: Button = $Center/Panel/Content/ResetCampaign

var reset_armed := false


func _ready() -> void:
	language.clear()
	for locale in LocalizationManager.SUPPORTED_LANGUAGES:
		language.add_item(LocalizationManager.text("LANGUAGE_ENGLISH" if locale == "en" else "LANGUAGE_THAI"))
		language.set_item_metadata(language.item_count - 1, locale)
	volume.set_value_no_signal(float(SaveManager.profile["settings"]["master_volume"]))
	fullscreen.set_pressed_no_signal(bool(SaveManager.profile["settings"]["fullscreen"]))
	immediate_dialogue.set_pressed_no_signal(bool(SaveManager.profile["settings"].get("immediate_dialogue_text", false)))
	reduced_flashing.set_pressed_no_signal(bool(SaveManager.profile["settings"].get("reduced_flashing", false)))
	_select_current_language()
	LocalizationManager.language_changed.connect(_refresh_text)
	_refresh_text(LocalizationManager.current_language)
	_update_volume_label(volume.value)


func _select_current_language() -> void:
	for index in language.item_count:
		if str(language.get_item_metadata(index)) == LocalizationManager.current_language:
			language.select(index)
			return


func _refresh_text(_locale: String) -> void:
	$Center/Panel/Content/Title.text = LocalizationManager.text("SETTINGS_TITLE")
	$Center/Panel/Content/VolumeRow/Caption.text = LocalizationManager.text("SETTINGS_MASTER_VOLUME")
	$Center/Panel/Content/LanguageRow/Caption.text = LocalizationManager.text("SETTINGS_LANGUAGE")
	fullscreen.text = LocalizationManager.text("SETTINGS_FULLSCREEN")
	immediate_dialogue.text = LocalizationManager.text("SETTINGS_IMMEDIATE_DIALOGUE")
	reduced_flashing.text = LocalizationManager.text("SETTINGS_REDUCED_FLASHING")
	reset_button.text = LocalizationManager.text("UI_CONFIRM_RESET" if reset_armed else "SETTINGS_RESET")
	$Center/Panel/Content/Back.text = LocalizationManager.text("SETTINGS_SAVE_BACK")
	for index in language.item_count:
		var locale := str(language.get_item_metadata(index))
		language.set_item_text(index, LocalizationManager.text("LANGUAGE_ENGLISH" if locale == "en" else "LANGUAGE_THAI"))
	_select_current_language()


func _update_volume_label(value: float) -> void:
	volume_value.text = "%d%%" % int(value * 100.0)


func _on_volume_changed(value: float) -> void:
	_update_volume_label(value)
	SaveManager.set_master_volume(value)


func _on_fullscreen_toggled(enabled: bool) -> void:
	SaveManager.set_fullscreen(enabled)


func _on_immediate_dialogue_toggled(enabled: bool) -> void:
	SaveManager.set_immediate_dialogue_text(enabled)


func _on_reduced_flashing_toggled(enabled: bool) -> void:
	SaveManager.set_reduced_flashing(enabled)


func _on_language_selected(index: int) -> void:
	SaveManager.set_language(str(language.get_item_metadata(index)))


func _on_reset_pressed() -> void:
	AudioManager.play_click()
	if not reset_armed:
		reset_armed = true
		reset_button.text = LocalizationManager.text("UI_CONFIRM_RESET")
		return
	SaveManager.erase_progress()
	SceneManager.go_to_main_menu()


func _on_back_pressed() -> void:
	AudioManager.play_click()
	SceneManager.go_to_main_menu()
