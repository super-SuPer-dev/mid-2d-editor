extends Node

const MAIN_ENTRANCE := preload("res://scenes/main.tscn")
const DIALOGUE_OVERLAY_SCENE := preload("res://scenes/ui/dialogue_overlay.tscn")
const CHARACTER_SELECT_SCENE := preload("res://scenes/ui/character_select.tscn")
const UPGRADES_SCENE := preload("res://scenes/ui/upgrades.tscn")
const GAME_LEVELS := {
	"level_01": preload("res://scenes/levels/level_01.tscn"),
	"level_02": preload("res://scenes/levels/level_02.tscn"),
	"level_03": preload("res://scenes/levels/level_03.tscn"),
}
const REQUIRED_JUMP_ROUTES := {
	"level_01": [
		["Ground", "Platform01"], ["Platform01", "Platform02"],
		["Platform03", "Platform04"], ["Platform05", "Platform06"],
		["Platform06", "Platform07"], ["Platform07", "Platform08"], ["Platform08", "Platform09"],
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
	preload("res://scenes/ui/main_menu.tscn"),
	preload("res://scenes/ui/character_select.tscn"),
	preload("res://scenes/ui/level_select.tscn"),
	preload("res://scenes/ui/settings.tscn"),
	preload("res://scenes/ui/credits.tscn"),
	preload("res://scenes/ui/character_upgrades.tscn"),
	preload("res://scenes/ui/upgrades.tscn"),
]
const EXPECTED_THREAT_QUOTAS := {
	"level_01": 8,
	"level_02": 5,
	"level_03": 5,
	"level_04": 6,
	"level_05": 6,
}
const EXPECTED_LEVEL1_ENCOUNTERS := {
	"irrigation_bank": 2,
	"collapsed_crop_lane": 3,
	"signal_root_approach": 3,
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
	SaveManager.begin_test_session()
	await get_tree().process_frame
	AudioManager.muted_for_tests = true
	_validate_catalogs()
	_validate_localization_and_dialogue()
	_validate_save_and_story_foundation()
	await _validate_dialogue_presentations()
	await _validate_ui_scenes()
	await _validate_character_select_layout()
	await _validate_upgrade_layout()
	await _validate_levels()
	AudioManager.stop_all_sfx()
	AudioManager.muted_for_tests = false
	SaveManager.end_test_session()
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
		if level_id == "level_01":
			var pacing_budget: Dictionary = data.get("pacing_budget_seconds", {})
			var pacing_total := 0
			for seconds: Variant in pacing_budget.values():
				pacing_total += int(seconds)
			_check(pacing_total >= 300 and pacing_total <= 420, "Level 1 pacing budget is outside the 5–7 minute target.")
			var contract_threat_total := 0
			for contract: Dictionary in data.get("encounter_contracts", []):
				var encounter_id := str(contract.get("encounter_id", ""))
				_check(EXPECTED_LEVEL1_ENCOUNTERS.has(encounter_id), "Level 1 has unknown encounter contract %s." % encounter_id)
				contract_threat_total += int(contract.get("threat_count", 0))
			_check(contract_threat_total == int(data["threat_quota"]), "Level 1 encounter contracts do not cover its threat quota.")
		_check(not data.get("enemy_roster", []).is_empty(), "%s has no enemy roster." % level_id)
		_check(not str(data.get("tile_kit_id", "")).is_empty(), "%s has no tile kit ID." % level_id)
		_check(not str(data.get("background_kit_id", "")).is_empty(), "%s has no background kit ID." % level_id)
		var pattern_set_id := str(data.get("boss_pattern_set", ""))
		_check(not pattern_set_id.is_empty(), "%s has no boss pattern set." % level_id)
		_check(int(data.get("projectile_cap", 0)) == EXPECTED_PROJECTILE_CAPS[level_id], "%s has an invalid projectile cap." % level_id)
		var pattern_set := BossPatternCatalog.get_pattern_set(pattern_set_id)
		_check(int(pattern_set.get("max_projectiles", 0)) == int(data.get("projectile_cap", 0)), "%s pattern-set cap does not match its level cap." % level_id)
		_check(BossPatternCatalog.get_phase_count(pattern_set_id) >= 2, "%s boss pattern set is not multi-phase." % level_id)
		for error in BossPatternCatalog.validate_pattern_set(pattern_set_id):
			_check(false, error)
		var required_sequences: Array[String] = [
			str(data.get("briefing_sequence", "")),
			str(data.get("boss_sequence", "")),
			str(data.get("debrief_sequence", "")),
		]
		for radio_sequence: Variant in data.get("radio_sequences", []):
			required_sequences.append(str(radio_sequence))
		for sequence_id: String in required_sequences:
			_check(not sequence_id.is_empty(), "%s contains an empty story sequence reference." % level_id)
			_check(not DialogueCatalog.get_sequence(sequence_id).is_empty(), "%s references missing story sequence %s." % [level_id, sequence_id])
	_check(CharacterCatalog.resolve_character_id("ranger") == "rin", "Legacy ranger ID did not migrate to rin.")
	_check(CharacterCatalog.resolve_character_id("villager") == "khem", "Legacy villager ID did not migrate to khem.")


func _validate_localization_and_dialogue() -> void:
	LocalizationManager.set_language("en")
	LocalizationManager.set_language("unsupported-locale")
	_check(LocalizationManager.current_language == LocalizationManager.DEFAULT_LANGUAGE, "Invalid language did not fall back to English.")
	_check(LocalizationManager.text("MENU_START_MISSION") == "Start Mission", "English localization did not load.")
	LocalizationManager.set_language("th")
	_check(LocalizationManager.text("MENU_START_MISSION") == "เริ่มภารกิจ", "Thai localization did not load.")
	var thai_mastery_copy := LocalizationManager.text("MASTERY_DESC").to_lower()
	_check(not thai_mastery_copy.contains("passive") and not thai_mastery_copy.contains("milestone"), "Thai mastery description still exposes untranslated English design terms.")
	LocalizationManager.set_language("en")
	for sequence_id in DialogueCatalog.SEQUENCES:
		for error in DialogueCatalog.validate_sequence(sequence_id):
			_check(false, error)
	for character_id in CharacterCatalog.get_ids():
		var briefing := DialogueCatalog.get_sequence("level_01_briefing", character_id)
		var debrief := DialogueCatalog.get_sequence("level_01_debrief", character_id)
		_check(briefing.size() == 6, "Level 1 briefing does not contain six exchanges for %s." % character_id)
		_check(debrief.size() == 4, "Level 1 debrief does not contain four exchanges for %s." % character_id)
		_check(_count_operator_entries(briefing, character_id) == 1, "Level 1 briefing bark is missing or mismatched for %s." % character_id)
		_check(_count_operator_entries(debrief, character_id) == 1, "Level 1 debrief bark is missing or mismatched for %s." % character_id)


func _validate_save_and_story_foundation() -> void:
	var legacy_profile := {
		"version": 1,
		"selected_character": "ranger",
		"character_upgrade_levels": {
			"ranger": {"blade": 2, "engine": 4, "armor": 1},
			"villager": {"blade": 3, "engine": 1, "armor": 2},
		},
		"settings": {"master_volume": 0.5, "fullscreen": false},
	}
	var migrated := SaveManager._migrate_profile(legacy_profile)
	_check(int(migrated.get("version", 0)) == SaveManager.CURRENT_VERSION, "Legacy profile did not migrate to save schema v2.")
	_check(str(migrated.get("selected_character", "")) == "rin", "Legacy ranger selection did not migrate to Rin.")
	_check(int(migrated.get("operator_mastery", {}).get("rin", -1)) == 4, "Legacy Ranger upgrades did not migrate to Rin mastery.")
	_check(int(migrated.get("operator_mastery", {}).get("khem", -1)) == 3, "Legacy Villager upgrades did not migrate to Khem mastery.")
	_check(not migrated.has("character_upgrade_levels"), "Legacy per-character upgrade tracks survived migration.")
	_check(str(migrated.get("settings", {}).get("language", "")) == LocalizationManager.DEFAULT_LANGUAGE, "Migrated profile did not default to English.")

	SaveManager.begin_test_session()
	_check(str(SaveManager.profile.get("settings", {}).get("language", "")) == "en", "Fresh test profile did not default to English.")
	SaveManager.complete_level("level_01", 3)
	_check("level_01" in SaveManager.profile.get("completed_levels", []), "Level completion was not recorded.")
	_check("level_02" in SaveManager.profile.get("unlocked_levels", []), "Level 2 did not unlock after Level 1 completion.")
	_check(int(SaveManager.profile.get("story_stage", 0)) == 2, "Story stage did not advance after Level 1 completion.")
	SaveManager.complete_level("level_01", 2)
	_check(int(SaveManager.profile.get("story_stage", 0)) == 2, "Replaying Level 1 changed the story stage incorrectly.")
	StoryManager.complete_sequence("level_01_briefing")
	StoryManager.complete_sequence("level_01_briefing")
	var seen: Array = SaveManager.profile.get("seen_dialogue_sequences", [])
	_check(seen.count("level_01_briefing") == 1, "One-shot story sequence was recorded more than once.")


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


func _validate_character_select_layout() -> void:
	var screen := CHARACTER_SELECT_SCENE.instantiate() as Control
	add_child(screen)
	await get_tree().process_frame
	await get_tree().process_frame
	for locale in ["en", "th"]:
		LocalizationManager.set_language(locale)
		await get_tree().process_frame
		await get_tree().process_frame
		for character_id in CharacterCatalog.get_ids():
			var data := CharacterCatalog.get_character(character_id)
			var card := screen.get_node("Layout/Cards/%s" % character_id) as Control
			var stats := card.get_node("Content/PortraitColumn/Stats") as Label
			var role := card.get_node("Content/Info/Role") as Label
			var description := card.get_node("Content/Info/Description") as Label
			var deploy := card.get_node("Content/Info/Deploy") as Button
			var expected_description := LocalizationManager.text(data["description_key"])
			_check(description.text.replace("\n", " ") == expected_description, "%s %s description lost or split characters during wrapping." % [locale, character_id])
			_check(description.text.count("\n") <= 2, "%s %s description exceeded three lines." % [locale, character_id])
			_check(role.text.count("\n") <= 1, "%s %s role exceeded two lines." % [locale, character_id])
			_check(stats.text.count("\n") <= 1, "%s %s stats exceeded two lines." % [locale, character_id])
			_check(not description.clip_text and description.autowrap_mode == TextServer.AUTOWRAP_OFF, "%s %s description can still clip or split words automatically (clip=%s, wrap=%d)." % [locale, character_id, description.clip_text, description.autowrap_mode])
			_check(card.get_global_rect().end.x <= screen.size.x and card.get_global_rect().end.y <= screen.size.y, "%s %s card extends outside 1280x720 (card_end=%s, screen=%s)." % [locale, character_id, card.get_global_rect().end, screen.size])
			_check(deploy.get_global_rect().end.y <= card.get_global_rect().end.y, "%s %s deploy button extends outside its card." % [locale, character_id])
	LocalizationManager.set_language("en")
	screen.queue_free()
	await get_tree().process_frame


func _validate_upgrade_layout() -> void:
	const DESCRIPTION_KEYS := {
		"blade": "UPGRADE_BLADE_DESC",
		"engine": "UPGRADE_ENGINE_DESC",
		"armor": "UPGRADE_ARMOR_DESC",
	}
	var screen := UPGRADES_SCENE.instantiate() as Control
	add_child(screen)
	await get_tree().process_frame
	await get_tree().process_frame
	for locale in ["en", "th"]:
		LocalizationManager.set_language(locale)
		await get_tree().process_frame
		await get_tree().process_frame
		for upgrade_id in DESCRIPTION_KEYS:
			var card := screen.get_node("Layout/Cards/%s" % upgrade_id) as Control
			var description := card.get_node("Row/Copy/Description") as Label
			var purchase := card.get_node("Row/Purchase") as Button
			var expected_description := LocalizationManager.text(DESCRIPTION_KEYS[upgrade_id])
			_check(description.text.replace("\n", " ") == expected_description, "%s %s upgrade description lost or split characters during wrapping." % [locale, upgrade_id])
			_check(description.text.count("\n") <= 2, "%s %s upgrade description exceeded three lines." % [locale, upgrade_id])
			_check(not description.clip_text and description.autowrap_mode == TextServer.AUTOWRAP_OFF, "%s %s upgrade description can still clip or split words automatically." % [locale, upgrade_id])
			_check(card.get_global_rect().end.x <= screen.size.x and card.get_global_rect().end.y <= screen.size.y, "%s %s upgrade card extends outside 1280x720." % [locale, upgrade_id])
			_check(purchase.get_global_rect().end.y <= card.get_global_rect().end.y, "%s %s upgrade button extends outside its card." % [locale, upgrade_id])
	LocalizationManager.set_language("en")
	screen.queue_free()
	await get_tree().process_frame


func _validate_dialogue_presentations() -> void:
	var overlay := DIALOGUE_OVERLAY_SCENE.instantiate() as DialogueOverlay
	add_child(overlay)
	await get_tree().process_frame
	overlay.visible = true
	overlay._apply_presentation_mode("radio")
	await get_tree().process_frame
	_check(overlay.panel.anchor_left == 1.0 and overlay.panel.anchor_top == 0.0, "Radio dialogue is not anchored to the top-right safe area.")
	_check(overlay.panel.offset_top >= 180.0, "Radio dialogue overlaps the combat HUD or boss bar.")
	_check(overlay.panel.size.x <= 520.0 and overlay.panel.size.y <= 180.0, "Radio dialogue is not compact enough for active combat (panel %s, portrait %s, text %s, actions %s)." % [overlay.panel.size, overlay.portrait.size, overlay.text_label.size, overlay.actions.size])
	_check(not overlay.actions.visible, "Radio dialogue exposes blocking action controls.")
	overlay._apply_presentation_mode("full")
	await get_tree().process_frame
	_check(overlay.panel.anchor_left == 0.5 and overlay.panel.anchor_top == 1.0, "Full dialogue did not restore its bottom-center layout.")
	_check(overlay.actions.visible, "Full dialogue did not restore its controls.")
	overlay.queue_free()
	await get_tree().process_frame


func _validate_levels() -> void:
	for level_id in GAME_LEVELS:
		get_tree().paused = false
		GameManager.start_level(level_id)
		var requested_sequences: Array[String] = []
		var capture_sequence := func(sequence_id: String) -> void: requested_sequences.append(sequence_id)
		StoryManager.sequence_requested.connect(capture_sequence)
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
		var boss := level.get_node("Enemies").get_children().filter(func(node: Node) -> bool: return node is EnemyController and node.is_boss)[0] as EnemyController
		var pattern_runner := boss.get_node("BossProjectilePatternRunner") as BossProjectilePatternRunner
		if level_id == "level_01":
			var encounter_gates := level.get_node_or_null("EncounterGates")
			_check(encounter_gates != null and encounter_gates.get_child_count() == 3, "Level 1 does not contain three encounter gates.")
			var assigned_threats := 0
			var physical_trigger_tested := false
			var trigger_player := get_tree().get_first_node_in_group("Player") as PlayerController
			if encounter_gates != null:
				for gate: Node in encounter_gates.get_children():
					_check(gate is EncounterGate, "Level 1 encounter gate has the wrong script type.")
					if gate is EncounterGate:
						var typed_gate := gate as EncounterGate
						_check(EXPECTED_LEVEL1_ENCOUNTERS.has(typed_gate.encounter_id), "Unknown Level 1 gate %s." % typed_gate.encounter_id)
						_check(typed_gate.enemy_paths.size() == int(EXPECTED_LEVEL1_ENCOUNTERS.get(typed_gate.encounter_id, -1)), "Gate %s has the wrong threat count." % typed_gate.encounter_id)
						assigned_threats += typed_gate.enemy_paths.size()
						if typed_gate.encounter_id == "irrigation_bank":
							trigger_player.global_position = typed_gate.global_position + typed_gate.trigger_offset
							for _trigger_frame in range(3):
								await get_tree().physics_frame
							physical_trigger_tested = typed_gate.started
						else:
							typed_gate.start_encounter()
						_check(typed_gate.started, "Gate %s could not start." % typed_gate.encounter_id)
			_check(physical_trigger_tested, "Level 1 irrigation gate did not start from physical player overlap.")
			_check(assigned_threats == expected_enemies, "Level 1 encounter gates do not assign every threat exactly once.")
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
		if level_id == "level_01":
			for gate: EncounterGate in level.get_node("EncounterGates").get_children():
				_check(gate.cleared, "Gate %s did not clear after its threats were defeated." % gate.encounter_id)
				_check(gate.barrier_shape.disabled, "Gate %s barrier remained collidable after clear." % gate.encounter_id)
		_check(GameManager.mission_phase == GameManager.PHASE_BOSS_ACTIVE, "%s did not enter the boss phase." % level_id)
		var portal := level.get_node_or_null("Portal") as ExitPortal
		_check(portal != null and not portal.active, "%s portal activated before boss defeat." % level_id)
		var current_level_data := LevelCatalog.get_level(level_id)
		var expected_story_order: Array = current_level_data.get("radio_sequences", []).duplicate()
		expected_story_order.append(str(current_level_data.get("boss_sequence", "")))
		var previous_story_index := -1
		for expected_sequence: Variant in expected_story_order:
			var sequence_id := str(expected_sequence)
			var story_index := requested_sequences.find(sequence_id)
			_check(story_index > previous_story_index, "%s did not request radio and boss sequences in canonical order at %s." % [level_id, sequence_id])
			_check(requested_sequences.count(sequence_id) == 1, "%s requested %s more than once." % [level_id, sequence_id])
			previous_story_index = story_index
		_check(not get_tree().paused, "%s radio dialogue paused gameplay." % level_id)
		_check(not boss.combat_active and not pattern_runner.active, "%s boss activated before its queued introduction completed." % level_id)
		_check(GameManager.current_boss_phase == boss.boss_phase and GameManager.current_boss_phase_count == boss.boss_phase_count, "%s boss preview exposed the wrong phase contract." % level_id)
		var level_hud := level.get_node("HUD") as GameHUD
		_check(int(level_hud.boss_health.value) == boss.health.current_health and int(level_hud.boss_health.max_value) == boss.health.max_health, "%s boss preview exposed stale health." % level_id)
		await _drain_dialogue(dialogue)
		_check(boss.combat_active and pattern_runner.active, "%s boss did not activate after its introduction completed." % level_id)
		_check(pattern_runner.active, "%s boss projectile runner did not activate." % level_id)
		_check(pattern_runner.projectile_cap == int(LevelCatalog.get_level(level_id)["projectile_cap"]), "%s boss projectile runner ignored its cap." % level_id)
		for _frame in range(50):
			await get_tree().physics_frame
		_check(pattern_runner.get_active_projectile_count() > 0, "%s boss did not emit its opening projectile pattern." % level_id)
		_check(pattern_runner.get_active_projectile_count() <= pattern_runner.projectile_cap, "%s boss exceeded its projectile cap." % level_id)
		_check(pattern_runner.all_projectiles.size() <= pattern_runner.projectile_cap, "%s boss projectile pool exceeded its cap." % level_id)
		if level_id == "level_01":
			_check(boss.boss_phase == 1 and pattern_runner.current_phase == 1, "%s boss did not begin in phase 1." % level_id)
			_check(int(pattern_runner.current_pattern.get("phase", 0)) == 1, "%s boss opened with a pattern from the wrong phase." % level_id)
			var phase_damage := ceili(float(boss.health.max_health) / float(boss.boss_phase_count))
			boss.take_damage(phase_damage, Vector2.RIGHT)
			await get_tree().process_frame
			_check(boss.boss_phase == 2 and pattern_runner.current_phase == 2, "%s boss health threshold did not activate phase 2." % level_id)
			_check(GameManager.current_boss_phase == 2 and GameManager.current_boss_phase_count == boss.boss_phase_count, "%s boss phase state did not propagate through GameManager." % level_id)
			_check(pattern_runner.get_active_projectile_count() == 0, "%s phase transition did not clear active projectiles." % level_id)
			_check(int(pattern_runner.current_pattern.get("phase", 0)) == 2, "%s phase 2 selected a pattern from the wrong phase." % level_id)
			for _phase_frame in range(50):
				await get_tree().physics_frame
			_check(pattern_runner.get_active_projectile_count() > 0, "%s phase 2 did not emit its projectile pattern." % level_id)
			_check(pattern_runner.get_active_projectile_count() <= pattern_runner.projectile_cap, "%s phase 2 exceeded its projectile cap." % level_id)
			boss.set_combat_active(false)
			await get_tree().process_frame
			_check(get_tree().get_nodes_in_group("BossProjectile").is_empty(), "%s boss projectiles survived combat shutdown." % level_id)
			boss.set_combat_active(true)
			for _frame in range(50):
				await get_tree().physics_frame
			_check(pattern_runner.get_active_projectile_count() > 0, "%s boss projectile runner did not resume after reactivation." % level_id)
		boss.take_damage(999, Vector2.RIGHT)
		await get_tree().process_frame
		await get_tree().process_frame
		_check(get_tree().get_nodes_in_group("BossProjectile").is_empty(), "%s boss projectiles survived boss defeat." % level_id)
		_check(GameManager.mission_phase == GameManager.PHASE_EXTRACTION, "%s did not enter extraction." % level_id)
		_check(portal != null and portal.active, "%s exit portal did not activate after boss defeat." % level_id)
		StoryManager.sequence_requested.disconnect(capture_sequence)
		level.queue_free()
		await get_tree().process_frame
		await get_tree().process_frame
		await get_tree().process_frame
	GameManager.reset_run()
	get_tree().paused = false


func _drain_dialogue(dialogue: DialogueOverlay) -> void:
	var guard := 0
	while dialogue.visible or not dialogue.pending_sequences.is_empty():
		if dialogue.visible:
			dialogue._on_skip_pressed()
		await get_tree().process_frame
		await get_tree().process_frame
		guard += 1
		if guard >= 12:
			_check(false, "Dialogue queue did not drain within its safety limit.")
			return


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


func _count_operator_entries(entries: Array, character_id: String) -> int:
	var count := 0
	for entry: Dictionary in entries:
		if str(entry.get("operator_condition", "")) == character_id:
			count += 1
	return count
