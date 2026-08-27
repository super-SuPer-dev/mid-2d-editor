extends Node

const MAIN_ENTRANCE := preload("res://Scenes/main.tscn")
const GAME_LEVELS := {
	"level_01": preload("res://Scenes/levels/level_01.tscn"),
	"level_02": preload("res://Scenes/levels/level_02.tscn"),
	"level_03": preload("res://Scenes/levels/level_03.tscn"),
}
const REQUIRED_JUMP_ROUTES := {
	"level_01": [
		["Ground", "Platform01"], ["Platform01", "Platform02"],
		["Platform03", "Platform04"], ["Platform05", "Platform06"],
	],
	"level_02": [
		["GroundA", "Platform03"], ["GroundB", "Platform04"],
		["GroundB", "Platform01"], ["GroundC", "Platform05"],
		["GroundC", "Platform02"], ["GroundD", "Platform06"],
	],
	"level_03": [
		["Ground", "Platform01"], ["Platform01", "Platform02"],
		["Platform03", "Platform04"],
	],
}
const UI_SCENES := [
	preload("res://Scenes/ui/main_menu.tscn"),
	preload("res://Scenes/ui/character_select.tscn"),
	preload("res://Scenes/ui/level_select.tscn"),
	preload("res://Scenes/ui/settings.tscn"),
	preload("res://Scenes/ui/credits.tscn"),
	preload("res://Scenes/ui/character_upgrades.tscn"),
	preload("res://Scenes/ui/upgrades.tscn"),
]
const EXPECTED_THREAT_QUOTAS := {
	"level_01": 4,
	"level_02": 5,
	"level_03": 5,
	"level_04": 6,
	"level_05": 6,
}
const EXPECTED_PROJECTILE_CAPS := {
	"level_01": 18,
	"level_02": 32,
	"level_03": 36,
	"level_04": 48,
	"level_05": 64,
}

var failures: Array[String] = []


func _ready() -> void:
	await get_tree().process_frame
	AudioManager.muted_for_tests = true
	_validate_catalogs()
	_validate_localization_and_dialogue()
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
	_check(LevelCatalog.LEVEL_ORDER.size() == 5, "Expected five campaign levels in the catalog.")
	_check(SaveManager.get_mastery_rank() >= 0, "Operator mastery data is missing.")
	for character_id in CharacterCatalog.get_ids():
		_check(SaveManager.profile.get("operator_mastery", {}).has(character_id), "%s has no mastery profile." % character_id)
		var data := CharacterCatalog.get_character(character_id)
		_check(int(data["max_health"]) > 0, "%s has invalid health." % character_id)
		_check(float(data["move_speed"]) > 0.0, "%s has invalid speed." % character_id)
		var jump_height := pow(float(data["jump_velocity"]), 2.0) / (2.0 * PlayerController.GRAVITY)
		_check(jump_height >= 110.0, "%s cannot reach the campaign's required platform steps." % character_id)
	for level_id in LevelCatalog.LEVEL_ORDER:
		var data := LevelCatalog.get_level(level_id)
		_check(int(data["threat_quota"]) == EXPECTED_THREAT_QUOTAS[level_id], "%s has a GDD-inconsistent threat quota." % level_id)
		_check(not str(data.get("boss_id", "")).is_empty(), "%s has no boss ID." % level_id)
		_check(data.get("mission_phases", []) == ["CLEAR_THREATS", "BOSS_ACTIVE", "EXTRACTION"], "%s has an invalid phase contract." % level_id)
		_check(data.get("target_duration_seconds", Vector2i.ZERO) == Vector2i(300, 420), "%s does not target 5–7 minutes." % level_id)
		_check(data.get("encounter_segments", []) == LevelCatalog.MISSION_SEGMENTS, "%s has an invalid encounter-segment contract." % level_id)
		_check(not data.get("enemy_roster", []).is_empty(), "%s has no enemy roster." % level_id)
		_check(not str(data.get("tile_kit_id", "")).is_empty(), "%s has no tile kit ID." % level_id)
		_check(not str(data.get("background_kit_id", "")).is_empty(), "%s has no background kit ID." % level_id)
		var pattern_set_id := str(data.get("boss_pattern_set", ""))
		_check(not pattern_set_id.is_empty(), "%s has no boss pattern set." % level_id)
		_check(int(data.get("projectile_cap", 0)) == EXPECTED_PROJECTILE_CAPS[level_id], "%s has an invalid projectile cap." % level_id)
		var pattern_set := BossPatternCatalog.get_pattern_set(pattern_set_id)
		_check(int(pattern_set.get("max_projectiles", 0)) == int(data.get("projectile_cap", 0)), "%s pattern-set cap does not match its level cap." % level_id)
		for error in BossPatternCatalog.validate_pattern_set(pattern_set_id):
			_check(false, error)
	_check(CharacterCatalog.resolve_character_id("ranger") == "rin", "Legacy ranger ID did not migrate to rin.")
	_check(CharacterCatalog.resolve_character_id("villager") == "khem", "Legacy villager ID did not migrate to khem.")


