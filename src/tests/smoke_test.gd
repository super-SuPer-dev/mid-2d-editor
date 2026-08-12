extends Node

const MAIN_ENTRANCE := preload("res://Scenes/main.tscn")
const GAME_LEVELS := {
	"level_01": preload("res://Scenes/levels/level_01.tscn"),
	"level_02": preload("res://Scenes/levels/level_02.tscn"),
	"level_03": preload("res://Scenes/levels/level_03.tscn"),
}
const UI_SCENES := [
	preload("res://Scenes/ui/main_menu.tscn"),
	preload("res://Scenes/ui/character_select.tscn"),
	preload("res://Scenes/ui/level_select.tscn"),
	preload("res://Scenes/ui/settings.tscn"),
	preload("res://Scenes/ui/upgrades.tscn"),
]

var failures: Array[String] = []


func _ready() -> void:
	await get_tree().process_frame
	AudioManager.muted_for_tests = true
	_validate_catalogs()
	await _validate_ui_scenes()
	await _validate_levels()
	AudioManager.stop_all_sfx()
	AudioManager.muted_for_tests = false
	await get_tree().process_frame
	await get_tree().process_frame
	if failures.is_empty():
		print("SMOKE TEST PASS: all screens and levels instantiated successfully.")
		get_tree().quit(0)
	else:
		for failure in failures:
			push_error(failure)
		get_tree().quit(1)


func _validate_catalogs() -> void:
	_check(CharacterCatalog.get_ids().size() == 4, "Expected four playable characters.")
	_check(LevelCatalog.LEVEL_ORDER.size() == 3, "Expected three campaign levels.")
	for character_id in CharacterCatalog.get_ids():
		var data := CharacterCatalog.get_character(character_id)
		_check(int(data["max_health"]) > 0, "%s has invalid health." % character_id)
		_check(float(data["move_speed"]) > 0.0, "%s has invalid speed." % character_id)
	for level_id in LevelCatalog.LEVEL_ORDER:
		var data := LevelCatalog.get_level(level_id)
		_check(int(data["required_kills"]) > 0, "%s has an invalid objective." % level_id)


func _validate_ui_scenes() -> void:
	var entrance: Node = MAIN_ENTRANCE.instantiate()
	add_child(entrance)
	await get_tree().process_frame
	_check(entrance.has_node("MainMenu"), "Main entrance is missing its menu instance.")
	entrance.queue_free()
	await get_tree().process_frame
	for packed_scene: PackedScene in UI_SCENES:
		var screen: Node = packed_scene.instantiate()
		add_child(screen)
		await get_tree().process_frame
		_check(screen.get_child_count() > 0, "%s did not construct its UI." % packed_scene.resource_path)
		screen.queue_free()
		await get_tree().process_frame


func _validate_levels() -> void:
	for level_id in LevelCatalog.LEVEL_ORDER:
		GameManager.start_level(level_id)
		var level: Node = GAME_LEVELS[level_id].instantiate()
		add_child(level)
		await get_tree().process_frame
		await get_tree().process_frame
		var expected_enemies: int = int(LevelCatalog.get_level(level_id)["required_kills"])
		var enemy_count := get_tree().get_nodes_in_group("Enemy").size()
		var player_count := get_tree().get_nodes_in_group("Player").size()
		_check(enemy_count == expected_enemies, "%s spawned %d/%d enemies." % [level_id, enemy_count, expected_enemies])
		_check(player_count == 1, "%s did not spawn exactly one player." % level_id)
		_check(level.get_node("WorldGeometry").get_child_count() > 0, "%s has no authored world geometry." % level_id)
		var player := get_tree().get_first_node_in_group("Player") as PlayerController
		var health_before := player.health.current_health
		player.take_damage(1, Vector2.LEFT)
		_check(player.health.current_health == health_before - 1, "%s player damage did not apply." % level_id)
		for enemy: EnemyController in get_tree().get_nodes_in_group("Enemy"):
			enemy.take_damage(999, Vector2.RIGHT)
		await get_tree().process_frame
		await get_tree().process_frame
		_check(GameManager.is_objective_complete(), "%s combat objective did not complete." % level_id)
		var portal := level.get_node_or_null("Portal") as ExitPortal
		_check(portal != null and portal.active, "%s exit portal did not activate." % level_id)
		level.queue_free()
		await get_tree().process_frame
		await get_tree().process_frame
		await get_tree().process_frame
	GameManager.reset_run()


func _check(condition: bool, message: String) -> void:
	if not condition:
		failures.append(message)
