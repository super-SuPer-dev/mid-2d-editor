extends Node

@onready var click_sfx: AudioStreamPlayer = $ClickSfx
var muted_for_tests: bool = false

const GENERATED_SFX: Dictionary = {
	&"cutter_swing": preload("res://assets/audio/generated/cutter_swing.wav"),
	&"player_hurt": preload("res://assets/audio/generated/player_hurt.wav"),
	&"enemy_hit": preload("res://assets/audio/generated/enemy_hit.wav"),
	&"pickup_sample": preload("res://assets/audio/generated/pickup_sample.wav"),
	&"dash": preload("res://assets/audio/generated/dash.wav"),
	&"boss_defeat": preload("res://assets/audio/generated/boss_defeat.wav"),
	&"radio_beep": preload("res://assets/audio/generated/radio_beep.wav"),
}


func play_click() -> void:
	play_sfx(1.0, -5.0)


func play_ui_confirm() -> void:
	play_click()


func play_sfx(pitch: float = 1.0, volume_db: float = -8.0) -> void:
	play_named_sfx(&"", pitch, volume_db)


func play_named_sfx(sound_id: StringName, pitch: float = 1.0, volume_db: float = -8.0) -> void:
	var stream := GENERATED_SFX.get(sound_id, click_sfx.stream) as AudioStream
	if muted_for_tests or stream == null:
		return
	var player := AudioStreamPlayer.new()
	player.stream = stream
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
