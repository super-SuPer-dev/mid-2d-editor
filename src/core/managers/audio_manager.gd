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
	&"enemy_attack": preload("res://assets/audio/generated/enemy_attack.wav"),
	&"boss_telegraph": preload("res://assets/audio/generated/boss_telegraph.wav"),
	&"boss_projectile": preload("res://assets/audio/generated/boss_projectile.wav"),
	&"boss_phase": preload("res://assets/audio/generated/boss_phase.wav"),
	&"hazard_warning": preload("res://assets/audio/generated/hazard_warning.wav"),
	&"hazard_hit": preload("res://assets/audio/generated/hazard_hit.wav"),
	&"portal_open": preload("res://assets/audio/generated/portal_open.wav"),
	&"portal_extract": preload("res://assets/audio/generated/portal_extract.wav"),
	&"upgrade_purchase": preload("res://assets/audio/generated/upgrade_purchase.wav"),
	&"dialogue_advance": preload("res://assets/audio/generated/dialogue_advance.wav"),
	&"menu_back": preload("res://assets/audio/generated/menu_back.wav"),
}

# Music is loaded on demand instead of preloaded: the five MP3 tracks total
# ~21 MB on disk and only one plays at a time, so preloading all of them at
# boot delays startup without any benefit.
const MUSIC_PATHS: Dictionary = {
	&"main_theme": "res://assets/audio/91476_Glorious_morning.mp3",
	&"menu_base": "res://assets/audio/generated/menu_base_loop.wav",
	&"level_01": "res://assets/audio/1_Team-Strike-Force-Theme.mp3",
	&"level_02": "res://assets/audio/2_Rose_at_Midnight.mp3",
	&"level_03": "res://assets/audio/3_-New-Dawn-.mp3",
	&"level_04": "res://assets/audio/4_Rose_At_Eclipse.mp3",
	&"level_05": "res://assets/audio/5_Rising-Sun.mp3",
	&"boss_organic": "res://assets/audio/generated/boss_organic_loop.wav",
	&"boss_nexus": "res://assets/audio/generated/boss_nexus_loop.wav",
}
const SFX_POOL_SIZE := 16

var music_player: AudioStreamPlayer
var current_music_id: StringName = &""
var _music_streams: Dictionary = {}
var sfx_pool: Array[AudioStreamPlayer] = []
var sfx_cursor := 0


func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	music_player.name = "MusicPlayer"
	add_child(music_player)
	for index in range(SFX_POOL_SIZE):
		var player := AudioStreamPlayer.new()
		player.name = "SfxPool%02d" % index
		add_child(player)
		sfx_pool.append(player)


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
	var player := _acquire_sfx_player()
	if player == null:
		return
	player.stream = stream
	player.pitch_scale = pitch
	player.volume_db = volume_db
	player.play()


func _acquire_sfx_player() -> AudioStreamPlayer:
	if sfx_pool.is_empty():
		return null
	for offset in range(sfx_pool.size()):
		var index := (sfx_cursor + offset) % sfx_pool.size()
		var candidate := sfx_pool[index]
		if not candidate.playing:
			sfx_cursor = (index + 1) % sfx_pool.size()
			return candidate
	var recycled := sfx_pool[sfx_cursor]
	sfx_cursor = (sfx_cursor + 1) % sfx_pool.size()
	recycled.stop()
	return recycled


func get_active_sfx_count() -> int:
	var active := 0
	for player in sfx_pool:
		if player.playing:
			active += 1
	return active


func play_music(music_id: StringName, volume_db: float = -16.0) -> void:
	if muted_for_tests or music_player == null:
		return
	# Do not restart a track that is already playing, but recover if playback
	# stopped unexpectedly (for example while transitioning into a boss fight).
	if current_music_id == music_id and music_player.playing:
		return
	var stream := _get_music_stream(music_id)
	if stream == null:
		return
	if stream is AudioStreamWAV:
		(stream as AudioStreamWAV).loop_mode = AudioStreamWAV.LOOP_FORWARD
	elif stream is AudioStreamMP3:
		(stream as AudioStreamMP3).loop = true
	music_player.stream = stream
	music_player.volume_db = volume_db
	current_music_id = music_id
	music_player.play()


func _get_music_stream(music_id: StringName) -> AudioStream:
	if _music_streams.has(music_id):
		return _music_streams[music_id] as AudioStream
	var path := MUSIC_PATHS.get(music_id, "") as String
	if path.is_empty() or not ResourceLoader.exists(path):
		return null
	var stream := ResourceLoader.load(path, "AudioStream") as AudioStream
	if stream != null:
		_music_streams[music_id] = stream
	return stream


func stop_music() -> void:
	if music_player != null:
		music_player.stop()
	current_music_id = &""


func stop_all_sfx() -> void:
	for player in sfx_pool:
		player.stop()
	for child in get_children():
		if child != click_sfx and child != music_player and child not in sfx_pool and child is AudioStreamPlayer:
			child.stop()
			child.queue_free()
