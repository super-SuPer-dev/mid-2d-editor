extends Node

## Gate 6 scene-transition soak harness.
##
## This intentionally runs without a visible game window so it can be used in
## CI and on release machines. It mounts every production UI and level scene,
## lets each scene process, exercises the mission state machine, then frees it
## before the next mount. Pass --soak-seconds=N after the Godot scene path to
## choose the duration; the default is the release requirement of 1800 seconds.

const UI_SCENE_PATHS: Array[String] = [
	"res://scenes/ui/main_menu.tscn",
	"res://scenes/ui/character_select.tscn",
	"res://scenes/ui/level_select.tscn",
	"res://scenes/ui/settings.tscn",
	"res://scenes/ui/credits.tscn",
	"res://scenes/ui/character_upgrades.tscn",
	"res://scenes/ui/upgrades.tscn",
]
const LEVEL_SCENE_PATHS := {
	"level_01": "res://scenes/levels/level_01.tscn",
	"level_02": "res://scenes/levels/level_02.tscn",
	"level_03": "res://scenes/levels/level_03.tscn",
	"level_04": "res://scenes/levels/level_04.tscn",
	"level_05": "res://scenes/levels/level_05.tscn",
}

const DEFAULT_SOAK_SECONDS := 1800.0
const MAX_ALLOWED_NODE_GROWTH := 12

var failures: Array[String] = []
var soak_seconds := DEFAULT_SOAK_SECONDS
var started_msec := 0
var cycle_count := 0
var mounted_scene_count := 0
var baseline_node_count := -1
var peak_node_count := 0
var peak_static_bytes := 0
var peak_sfx_count := 0


func _ready() -> void:
	soak_seconds = _read_duration()
	SaveManager.begin_test_session()
	AudioManager.muted_for_tests = true
	baseline_node_count = get_tree().get_node_count()
	started_msec = Time.get_ticks_msec()

	while _elapsed_seconds() < soak_seconds:
		await _run_ui_cycle()
		await _run_level_cycle()
		cycle_count += 1
		await get_tree().process_frame

	_check(get_tree().get_node_count() <= baseline_node_count + MAX_ALLOWED_NODE_GROWTH,
		"Scene-transition soak leaked nodes: baseline %d, final %d." % [baseline_node_count, get_tree().get_node_count()])
	_check(AudioManager.get_active_sfx_count() <= AudioManager.SFX_POOL_SIZE,
		"Scene-transition soak exceeded the bounded SFX pool: %d/%d." % [peak_sfx_count, AudioManager.SFX_POOL_SIZE])

	AudioManager.stop_all_sfx()
	AudioManager.muted_for_tests = false
	SaveManager.end_test_session()
	if failures.is_empty():
		print("SOAK TEST PASS: %.1f seconds, %d cycles, %d scene mounts, peak nodes %d, peak static %.1f MB, peak SFX %d." % [
			_elapsed_seconds(), cycle_count, mounted_scene_count, peak_node_count,
			float(peak_static_bytes) / 1048576.0, peak_sfx_count])
		get_tree().quit(0)
	else:
		for failure in failures:
			push_error(failure)
		print("SOAK TEST FAIL: %.1f seconds, %d cycles, %d scene mounts." % [_elapsed_seconds(), cycle_count, mounted_scene_count])
		get_tree().quit(1)


func _run_ui_cycle() -> void:
	SaveManager.set_language("th")
	SaveManager.set_immediate_dialogue_text(true)
	for scene_path: String in UI_SCENE_PATHS:
		if _time_exhausted():
			return
		await _mount_and_release(scene_path, "ui")
	SaveManager.set_immediate_dialogue_text(false)
	SaveManager.set_language("en")


func _run_level_cycle() -> void:
	for level_id: String in LEVEL_SCENE_PATHS:
		if _time_exhausted():
			return
		GameManager.reset_run()
		GameManager.start_level(level_id)
		await _mount_and_release(LEVEL_SCENE_PATHS[level_id], level_id)


func _mount_and_release(scene_path: String, label: String) -> void:
	var packed_scene := ResourceLoader.load(scene_path, "PackedScene", ResourceLoader.CACHE_MODE_IGNORE_DEEP) as PackedScene
	if packed_scene == null:
		_check(false, "Could not load %s scene." % label)
		return
	var instance := packed_scene.instantiate()
	if instance == null:
		_check(false, "Could not instantiate %s scene." % label)
		return
	add_child(instance)
	mounted_scene_count += 1
	await get_tree().process_frame
	await get_tree().physics_frame
	_sample_metrics()

	if label.begins_with("level_"):
		_exercise_mission_phases()
		await get_tree().process_frame
		_sample_metrics()

	instance.queue_free()
	await get_tree().process_frame
	await get_tree().process_frame
	_sample_metrics()
	instance = null
	packed_scene = null
	GameManager.clear_runtime_texture_cache()


func _exercise_mission_phases() -> void:
	var required := maxi(GameManager.required_enemies, 0)
	for _index in range(required):
		GameManager.register_enemy_defeated()
	if required > 0:
		_check(GameManager.mission_phase == GameManager.PHASE_BOSS_ACTIVE,
			"%s did not enter BOSS_ACTIVE during soak." % GameManager.current_level_id)
		GameManager.register_boss_defeated()
		_check(GameManager.mission_phase == GameManager.PHASE_EXTRACTION,
			"%s did not enter EXTRACTION during soak." % GameManager.current_level_id)
	GameManager.finish_run(true)


func _sample_metrics() -> void:
	peak_node_count = maxi(peak_node_count, get_tree().get_node_count())
	peak_sfx_count = maxi(peak_sfx_count, AudioManager.get_active_sfx_count())
	var static_bytes := int(Performance.get_monitor(Performance.MEMORY_STATIC))
	peak_static_bytes = maxi(peak_static_bytes, static_bytes)


func _read_duration() -> float:
	for argument: String in OS.get_cmdline_user_args():
		if argument.begins_with("--soak-seconds="):
			return maxf(float(argument.trim_prefix("--soak-seconds=")), 1.0)
	return DEFAULT_SOAK_SECONDS


func _elapsed_seconds() -> float:
	return float(Time.get_ticks_msec() - started_msec) / 1000.0


func _time_exhausted() -> bool:
	return _elapsed_seconds() >= soak_seconds


func _check(condition: bool, message: String) -> void:
	if not condition and message not in failures:
		failures.append(message)
