extends Control

@onready var volume: HSlider = $Center/Panel/Content/VolumeRow/Volume
@onready var volume_value: Label = $Center/Panel/Content/VolumeRow/Value
@onready var fullscreen: CheckButton = $Center/Panel/Content/Fullscreen
@onready var reset_button: Button = $Center/Panel/Content/ResetCampaign

var reset_armed := false


func _ready() -> void:
	volume.set_value_no_signal(float(SaveManager.profile["settings"]["master_volume"]))
	fullscreen.set_pressed_no_signal(bool(SaveManager.profile["settings"]["fullscreen"]))
	_update_volume_label(volume.value)


func _update_volume_label(value: float) -> void:
	volume_value.text = "%d%%" % int(value * 100.0)


func _on_volume_changed(value: float) -> void:
	_update_volume_label(value)
	SaveManager.set_master_volume(value)


func _on_fullscreen_toggled(enabled: bool) -> void:
	SaveManager.set_fullscreen(enabled)


func _on_reset_pressed() -> void:
	AudioManager.play_click()
	if not reset_armed:
		reset_armed = true
		reset_button.text = "CONFIRM RESET"
		return
	SaveManager.erase_progress()
	SceneManager.go_to_main_menu()


func _on_back_pressed() -> void:
	AudioManager.play_click()
	SceneManager.go_to_main_menu()