func _validate_localization_and_dialogue() -> void:
	LocalizationManager.set_language("en")
	_check(LocalizationManager.text("MENU_START_MISSION") == "Start Mission", "English localization did not load.")
	LocalizationManager.set_language("th")
	_check(LocalizationManager.text("MENU_START_MISSION") == "เริ่มภารกิจ", "Thai localization did not load.")
	LocalizationManager.set_language("en")
	for sequence_id in DialogueCatalog.SEQUENCES:
		for error in DialogueCatalog.validate_sequence(sequence_id):
			_check(false, error)


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
	for level_id in GAME_LEVELS:
		get_tree().paused = false
		GameManager.start_level(level_id)
		var level: Node = GAME_LEVELS[level_id].instantiate()
		add_child(level)
		await get_tree().process_frame
		var dialogue := level.get_node("HUD/Root/DialogueOverlay") as DialogueOverlay
		if dialogue.visible:
			dialogue._on_skip_pressed()
		await get_tree().process_frame
		var expected_enemies: int = int(LevelCatalog.get_level(level_id)["threat_quota"])
		var enemy_count := 0
		var boss_count := 0
		for enemy: EnemyController in get_tree().get_nodes_in_group("Enemy"):
			if enemy.is_boss:
				boss_count += 1
			else:
				enemy_count += 1
				_check(enemy.enemy_type in LevelCatalog.get_level(level_id).get("enemy_roster", []), "%s spawned enemy type %s outside its roster." % [level_id, enemy.enemy_type])
		var player_count := get_tree().get_nodes_in_group("Player").size()
		_check(enemy_count == expected_enemies, "%s spawned %d/%d enemies." % [level_id, enemy_count, expected_enemies])
		_check(boss_count == 1, "%s did not spawn exactly one boss." % level_id)
		_check(player_count == 1, "%s did not spawn exactly one player." % level_id)
		_check(level.get_node("WorldGeometry").get_child_count() > 0, "%s has no authored world geometry." % level_id)
		_validate_jump_routes(level_id, level.get_node("WorldGeometry"))
		var player := get_tree().get_first_node_in_group("Player") as PlayerController
		var character := CharacterCatalog.get_character(GameManager.selected_character_id)
		var expected_attack := int(character["attack_damage"]) + SaveManager.get_upgrade_level("blade")
		_check(player.attack_damage == expected_attack, "%s did not apply base attack upgrades." % level_id)
		var health_before := player.health.current_health
		player.take_damage(1, Vector2.LEFT)
		_check(player.health.current_health == health_before - 1, "%s player damage did not apply." % level_id)
		for enemy: EnemyController in get_tree().get_nodes_in_group("Enemy"):
			if not enemy.is_boss:
				enemy.take_damage(999, Vector2.RIGHT)
		await get_tree().process_frame
		await get_tree().process_frame
		_check(GameManager.is_objective_complete(), "%s combat objective did not complete." % level_id)
		_check(GameManager.mission_phase == GameManager.PHASE_BOSS_ACTIVE, "%s did not enter the boss phase." % level_id)
		var portal := level.get_node_or_null("Portal") as ExitPortal
		_check(portal != null and not portal.active, "%s portal activated before boss defeat." % level_id)
		if dialogue.visible:
			dialogue._on_skip_pressed()
		var boss := level.get_node("Enemies").get_children().filter(func(node: Node) -> bool: return node is EnemyController and node.is_boss)[0] as EnemyController
		boss.take_damage(999, Vector2.RIGHT)
		await get_tree().process_frame
		await get_tree().process_frame
		_check(GameManager.mission_phase == GameManager.PHASE_EXTRACTION, "%s did not enter extraction." % level_id)
		_check(portal != null and portal.active, "%s exit portal did not activate after boss defeat." % level_id)
		level.queue_free()
		await get_tree().process_frame
		await get_tree().process_frame
		await get_tree().process_frame
	GameManager.reset_run()
	get_tree().paused = false


func _validate_jump_routes(level_id: String, world_geometry: Node) -> void:
	for route: Array in REQUIRED_JUMP_ROUTES[level_id]:
		var source := world_geometry.get_node(str(route[0])) as Node2D
		var target := world_geometry.get_node(str(route[1])) as Node2D
		var source_surface := source.position.y - 10.0 * source.scale.y
		var target_surface := target.position.y - 10.0 * target.scale.y
		var step_height := source_surface - target_surface
		_check(step_height <= 100.0, "%s route %s -> %s is too high (%.1f px)." % [level_id, route[0], route[1], step_height])


func _check(condition: bool, message: String) -> void:
	if not condition:
		failures.append(message)
