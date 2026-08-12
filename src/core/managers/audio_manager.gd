extends Node

@onready var click_sfx: AudioStreamPlayer = $ClickSfx
var muted_for_tests: bool = false


func play_click() -> void:
	play_sfx(1.0, -5.0)


func play_ui_confirm() -> void:
	play_click()


func play_sfx(pitch: float = 1.0, volume_db: float = -8.0) -> void:
	if muted_for_tests or click_sfx.stream == null:
		return
	var player := AudioStreamPlayer.new()
	player.stream = click_sfx.stream
	player.pitch_scale = pitch
	player.volume_db = volume_db
	player.finished.connect(player.queue_free)
	add_child(player)
	player.play()


func stop_all_sfx() -> void:
	for child in get_children():
		if child != click_sfx and child is AudioStreamPlayer:
			child.stop()
			child.queue_free()
