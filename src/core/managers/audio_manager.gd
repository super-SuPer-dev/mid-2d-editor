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
	&"victory_stinger": preload("res://assets/audio/generated/victory_stinger.wav"),
	&"defeat_stinger": preload("res://assets/audio/generated/defeat_stinger.wav"),
}

const GENERATED_MUSIC: Dictionary = {
	&"menu_base": preload("res://assets/audio/generated/menu_base_loop.wav"),
	&"level_01": preload("res://assets/audio/generated/level_01_grassland_loop.wav"),
	&"level_02": preload("res://assets/audio/generated/level_02_forest_loop.wav"),
	&"level_03": preload("res://assets/audio/generated/level_03_capsule_loop.wav"),
	&"level_04": preload("res://assets/audio/generated/level_04_marsh_loop.wav"),
	&"level_05": preload("res://assets/audio/generated/level_05_nexus_loop.wav"),
	&"boss_organic": preload("res://assets/audio/generated/boss_organic_loop.wav"),
	&"boss_nexus": preload("res://assets/audio/generated/boss_nexus_loop.wav"),
}

var music_player: AudioStreamPlayer
var current_music_id: StringName = &""


func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	music_player.name = "MusicPlayer"
	add_child(music_player)


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


func play_music(music_id: StringName, volume_db: float = -16.0) -> void:
	if muted_for_tests or music_player == null or current_music_id == music_id:
		return
	var stream := GENERATED_MUSIC.get(music_id) as AudioStream
	if stream == null:
		return
	if stream is AudioStreamWAV:
		(stream as AudioStreamWAV).loop_mode = AudioStreamWAV.LOOP_FORWARD
	music_player.stream = stream
	music_player.volume_db = volume_db
	current_music_id = music_id
	music_player.play()


func stop_music() -> void:
	if music_player != null:
		music_player.stop()
	current_music_id = &""


func stop_all_sfx() -> void:
	for child in get_children():
		if child != click_sfx and child != music_player and child is AudioStreamPlayer:
			child.stop()
			child.queue_free()
