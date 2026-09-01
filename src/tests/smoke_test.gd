extends Node

const MAIN_ENTRANCE := preload("res://scenes/main.tscn")
const DIALOGUE_OVERLAY_SCENE := preload("res://scenes/ui/dialogue_overlay.tscn")
const CHARACTER_SELECT_SCENE := preload("res://scenes/ui/character_select.tscn")
const UPGRADES_SCENE := preload("res://scenes/ui/upgrades.tscn")
const MASTERY_SCENE := preload("res://scenes/ui/character_upgrades.tscn")
const PLAYER_SCENE := preload("res://scenes/actors/player.tscn")
const GAME_LEVELS := {
	"level_01": preload("res://scenes/levels/level_01.tscn"),
	"level_02": preload("res://scenes/levels/level_02.tscn"),
	"level_03": preload("res://scenes/levels/level_03.tscn"),
	"level_04": preload("res://scenes/levels/level_04.tscn"),
	"level_05": preload("res://scenes/levels/level_05.tscn"),
}
const REQUIRED_JUMP_ROUTES := {
	"level_01": [
		["Ground", "Platform01"], ["Platform01", "Platform02"],
		["Platform03", "Platform04"], ["Platform05", "Platform06"],
		["Platform06", "Platform07"], ["Platform07", "Platform08"], ["Platform08", "Platform09"],
	],
	"level_02": [
		["GroundA", "Platform03"], ["Platform03", "GroundB"],
		["GroundB", "Platform04"], ["Platform04", "Platform01"],
		["Platform01", "GroundC"], ["GroundC", "Platform05"],
		["Platform05", "Platform02"], ["Platform02", "GroundD"],
		["GroundD", "Platform06"],
	],
	"level_03": [
		["Ground", "Platform01"], ["Platform01", "Platform02"],
		["Platform02", "GroundB"], ["GroundB", "Platform03"],
		["Platform03", "Platform04"], ["Platform04", "Platform05"],
		["Platform05", "GroundC"],
	],
	"level_04": [
		["Ground", "Platform01"], ["Platform01", "Platform02"],
		["Platform02", "Platform03"], ["Platform03", "Platform04"],
		["Platform04", "Platform05"], ["Platform05", "Platform06"],
		["Platform06", "Platform07"],
	],
	"level_05": [
		["Ground", "Platform01"], ["Platform01", "Platform02"],
		["Platform02", "GroundB"], ["GroundB", "Platform03"],
		["Platform03", "Platform04"], ["Platform04", "Platform05"],
		["Platform05", "Platform06"], ["Platform06", "GroundC"],
		["GroundC", "Platform07"], ["Platform07", "Platform08"],
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
	_validate_operator_passives()
	_validate_progression_purchases()
	_validate_localization_and_dialogue()
	_validate_save_and_story_foundation()
	await _validate_dialogue_presentations()
	await _validate_ui_scenes()
	await _validate_character_select_layout()
	await _validate_upgrade_layout()
	await _validate_mastery_layout()
	await _validate_pseudo_localization()
	await _validate_retry_recovery()
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
	_check(AudioManager.GENERATED_SFX.size() >= 20, "Generated gameplay SFX registry is incomplete.")
	_check(AudioManager.GENERATED_MUSIC.size() == 8, "Generated music registry is incomplete.")
	_check(AudioManager.sfx_pool.size() == AudioManager.SFX_POOL_SIZE, "AudioManager did not initialize its bounded SFX pool.")
	var audio_children_before := AudioManager.get_child_count()
	var audio_muted_before := AudioManager.muted_for_tests
	AudioManager.muted_for_tests = false
	for _sfx_burst in range(AudioManager.SFX_POOL_SIZE + 4):
		AudioManager.play_named_sfx(&"enemy_hit", 1.0, -18.0)
	_check(AudioManager.get_child_count() == audio_children_before, "SFX playback created unbounded AudioStreamPlayer nodes.")
	_check(AudioManager.get_active_sfx_count() <= AudioManager.SFX_POOL_SIZE, "SFX playback exceeded its bounded voice pool.")
	AudioManager.stop_all_sfx()
	AudioManager.muted_for_tests = audio_muted_before
	for audio_stream: Variant in AudioManager.GENERATED_SFX.values():
		_check(audio_stream is AudioStream, "Generated SFX registry contains an invalid stream.")
	for music_stream: Variant in AudioManager.GENERATED_MUSIC.values():
		_check(music_stream is AudioStream, "Generated music registry contains an invalid stream.")
	_check(SaveManager.get_mastery_rank() >= 0, "Operator mastery data is missing.")
	for character_id in CharacterCatalog.get_ids():
		_check(SaveManager.profile.get("operator_mastery", {}).has(character_id), "%s has no mastery profile." % character_id)
		var data := CharacterCatalog.get_character(character_id)
		_check(int(data["max_health"]) > 0, "%s has invalid health." % character_id)
		_check(float(data["move_speed"]) > 0.0, "%s has invalid speed." % character_id)
		var art_texture := data["art_texture"] as Texture2D
		_check(art_texture != null and art_texture.get_width() == 1120 and art_texture.get_height() == 1400, "%s operator sheet is not cropped to the exact 4 × 5 280 px grid." % character_id)
		if art_texture != null:
			_check(str(art_texture.resource_path).ends_with("_sprite_sheet_generated_v4.png"), "%s is not using the regenerated leak-safe operator sheet." % character_id)
			var edge_frame := CharacterCatalog.get_sprite_frame(art_texture, CharacterCatalog.SHEET_COLUMNS - 1, CharacterCatalog.SHEET_ROWS - 1, 0.0)
			_check(edge_frame.region.size.is_equal_approx(Vector2(280.0, 280.0)), "%s operator atlas slicing lost its exact 280 px cell size." % character_id)
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


func _validate_operator_passives() -> void:
	var original_character := GameManager.selected_character_id
	var original_mastery: Dictionary = SaveManager.profile.get("operator_mastery", {}).duplicate(true)
	var mastery_strengths := {
		"tonkla": [3.0, 2.0],
		"rin": [0.25, 0.34],
		"khem": [0.25, 0.4],
		"t800": [1.0, 2.0],
	}
	for character_id: String in CharacterCatalog.get_ids():
		SaveManager.profile["operator_mastery"][character_id] = 0
		GameManager.select_character(character_id)
		var player := PLAYER_SCENE.instantiate() as PlayerController
		add_child(player)
		await get_tree().process_frame
		await get_tree().process_frame
		_check(player.character_id == character_id, "%s passive test instantiated the wrong operator." % character_id)
		_check(is_equal_approx(CharacterCatalog.get_passive_strength(character_id, 0), mastery_strengths[character_id][0]), "%s rank-0 passive strength drifted from the design contract." % character_id)
		_check(is_equal_approx(CharacterCatalog.get_passive_strength(character_id, 3), mastery_strengths[character_id][1]), "%s rank-3 passive strength drifted from the design contract." % character_id)
		match character_id:
			"tonkla":
				var starting_health := player.health.current_health
				player.take_damage(1, Vector2.RIGHT)
				player._on_currency_changed(0, 2)
				_check(player.health.current_health == starting_health - 1, "Tonkla recovered before collecting the rank-0 sample threshold.")
				player._on_currency_changed(0, 1)
				_check(player.health.current_health == starting_health, "Tonkla did not recover health at the rank-0 sample threshold.")
			"rin":
				_check(is_equal_approx(player.dash_cooldown_duration, PlayerController.DASH_COOLDOWN * 0.75), "Rin did not apply the rank-0 dash cooldown reduction.")
			"khem":
				var attack_rectangle := player.attack_shape.shape as RectangleShape2D
				_check(attack_rectangle != null and is_equal_approx(attack_rectangle.size.x, 54.0 * 1.25), "Khem did not apply the rank-0 attack-area increase.")
			"t800":
				var starting_health := player.health.current_health
				player.take_damage(2, Vector2.RIGHT)
				_check(player.health.current_health == starting_health - 1, "T-800 did not reduce incoming damage while preserving minimum damage of one.")
		player.queue_free()
		await get_tree().process_frame
	SaveManager.profile["operator_mastery"] = original_mastery
	GameManager.select_character(original_character)


func _validate_progression_purchases() -> void:
	var original_profile: Dictionary = SaveManager.profile.duplicate(true)
	SaveManager.profile["total_crystals"] = 100
	SaveManager.profile["upgrade_levels"] = {"blade": 0, "engine": 0, "armor": 0}
	_check(SaveManager.get_upgrade_cost("blade") == 4, "Base Technology rank-0 cost drifted from the design contract.")
	_check(SaveManager.purchase_upgrade("blade"), "Base Technology purchase was rejected despite sufficient currency.")
	_check(SaveManager.get_upgrade_level("blade") == 1 and SaveManager.profile["total_crystals"] == 96, "Base Technology purchase did not apply exactly one rank and its exact cost.")
	var crystals_after_upgrade := int(SaveManager.profile["total_crystals"])
	_check(not SaveManager.purchase_upgrade("invalid_upgrade"), "Invalid Base Technology ID was accepted.")
	_check(int(SaveManager.profile["total_crystals"]) == crystals_after_upgrade, "Invalid Base Technology purchase changed currency.")
	SaveManager.profile["upgrade_levels"]["blade"] = 5
	var crystals_at_upgrade_cap := int(SaveManager.profile["total_crystals"])
	_check(not SaveManager.purchase_upgrade("blade"), "Base Technology purchase exceeded rank 5.")
	_check(int(SaveManager.profile["total_crystals"]) == crystals_at_upgrade_cap, "Capped Base Technology purchase changed currency.")

	SaveManager.profile["total_crystals"] = 100
	SaveManager.profile["operator_mastery"] = {"tonkla": 0, "rin": 0, "khem": 0, "t800": 0}
	GameManager.select_character("rin")
	_check(SaveManager.get_mastery_cost("rin") == 3, "Operator Mastery rank-0 cost drifted from the design contract.")
	_check(SaveManager.purchase_mastery("rin"), "Operator Mastery purchase was rejected despite sufficient currency.")
	_check(SaveManager.get_mastery_rank("rin") == 1 and SaveManager.profile["total_crystals"] == 97, "Operator Mastery purchase did not apply exactly one rank and its exact cost.")
	_check(SaveManager.get_character_upgrade_level("blade", "rin") == 1, "Legacy mastery level accessor no longer reflects the shared Mastery rank.")
	SaveManager.profile["operator_mastery"]["rin"] = 5
	var crystals_at_mastery_cap := int(SaveManager.profile["total_crystals"])
	_check(not SaveManager.purchase_mastery("rin"), "Operator Mastery purchase exceeded rank 5.")
	_check(int(SaveManager.profile["total_crystals"]) == crystals_at_mastery_cap, "Capped Operator Mastery purchase changed currency.")
	_check(not SaveManager.purchase_mastery("invalid_operator"), "Invalid Operator Mastery ID was accepted.")
	SaveManager.profile = original_profile
	GameManager.select_character(str(SaveManager.profile.get("selected_character", CharacterCatalog.DEFAULT_CHARACTER)))


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
	_check(not bool(migrated.get("settings", {}).get("immediate_dialogue_text", true)), "Migrated profile did not receive the default dialogue accessibility setting.")
	var recovery_backup := {
		"version": SaveManager.CURRENT_VERSION,
		"selected_character": "rin",
		"total_crystals": 17,
		"completed_levels": ["level_01"],
	}
	var recovered_from_backup := SaveManager._select_recovery_profile(null, recovery_backup)
	_check(int(recovered_from_backup.get("total_crystals", 0)) == 17, "Corrupt-primary recovery did not select the valid backup profile.")
	var valid_primary := {"version": SaveManager.CURRENT_VERSION, "total_crystals": 23}
	var primary_wins := SaveManager._select_recovery_profile(valid_primary, recovery_backup)
	_check(int(primary_wins.get("total_crystals", 0)) == 23, "Valid primary profile did not take precedence over its backup.")
	_check(SaveManager._select_recovery_profile("corrupt", ["corrupt"]).is_empty(), "Invalid primary and backup data did not fall back to defaults.")
	var migrated_recovery := SaveManager._migrate_profile(recovered_from_backup)
	_check(int(migrated_recovery.get("version", 0)) == SaveManager.CURRENT_VERSION, "Recovered backup profile did not remain schema v2.")

	SaveManager.begin_test_session()
	_check(str(SaveManager.profile.get("settings", {}).get("language", "")) == "en", "Fresh test profile did not default to English.")
	_check(not bool(SaveManager.profile.get("settings", {}).get("immediate_dialogue_text", true)), "Fresh test profile did not default to typewriter dialogue.")
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
	var settings := UI_SCENES[3].instantiate() as Control
	add_child(settings)
	await get_tree().process_frame
	var immediate_dialogue := settings.get_node("Center/Panel/Content/ImmediateDialogue") as CheckButton
	_check(immediate_dialogue != null, "Settings is missing the immediate-dialogue accessibility control.")
	if immediate_dialogue != null:
		settings._on_immediate_dialogue_toggled(true)
		_check(bool(SaveManager.profile.get("settings", {}).get("immediate_dialogue_text", false)), "Immediate-dialogue setting did not persist in the active profile.")
		settings._on_immediate_dialogue_toggled(false)
	settings.queue_free()
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


func _validate_mastery_layout() -> void:
	var screen := MASTERY_SCENE.instantiate() as Control
	add_child(screen)
	await get_tree().process_frame
	var frame := screen.get_node("MasteryFrame") as TextureRect
	_check(frame != null and frame.texture != null and str(frame.texture.resource_path).ends_with("operator_mastery_screen_normalized_v1.png"), "Mastery screen did not apply the generated shell frame.")
	_check(frame != null and frame.get_global_rect().size.x >= 1200.0 and frame.get_global_rect().size.y >= 680.0, "Mastery shell did not cover the 1280x720 safe area.")
	var rank_track := screen.get_node("Margin/Layout/Cards/blade/Content/RankTrack") as HBoxContainer
	_check(rank_track != null and rank_track.get_child_count() == 6, "Mastery rank track did not construct six nodes.")
	if rank_track != null:
		for index in range(rank_track.get_child_count()):
			var rank_icon := rank_track.get_child(index) as TextureRect
			_check(rank_icon.texture is AtlasTexture, "Mastery rank node %d did not bind an atlas frame." % index)
	screen.queue_free()
	await get_tree().process_frame


func _validate_pseudo_localization() -> void:
	LocalizationManager.set_language("en")
	LocalizationManager.set_pseudo_localization(false)
	var plain_texts := {}
	for key: String in LocalizationManager.english_fallback:
		plain_texts[key] = LocalizationManager.text(key)
	LocalizationManager.set_pseudo_localization(true)
	await get_tree().process_frame
	await get_tree().process_frame
	for key: String in plain_texts:
		var plain: String = plain_texts[key]
		var pseudo := LocalizationManager.text(key)
		var target := int(ceil(plain.length() * LocalizationManager.PSEUDO_MIN_EXPANSION))
		_check(pseudo.begins_with(LocalizationManager.PSEUDO_PREFIX) and pseudo.ends_with(LocalizationManager.PSEUDO_SUFFIX), "Pseudo-localized %s is missing its expansion markers." % key)
		_check(pseudo.length() >= target, "Pseudo-localized %s expanded to %d characters, below the %.0f%% contract." % [key, pseudo.length(), LocalizationManager.PSEUDO_MIN_EXPANSION * 100.0])
	_check(LocalizationManager.text("UPGRADE_PURCHASE").contains("{cost}"), "Pseudo-localization destroyed the upgrade cost placeholder token.")
	var purchase := LocalizationManager.text("UPGRADE_PURCHASE", {"cost": 25})
	_check(purchase.contains("25") and not purchase.contains("{cost}"), "Pseudo-localization corrupted the upgrade cost placeholder.")
	_check(not LocalizationManager.text("MENU_START_MISSION") == "Start Mission", "Pseudo-localization left an English string untouched.")
	var screen := UPGRADES_SCENE.instantiate() as Control
	add_child(screen)
	await get_tree().process_frame
	await get_tree().process_frame
	for upgrade_id in ["blade", "engine", "armor"]:
		var card := screen.get_node("Layout/Cards/%s" % upgrade_id) as Control
		var description := card.get_node("Row/Copy/Description") as Label
		var purchase_button := card.get_node("Row/Purchase") as Button
		var expected_description := LocalizationManager.text("UPGRADE_%s_DESC" % upgrade_id.to_upper())
		_check(description.text.replace("\n", " ") == expected_description, "Pseudo %s upgrade description lost or split characters during wrapping." % upgrade_id)
		_check(description.text.count("\n") <= 2, "Pseudo %s upgrade description exceeded three lines." % upgrade_id)
		_check(not description.clip_text and description.autowrap_mode == TextServer.AUTOWRAP_OFF, "Pseudo %s upgrade description can still clip or split words automatically." % upgrade_id)
		_check(card.get_global_rect().end.x <= screen.size.x and card.get_global_rect().end.y <= screen.size.y, "Pseudo %s upgrade card extends outside 1280x720." % upgrade_id)
		_check(purchase_button.get_global_rect().end.y <= card.get_global_rect().end.y, "Pseudo %s upgrade button extends outside its card." % upgrade_id)
	screen.queue_free()
	LocalizationManager.set_pseudo_localization(false)
	_check(LocalizationManager.text("MENU_START_MISSION") == "Start Mission", "Disabling pseudo-localization did not restore English text.")
	LocalizationManager.set_language("en")
	await get_tree().process_frame


func _validate_retry_recovery() -> void:
	SaveManager.begin_test_session()
	LocalizationManager.set_language("en")
	GameManager.start_level("level_01")
	var requested_sequences: Array[String] = []
	var capture_sequence := func(sequence_id: String) -> void: requested_sequences.append(sequence_id)
	StoryManager.sequence_requested.connect(capture_sequence)
	var failed_level: Node = GAME_LEVELS["level_01"].instantiate()
	add_child(failed_level)
	await get_tree().process_frame
	await get_tree().process_frame
	var failed_dialogue := failed_level.get_node("HUD/Root/DialogueOverlay") as DialogueOverlay
	await _drain_dialogue(failed_dialogue)
	_check(requested_sequences.count("level_01_briefing") == 1, "Retry setup did not request the Level 1 briefing exactly once.")
	var failed_player := failed_level.get_node("Player") as PlayerController
	failed_player.take_damage(999, Vector2.LEFT)
	await get_tree().process_frame
	_check(not GameManager.run_active, "Player defeat did not finish the failed run.")
	_check(get_tree().paused, "Player defeat did not pause on the game-over modal.")
	_check((failed_level.get_node("HUD") as GameHUD).modal.visible, "Player defeat did not show the game-over modal.")
	get_tree().paused = false
	failed_level.queue_free()
	await get_tree().process_frame
	GameManager.start_level("level_01")
	var retry_level: Node = GAME_LEVELS["level_01"].instantiate()
	add_child(retry_level)
	await get_tree().process_frame
	await get_tree().process_frame
	var retry_dialogue := retry_level.get_node("HUD/Root/DialogueOverlay") as DialogueOverlay
	_check(not retry_dialogue.visible and retry_dialogue.pending_sequences.is_empty(), "Retry replayed a completed one-shot briefing.")
	_check(requested_sequences.count("level_01_briefing") == 1, "Retry duplicated the Level 1 briefing request.")
	var retry_player := retry_level.get_node("Player") as PlayerController
	_check(GameManager.run_active, "Retry did not reactivate the mission.")
	_check(retry_player.health.current_health == retry_player.health.max_health, "Retry did not reset player health.")
	StoryManager.sequence_requested.disconnect(capture_sequence)
	retry_level.queue_free()
	await get_tree().process_frame
	GameManager.reset_run()
	get_tree().paused = false
	SaveManager.begin_test_session()


func _validate_dialogue_presentations() -> void:
	var original_operator_id := GameManager.selected_character_id
	for speaker_id: String in ["commander_anan", "dr_mali", "technician_chai"]:
		var speaker := SpeakerCatalog.get_speaker(speaker_id)
		var expressions: Array = speaker.get("expressions", [])
		_check(expressions.size() >= 2, "%s does not expose two portrait expressions." % speaker_id)
		if expressions.size() >= 2:
			var first_portrait := SpeakerCatalog.get_portrait_texture(speaker_id, str(expressions[0]))
			var second_portrait := SpeakerCatalog.get_portrait_texture(speaker_id, str(expressions[1]))
			_check(first_portrait is AtlasTexture and second_portrait is AtlasTexture, "%s portrait expressions did not resolve to atlas textures." % speaker_id)
			if first_portrait is AtlasTexture and second_portrait is AtlasTexture:
				_check((first_portrait as AtlasTexture).region.position.x != (second_portrait as AtlasTexture).region.position.x, "%s portrait expressions resolve to the same frame." % speaker_id)
	for operator_id: String in CharacterCatalog.get_ids():
		var neutral_portrait := SpeakerCatalog.get_portrait_texture("selected_operator", "neutral")
		var action_expression := "alert" if operator_id == "t800" else "determined"
		GameManager.selected_character_id = operator_id
		var action_portrait := SpeakerCatalog.get_portrait_texture("selected_operator", action_expression)
		_check(neutral_portrait is AtlasTexture and action_portrait is AtlasTexture, "%s operator portrait expressions did not resolve to atlas textures." % operator_id)
		if neutral_portrait is AtlasTexture and action_portrait is AtlasTexture:
			_check((neutral_portrait as AtlasTexture).region.position.x != (action_portrait as AtlasTexture).region.position.x, "%s operator portrait expressions resolve to the same frame." % operator_id)
	GameManager.selected_character_id = original_operator_id
	var overlay := DIALOGUE_OVERLAY_SCENE.instantiate() as DialogueOverlay
	add_child(overlay)
	await get_tree().process_frame
	overlay.visible = true
	overlay._apply_presentation_mode("radio")
	await get_tree().process_frame
	var radio_style := overlay.panel.get_theme_stylebox("panel") as StyleBoxFlat
	_check(radio_style != null and radio_style.border_width_left == 3 and radio_style.border_color.is_equal_approx(Color("5ba98c")), "Radio dialogue did not apply its bounds-matched panel style.")
	_check(overlay.panel.anchor_left == 1.0 and overlay.panel.anchor_top == 0.0, "Radio dialogue is not anchored to the top-right safe area.")
	_check(overlay.panel.offset_top >= 180.0, "Radio dialogue overlaps the combat HUD or boss bar.")
	_check(overlay.panel.size.x <= 520.0 and overlay.panel.size.y <= 180.0, "Radio dialogue is not compact enough for active combat (panel %s, portrait %s, text %s, actions %s)." % [overlay.panel.size, overlay.portrait.size, overlay.text_label.size, overlay.actions.size])
	_check(not overlay.actions.visible, "Radio dialogue exposes blocking action controls.")
	overlay._apply_presentation_mode("full")
	await get_tree().process_frame
	var full_style := overlay.panel.get_theme_stylebox("panel") as StyleBoxFlat
	_check(full_style != null and full_style.border_color.is_equal_approx(Color("88a84f")), "Full dialogue did not apply its bounds-matched panel style.")
	overlay._apply_presentation_mode("briefing")
	await get_tree().process_frame
	var briefing_style := overlay.panel.get_theme_stylebox("panel") as StyleBoxFlat
	_check(briefing_style != null and briefing_style.border_color.is_equal_approx(Color("d2a63f")), "Briefing dialogue did not apply its bounds-matched panel style.")
	var panel_rect := overlay.panel.get_global_rect()
	var speaker_rect := overlay.speaker_label.get_global_rect()
	var text_rect := overlay.text_label.get_global_rect()
	_check(speaker_rect.position.x >= panel_rect.position.x + 190.0 and speaker_rect.position.y >= panel_rect.position.y + 16.0 and speaker_rect.end.x <= panel_rect.end.x - 16.0, "Briefing speaker label is not contained by the visible panel.")
	_check(text_rect.position.x >= panel_rect.position.x + 190.0 and text_rect.position.y >= speaker_rect.end.y and text_rect.end.x <= panel_rect.end.x - 16.0 and text_rect.end.y <= panel_rect.end.y - 52.0, "Briefing body text is not aligned beneath the speaker inside the panel.")
	var original_boss_id := GameManager.current_boss_id
	for boss_id: String in ["thorn_matriarch", "maw_bloom_sovereign", "possessed_banyan", "root_hydra", "root_core_eye"]:
		GameManager.current_boss_id = boss_id
		overlay._apply_presentation_mode("boss")
		await get_tree().process_frame
		var boss_style := overlay.panel.get_theme_stylebox("panel") as StyleBoxFlat
		_check(boss_style != null and boss_style.border_color.is_equal_approx(Color("b85d8e")), "%s boss introduction did not apply its bounds-matched panel style." % boss_id)
	GameManager.current_boss_id = original_boss_id
	overlay._apply_presentation_mode("debrief")
	await get_tree().process_frame
	var debrief_style := overlay.panel.get_theme_stylebox("panel") as StyleBoxFlat
	_check(debrief_style != null and debrief_style.border_color.is_equal_approx(Color("79b9a5")), "Debrief dialogue did not apply its bounds-matched panel style.")
	_check(overlay.panel.anchor_left == 0.5 and overlay.panel.anchor_top == 1.0, "Full dialogue did not restore its bottom-center layout.")
	_check(overlay.actions.visible, "Full dialogue did not restore its controls.")
	SaveManager.profile["settings"]["immediate_dialogue_text"] = false
	overlay.entries = DialogueCatalog.get_sequence("level_01_briefing", "tonkla")
	overlay.entry_index = 0
	overlay.visible = true
	overlay._show_current_entry()
	_check(overlay.text_label.visible_ratio <= 0.01, "Dialogue typewriter mode did not begin with hidden text.")
	overlay._on_continue_pressed()
	_check(overlay.text_label.visible_ratio >= 0.999, "Continue did not reveal the current dialogue entry before advancing.")
	SaveManager.profile["settings"]["immediate_dialogue_text"] = true
	overlay.entry_index = 0
	overlay._show_current_entry()
	_check(overlay.text_label.visible_ratio >= 0.999, "Immediate-dialogue accessibility mode still animated text.")
	SaveManager.profile["settings"]["immediate_dialogue_text"] = false
	get_tree().paused = false
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
		var parallax_root := level.get_node_or_null("Environment/ParallaxBackground")
		_check(parallax_root != null and parallax_root.get_child_count() >= 4, "%s does not use a multi-layer parallax background." % level_id)
		if parallax_root != null:
			var parallax_scales: Dictionary = {}
			for parallax_layer: Node in parallax_root.get_children():
				_check(parallax_layer is Parallax2D, "%s background contains a non-parallax layer." % level_id)
				if parallax_layer is Parallax2D:
					parallax_scales[(parallax_layer as Parallax2D).scroll_scale] = true
			_check(parallax_scales.size() >= 4, "%s parallax layers do not have distinct depth speeds." % level_id)
		var world_geometry := level.get_node("WorldGeometry")
		if level_id != "level_01":
			for pickup: Node2D in level.get_node("Pickups").get_children():
				_check(_point_is_above_authored_surface(pickup.global_position, world_geometry), "%s pickup %s is not staged above a reachable surface." % [level_id, pickup.name])
		for environment_child: Node in level.get_node("Environment").get_children():
			if "Accent" in str(environment_child.name):
				_check(not (environment_child as CanvasItem).visible, "%s exposes collisionless accent %s as misleading level geometry." % [level_id, environment_child.name])
		for platform: Node in world_geometry.get_children():
			if not platform.is_in_group("Platform"):
				continue
			var platform_collider := platform.get_node("CollisionShape2D") as CollisionShape2D
			_check(platform_collider.one_way_collision and platform_collider.one_way_collision_margin >= 6.0, "%s platform %s blocks jump-through movement." % [level_id, platform.name])
		if level_id == "level_01":
			var floor_fill := world_geometry.get_node("GroundFill") as Sprite2D
			_check(floor_fill != null and str(floor_fill.texture.resource_path).ends_with("dense_floor_wall_pixel_v3.png"), "Level 1 floor wall is not using the dense tiled texture.")
		else:
			for platform: Node in world_geometry.get_children():
				if not platform.is_in_group("Platform"):
					continue
				var platform_visual := platform.get_node("Visual") as Sprite2D
				_check(platform_visual.material is ShaderMaterial, "%s platform %s lost its non-stretching repeat shader." % [level_id, platform.name])
				_check(is_equal_approx(absf(platform_visual.scale.y * (platform as Node2D).scale.y), 40.0 / 724.0), "%s platform %s stretches its tile vertically." % [level_id, platform.name])
		var expected_enemies: int = int(LevelCatalog.get_level(level_id)["threat_quota"])
		var enemy_count := 0
		var boss_count := 0
		for enemy: EnemyController in get_tree().get_nodes_in_group("Enemy"):
			if enemy.enemy_type != "eye_wisp":
				_check(_character_has_authored_support(enemy, world_geometry), "%s enemy %s begins suspended away from collision geometry." % [level_id, enemy.name])
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
			var thornling := level.get_node("Enemies/Thornling01") as EnemyController
			var thornling_visual := thornling.get_node("Visual") as Sprite2D
			_check(thornling_visual.hframes == 4 and thornling_visual.vframes == 1, "Level 1 Thornling pilot lost its four-frame grid.")
			_check(absf(thornling_visual.position.y + 1.5) < 0.01, "Level 1 Thornling pilot lost its 740 px baseline offset.")
			_check(str(thornling_visual.texture.resource_path).ends_with("thornling_idle_strip_normalized_v2.png") or str(thornling_visual.texture.resource_path).ends_with("thornling_run_strip_normalized_v2.png"), "Level 1 Thornling pilot is not using the promoted runtime texture.")
			thornling.thornling_attack_timer = 0.35
			await get_tree().physics_frame
			_check(str(thornling_visual.texture.resource_path).ends_with("thornling_attack_tell_strip_normalized_v2.png"), "Level 1 Thornling did not bind its attack-tell animation.")
			for _attack_frame in range(10):
				await get_tree().physics_frame
			_check(str(thornling_visual.texture.resource_path).ends_with("thornling_attack_strip_normalized_v2.png"), "Level 1 Thornling did not hand off from tell to contact attack.")
			thornling.take_damage(1)
			await get_tree().physics_frame
			_check(str(thornling_visual.texture.resource_path).ends_with("thornling_hurt_strip_normalized_v2.png"), "Level 1 Thornling did not bind its hurt animation.")
			var spitter := level.get_node("Enemies/Spitter") as EnemyController
			var spitter_visual := spitter.get_node("Visual") as Sprite2D
			_check(spitter_visual.hframes == 4 and spitter_visual.vframes == 1, "Level 1 Spitter pilot lost its four-frame grid.")
			_check(absf(spitter_visual.position.y + 1.5) < 0.01, "Level 1 Spitter pilot lost its 740 px baseline offset.")
			_check(str(spitter_visual.texture.resource_path).ends_with("spitter_idle_strip_normalized_v2.png") or str(spitter_visual.texture.resource_path).ends_with("spitter_walk_strip_normalized_v2.png"), "Level 1 Spitter pilot is not using the promoted runtime texture.")
			spitter._shoot(Vector2.RIGHT)
			await get_tree().physics_frame
			_check(str(spitter_visual.texture.resource_path).ends_with("spitter_pressure_tell_strip_normalized_v2.png"), "Level 1 Spitter did not bind its pressure-tell animation.")
			for _spitter_cast_frame in range(10):
				await get_tree().physics_frame
			_check(str(spitter_visual.texture.resource_path).ends_with("spitter_seed_burst_strip_normalized_v2.png"), "Level 1 Spitter did not hand off from pressure tell to seed-burst cast.")
			spitter._shoot(Vector2.RIGHT)
			spitter.spitter_attack_timer = 0.2
			spitter._update_spitter_animation(0.0)
			_check(str(spitter_visual.texture.resource_path).ends_with("spitter_juice_lob_strip_normalized_v2.png"), "Level 1 Spitter did not alternate to its juice-lob cast.")
			spitter.take_damage(1)
			await get_tree().physics_frame
			_check(str(spitter_visual.texture.resource_path).ends_with("spitter_hurt_strip_normalized_v2.png"), "Level 1 Spitter did not bind its hurt animation.")
			_check(str(spitter._get_standard_death_texture().resource_path).ends_with("spitter_death_strip_normalized_v2.png"), "Level 1 Spitter lost its death-strip contract.")
		if level_id == "level_02":
			var forest_tile := level.get_node("Environment/ForestTileAccentA") as Sprite2D
			var forest_corner := level.get_node("Environment/ForestCornerAccent") as Sprite2D
			var forest_floating := level.get_node("Environment/ForestFloatingAccent") as Sprite2D
			_check(forest_tile.hframes == 3 and forest_tile.frame == 1, "Level 2 forest tile accent lost its three-cell strip contract.")
			_check(str(forest_tile.texture.resource_path).ends_with("forest_ground_straight_v1.png"), "Level 2 forest tile accent is not using the biome runtime strip.")
			_check(forest_corner.z_index == -2 and str(forest_corner.texture.resource_path).ends_with("forest_corner_v1.png"), "Level 2 forest corner accent is not using the biome runtime strip.")
			_check(forest_floating.z_index == -2 and str(forest_floating.texture.resource_path).ends_with("forest_platform_floating_v1.png"), "Level 2 forest floating accent is not using the biome runtime strip.")
			var forest_broken := level.get_node("Environment/ForestBrokenAccent") as Sprite2D
			var forest_cap := level.get_node("Environment/ForestCapAccent") as Sprite2D
			var forest_slope := level.get_node("Environment/ForestSlopeAccent") as Sprite2D
			_check(forest_broken.z_index == -2 and str(forest_broken.texture.resource_path).ends_with("forest_ground_broken_v1.png"), "Level 2 forest broken accent is not using the biome tile visual.")
			_check(forest_cap.z_index == -2 and str(forest_cap.texture.resource_path).ends_with("forest_ground_cap_left_v1.png"), "Level 2 forest cap accent is not using the biome tile visual.")
			_check(forest_slope.z_index == -2 and str(forest_slope.texture.resource_path).ends_with("forest_slope_up_v1.png"), "Level 2 forest slope accent is not using the biome tile visual.")
			var maw := level.get_node("Enemies/Maw01") as EnemyController
			var maw_visual := maw.get_node("Visual") as Sprite2D
			_check(maw_visual.hframes == 4 and maw_visual.vframes == 1, "Level 2 Maw pilot lost its four-frame grid.")
			_check(absf(maw_visual.position.y + 1.5) < 0.01, "Level 2 Maw pilot lost its 740 px baseline offset.")
			_check(str(maw_visual.texture.resource_path).ends_with("maw_idle_strip_normalized_v2.png") or str(maw_visual.texture.resource_path).ends_with("maw_move_strip_normalized_v2.png"), "Level 2 Maw pilot is not using the promoted runtime texture.")
			maw.maw_attack_timer = 0.4
			maw._update_maw_animation(0.0)
			_check(str(maw_visual.texture.resource_path).ends_with("maw_anticipation_strip_normalized_v2.png"), "Level 2 Maw did not bind its anticipation animation.")
			maw.maw_attack_timer = 0.2
			maw._update_maw_animation(0.0)
			_check(str(maw_visual.texture.resource_path).ends_with("maw_attack_strip_normalized_v2.png"), "Level 2 Maw did not hand off from anticipation to attack.")
			maw.take_damage(1)
			maw._update_maw_animation(0.0)
			_check(str(maw_visual.texture.resource_path).ends_with("maw_hurt_strip_normalized_v2.png"), "Level 2 Maw did not bind its hurt animation.")
			_check(str(maw._get_standard_death_texture().resource_path).ends_with("maw_death_strip_normalized_v2.png"), "Level 2 Maw lost its death-strip contract.")
			var maw_boss := level.get_node("Enemies/MawBloomSovereign") as EnemyController
			var maw_boss_visual := maw_boss.get_node("Visual") as Sprite2D
			_check(maw_boss_visual.hframes == 4 and maw_boss_visual.vframes == 1, "Level 2 Maw Sovereign pilot lost its four-frame grid.")
			_check(absf(maw_boss_visual.position.y + 20.0) < 0.01, "Level 2 Maw Sovereign pilot lost its 840 px baseline offset.")
			_check(str(maw_boss_visual.texture.resource_path).ends_with("maw_sovereign_idle_armored_strip_normalized_v2.png"), "Level 2 Maw Sovereign pilot did not begin in its armored visual state.")
		if level_id == "level_03":
			var capsule_tile := level.get_node("Environment/CapsuleTileAccentA") as Sprite2D
			var capsule_corner := level.get_node("Environment/CapsuleCornerAccent") as Sprite2D
			var capsule_floating := level.get_node("Environment/CapsuleFloatingAccent") as Sprite2D
			_check(capsule_tile.hframes == 3 and capsule_tile.frame == 1, "Level 3 capsule tile accent lost its three-cell strip contract.")
			_check(str(capsule_tile.texture.resource_path).ends_with("capsule_ground_straight_v1.png"), "Level 3 capsule tile accent is not using the biome runtime strip.")
			_check(capsule_corner.z_index == -2 and str(capsule_corner.texture.resource_path).ends_with("capsule_corner_v1.png"), "Level 3 capsule corner accent is not using the biome runtime strip.")
			_check(capsule_floating.z_index == -2 and str(capsule_floating.texture.resource_path).ends_with("capsule_platform_floating_v1.png"), "Level 3 capsule floating accent is not using the biome runtime strip.")
			var capsule_broken := level.get_node("Environment/CapsuleBrokenAccent") as Sprite2D
			var capsule_cap := level.get_node("Environment/CapsuleCapAccent") as Sprite2D
			var capsule_slope := level.get_node("Environment/CapsuleSlopeAccent") as Sprite2D
			_check(capsule_broken.z_index == -2 and str(capsule_broken.texture.resource_path).ends_with("capsule_ground_broken_v1.png"), "Level 3 capsule broken accent is not using the biome tile visual.")
			_check(capsule_cap.z_index == -2 and str(capsule_cap.texture.resource_path).ends_with("capsule_ground_cap_left_v1.png"), "Level 3 capsule cap accent is not using the biome tile visual.")
			_check(capsule_slope.z_index == -2 and str(capsule_slope.texture.resource_path).ends_with("capsule_slope_up_v1.png"), "Level 3 capsule slope accent is not using the biome tile visual.")
			var banyan_boss := level.get_node("Enemies/BanyanBoss") as EnemyController
			var banyan_visual := banyan_boss.get_node("Visual") as Sprite2D
			_check(banyan_visual.hframes == 4 and banyan_visual.vframes == 1, "Level 3 Possessed Banyan pilot lost its four-frame grid.")
			_check(absf(banyan_visual.position.y + 20.0) < 0.01, "Level 3 Possessed Banyan pilot lost its 840 px baseline offset.")
			_check(str(banyan_visual.texture.resource_path).ends_with("possessed_banyan_idle_armored_strip_normalized_v2.png"), "Level 3 Possessed Banyan pilot did not begin in its armored visual state.")
		var expected_hazard_texture := ""
		var expected_landmark_texture := ""
		var expected_landmark_node := ""
		var expected_prop_texture := ""
		var expected_prop_nodes: Array[String] = []
		var expected_portal_texture := ""
		var expected_platform_texture := ""
		match level_id:
			"level_01":
				expected_landmark_texture = "irrigation_root_tower_v1.png"
				expected_landmark_node = "IrrigationRootLandmark"
				expected_prop_texture = "rice_root_props_v1.png"
				expected_prop_nodes = ["RiceRootPropsA", "RiceRootPropsB"]
			"level_02":
				expected_hazard_texture = "mangosteen_spore_vent_normalized_v1.png"
				expected_platform_texture = "forest_ground_straight_v1.png"
				expected_landmark_texture = "maw_bloom_lair_v1.png"
				expected_landmark_node = "MawBloomLandmark"
				expected_prop_texture = "forest_field_shrine_v1.png"
				expected_prop_nodes = ["ForestFieldShrine"]
				expected_portal_texture = "forest_extraction_beacon_v1.png"
			"level_03":
				expected_hazard_texture = "santol_seed_piston_normalized_v1.png"
				expected_platform_texture = "capsule_ground_straight_v1.png"
				expected_landmark_texture = "capsule_07_seed_harvester_v1.png"
				expected_landmark_node = "Capsule07Landmark"
				expected_portal_texture = "capsule_extraction_beacon_v1.png"
			"level_04":
				expected_hazard_texture = "nutrient_root_eruption_normalized_v2.png"
				expected_platform_texture = "marsh_ground_straight_v2.png"
				expected_landmark_texture = "root_nutrient_conduit_v2.png"
				expected_landmark_node = "NutrientConduitLandmark"
				expected_portal_texture = "marsh_extraction_beacon_v2.png"
			"level_05":
				expected_hazard_texture = "sensory_platform_collapse_normalized_v2.png"
				expected_platform_texture = "nexus_ground_straight_v2.png"
				expected_landmark_texture = "awakened_sensory_nexus_v2.png"
				expected_landmark_node = "AwakenedNexusLandmark"
				expected_portal_texture = "nexus_extraction_beacon_v2.png"
		if not expected_hazard_texture.is_empty():
			var hazard_visual := level.get_node("WorldGeometry/Hazard01/Visual") as Sprite2D
			_check(hazard_visual.hframes == 4 and hazard_visual.vframes == 1, "%s biome hazard did not use a four-frame strip." % level_id)
			_check(str(hazard_visual.texture.resource_path).ends_with(expected_hazard_texture), "%s biome hazard did not bind its generated texture." % level_id)
		if not expected_platform_texture.is_empty():
			var biome_platform: Node2D
			var biome_platform_visual: Sprite2D
			for platform_candidate: Node in level.get_node("WorldGeometry").get_children():
				if platform_candidate.is_in_group("Platform"):
					biome_platform = platform_candidate as Node2D
					biome_platform_visual = platform_candidate.get_node_or_null("Visual") as Sprite2D
					if biome_platform_visual != null:
						break
			_check(biome_platform_visual != null, "%s has no authored collision-platform visual." % level_id)
			if biome_platform_visual != null:
				_check(biome_platform_visual.hframes == 3 and biome_platform_visual.vframes == 1, "%s biome collision platform lost its three-frame tile grid." % level_id)
				_check(str(biome_platform_visual.texture.resource_path).ends_with(expected_platform_texture), "%s collision platform is still using the generic placeholder." % level_id)
				_check(biome_platform_visual.texture_filter == CanvasItem.TEXTURE_FILTER_NEAREST, "%s collision platform lost nearest filtering." % level_id)
				_check(is_equal_approx(biome_platform_visual.scale.x, 100.0 / 724.0), "%s collision platform lost its calibrated tile width." % level_id)
				_check(is_equal_approx(absf(biome_platform_visual.scale.y * biome_platform.scale.y), 40.0 / 724.0), "%s collision platform stretches its tile depth." % level_id)
				_check(biome_platform_visual.material is ShaderMaterial, "%s collision platform lost its horizontal repeat shader." % level_id)
		if not expected_landmark_node.is_empty():
			var landmark := level.get_node_or_null("Environment/%s" % expected_landmark_node) as Sprite2D
			_check(landmark != null, "%s is missing its generated landmark node." % level_id)
			if landmark != null:
				_check(str(landmark.texture.resource_path).ends_with(expected_landmark_texture), "%s landmark did not bind its generated texture." % level_id)
				_check(landmark.z_index == -5, "%s landmark changed its background draw order." % level_id)
				_check(landmark.scale.is_equal_approx(Vector2(0.34, 0.34)), "%s landmark lost its calibrated presentation scale." % level_id)
		if not expected_prop_texture.is_empty():
			for prop_node in expected_prop_nodes:
				var prop_duplicate := level.get_node_or_null("Environment/%s" % prop_node) as Sprite2D
				_check(prop_duplicate != null, "%s is missing generated prop node %s." % [level_id, prop_node])
				if prop_duplicate != null:
					_check(str(prop_duplicate.texture.resource_path).ends_with(expected_prop_texture), "%s prop %s did not bind its generated texture." % [level_id, prop_node])
					_check(prop_duplicate.z_index == -4, "%s prop %s changed its background draw order." % [level_id, prop_node])
		if not expected_portal_texture.is_empty():
			var portal_visual := level.get_node("Portal/Visual") as Sprite2D
			_check(str(portal_visual.texture.resource_path).ends_with(expected_portal_texture), "%s portal did not bind its biome extraction beacon." % level_id)
		_check(enemy_count == expected_enemies, "%s spawned %d/%d enemies." % [level_id, enemy_count, expected_enemies])
		if level_id != "level_01":
			var planned_gates := level.get_node_or_null("EncounterGates")
			var contracts: Array = LevelCatalog.get_level(level_id).get("encounter_contracts", [])
			_check(planned_gates != null and planned_gates.get_child_count() == contracts.size(), "%s does not contain the planned encounter gate count." % level_id)
			var assigned_threats := 0
			if planned_gates != null:
				for gate_index in range(planned_gates.get_child_count()):
					var gate := planned_gates.get_child(gate_index) as EncounterGate
					_check(gate != null, "%s encounter gate %d has the wrong script type." % [level_id, gate_index + 1])
					if gate != null and gate_index < contracts.size():
						var contract: Dictionary = contracts[gate_index]
						_check(gate.encounter_id == str(contract.get("encounter_id", "")), "%s encounter gate %d has the wrong canonical ID." % [level_id, gate_index + 1])
						_check(gate.enemy_paths.size() == int(contract.get("threat_count", -1)), "%s encounter gate %d has the wrong threat count." % [level_id, gate_index + 1])
						_check(gate.assigned_enemies.size() == gate.enemy_paths.size(), "%s encounter gate %d could not resolve every assigned enemy path." % [level_id, gate_index + 1])
						gate.start_encounter()
						_check(gate.started, "%s encounter gate %d could not activate its assigned group." % [level_id, gate_index + 1])
						assigned_threats += gate.enemy_paths.size()
			_check(assigned_threats == expected_enemies, "%s encounter gates do not assign every threat exactly once." % level_id)
		if level_id == "level_04":
			var marsh_tile := level.get_node("Environment/MarshTileAccentA") as Sprite2D
			var marsh_corner := level.get_node("Environment/MarshCornerAccent") as Sprite2D
			var marsh_floating := level.get_node("Environment/MarshFloatingAccent") as Sprite2D
			_check(marsh_tile.hframes == 3 and marsh_tile.frame == 1, "Level 4 marsh tile accent lost its three-cell strip contract.")
			_check(str(marsh_tile.texture.resource_path).ends_with("marsh_ground_straight_v2.png"), "Level 4 marsh tile accent is not using the biome runtime strip.")
			_check(marsh_corner.z_index == -2 and str(marsh_corner.texture.resource_path).ends_with("marsh_corner_v2.png"), "Level 4 marsh corner accent is not using the biome runtime strip.")
			_check(marsh_floating.z_index == -2 and str(marsh_floating.texture.resource_path).ends_with("marsh_platform_floating_v2.png"), "Level 4 marsh floating accent is not using the biome runtime strip.")
			var marsh_broken := level.get_node("Environment/MarshBrokenAccent") as Sprite2D
			var marsh_cap := level.get_node("Environment/MarshCapAccent") as Sprite2D
			var marsh_slope := level.get_node("Environment/MarshSlopeAccent") as Sprite2D
			_check(marsh_broken.z_index == -2 and str(marsh_broken.texture.resource_path).ends_with("marsh_ground_broken_v2.png"), "Level 4 marsh broken accent is not using the biome tile visual.")
			_check(marsh_cap.z_index == -2 and str(marsh_cap.texture.resource_path).ends_with("marsh_ground_cap_left_v2.png"), "Level 4 marsh cap accent is not using the biome tile visual.")
			_check(marsh_slope.z_index == -2 and str(marsh_slope.texture.resource_path).ends_with("marsh_slope_up_v2.png"), "Level 4 marsh slope accent is not using the biome tile visual.")
			var root_skitter := level.get_node("Enemies/RootSkitter01") as EnemyController
			var root_skitter_visual := root_skitter.get_node("Visual") as Sprite2D
			_check(root_skitter_visual.hframes == 4 and root_skitter_visual.vframes == 1, "Level 4 root-skitter pilot lost its four-frame grid.")
			_check(absf(root_skitter_visual.position.y - 2.0) < 0.01, "Level 4 root-skitter pilot lost its 740 px baseline offset.")
			_check(str(root_skitter_visual.texture.resource_path).ends_with("root_skitter_idle_strip_normalized_v2.png") or str(root_skitter_visual.texture.resource_path).ends_with("root_skitter_scuttle_strip_normalized_v2.png"), "Level 4 root-skitter pilot is not using the promoted runtime texture.")
			var pilot_frame := root_skitter_visual.frame
			for _pilot_frame in range(8):
				await get_tree().physics_frame
			_check(root_skitter_visual.frame != pilot_frame or root_skitter_visual.texture.resource_path.ends_with("root_skitter_scuttle_strip_normalized_v2.png"), "Level 4 root-skitter pilot frame did not advance.")
			root_skitter.root_skitter_attack_timer = 0.5
			root_skitter._update_root_skitter_animation(0.0)
			_check(str(root_skitter_visual.texture.resource_path).ends_with("root_skitter_burrow_tell_strip_normalized_v2.png"), "Level 4 Root Skitter did not bind its burrow-tell animation.")
			root_skitter.root_skitter_attack_timer = 0.25
			root_skitter._update_root_skitter_animation(0.0)
			_check(str(root_skitter_visual.texture.resource_path).ends_with("root_skitter_burrow_strip_normalized_v2.png"), "Level 4 Root Skitter did not hand off to its burrow animation.")
			root_skitter.root_skitter_attack_timer = 0.1
			root_skitter._update_root_skitter_animation(0.0)
			_check(str(root_skitter_visual.texture.resource_path).ends_with("root_skitter_emerge_attack_strip_normalized_v2.png"), "Level 4 Root Skitter did not hand off to emerge attack.")
			root_skitter.take_damage(1)
			root_skitter._update_root_skitter_animation(0.0)
			_check(str(root_skitter_visual.texture.resource_path).ends_with("root_skitter_hurt_strip_normalized_v2.png"), "Level 4 Root Skitter did not bind its hurt animation.")
			_check(str(root_skitter._get_standard_death_texture().resource_path).ends_with("root_skitter_death_strip_normalized_v2.png"), "Level 4 Root Skitter lost its death-strip contract.")
			var marsh_spitter := level.get_node("Enemies/MarshSpitter01") as EnemyController
			var marsh_spitter_visual := marsh_spitter.get_node("Visual") as Sprite2D
			_check(marsh_spitter_visual.hframes == 4 and marsh_spitter_visual.vframes == 1, "Level 4 Marsh Spitter did not bind the generated four-frame strip.")
			_check(absf(marsh_spitter_visual.position.y - 3.5) < 0.01, "Level 4 Marsh Spitter lost its calibrated baseline offset.")
			_check(str(marsh_spitter_visual.texture.resource_path).ends_with("spitter_idle_strip_normalized_v2.png"), "Level 4 Marsh Spitter did not bind its marsh Spitter idle art.")
			marsh_spitter._shoot(Vector2.RIGHT)
			marsh_spitter._update_spitter_animation(0.0)
			_check(str(marsh_spitter_visual.texture.resource_path).ends_with("spitter_pressure_tell_strip_normalized_v2.png"), "Level 4 Marsh Spitter did not bind its pressure-tell animation.")
			marsh_spitter.spitter_attack_timer = 0.2
			marsh_spitter._update_spitter_animation(0.0)
			_check(str(marsh_spitter_visual.texture.resource_path).ends_with("spitter_seed_burst_strip_normalized_v2.png"), "Level 4 Marsh Spitter did not hand off to its seed-burst animation.")
			_check(str(marsh_spitter._get_standard_death_texture().resource_path).ends_with("spitter_death_strip_normalized_v2.png"), "Level 4 Marsh Spitter lost its death-strip contract.")
			var root_hydra := level.get_node("Enemies/RootHydra") as EnemyController
			var root_hydra_visual := root_hydra.get_node("Visual") as Sprite2D
			_check(root_hydra_visual.hframes == 4 and root_hydra_visual.vframes == 1, "Level 4 Root Hydra pilot lost its four-frame grid.")
			_check(absf(root_hydra_visual.position.y + 28.0) < 0.01, "Level 4 Root Hydra pilot lost its 840 px baseline offset.")
			_check(str(root_hydra_visual.texture.resource_path).ends_with("root_hydra_idle_strip_normalized_v2.png"), "Level 4 Root Hydra pilot is not using the promoted runtime texture.")
			_check(str(root_hydra._get_standard_death_texture().resource_path).ends_with("root_hydra_death_strip_normalized_v2.png"), "Level 4 Root Hydra lost its promoted death-strip contract.")
			root_hydra.take_damage(1)
			root_hydra._update_root_hydra_animation(0.0)
			_check(str(root_hydra_visual.texture.resource_path).ends_with("root_hydra_hurt_strip_normalized_v2.png"), "Level 4 Root Hydra did not bind its hurt presentation.")
			root_hydra.boss_hurt_timer = 0.0
			root_hydra._update_root_hydra_animation(0.0)
		if level_id == "level_05":
			var nexus_tile := level.get_node("Environment/NexusTileAccentA") as Sprite2D
			var nexus_corner := level.get_node("Environment/NexusCornerAccent") as Sprite2D
			var nexus_floating := level.get_node("Environment/NexusFloatingAccent") as Sprite2D
			_check(nexus_tile.hframes == 3 and nexus_tile.frame == 1, "Level 5 nexus tile accent lost its three-cell strip contract.")
			_check(str(nexus_tile.texture.resource_path).ends_with("nexus_ground_straight_v2.png"), "Level 5 nexus tile accent is not using the biome runtime strip.")
			_check(nexus_corner.z_index == -2 and str(nexus_corner.texture.resource_path).ends_with("nexus_corner_v2.png"), "Level 5 nexus corner accent is not using the biome runtime strip.")
			_check(nexus_floating.z_index == -2 and str(nexus_floating.texture.resource_path).ends_with("nexus_platform_floating_v2.png"), "Level 5 nexus floating accent is not using the biome runtime strip.")
			var nexus_broken := level.get_node("Environment/NexusBrokenAccent") as Sprite2D
			var nexus_cap := level.get_node("Environment/NexusCapAccent") as Sprite2D
			var nexus_slope := level.get_node("Environment/NexusSlopeAccent") as Sprite2D
			_check(nexus_broken.z_index == -2 and str(nexus_broken.texture.resource_path).ends_with("nexus_ground_broken_v2.png"), "Level 5 nexus broken accent is not using the biome tile visual.")
			_check(nexus_cap.z_index == -2 and str(nexus_cap.texture.resource_path).ends_with("nexus_ground_cap_left_v2.png"), "Level 5 nexus cap accent is not using the biome tile visual.")
			_check(nexus_slope.z_index == -2 and str(nexus_slope.texture.resource_path).ends_with("nexus_slope_up_v2.png"), "Level 5 nexus slope accent is not using the biome tile visual.")
			var eye_wisp := level.get_node("Enemies/EyeWisp01") as EnemyController
			var eye_wisp_visual := eye_wisp.get_node("Visual") as Sprite2D
			_check(eye_wisp_visual.hframes == 4 and eye_wisp_visual.vframes == 1, "Level 5 Eye Wisp pilot lost its four-frame grid.")
			_check(absf(eye_wisp_visual.position.y + 16.0) < 0.01, "Level 5 Eye Wisp pilot lost its hover offset.")
			_check(str(eye_wisp_visual.texture.resource_path).ends_with("eye_wisp_hover_strip_normalized_v2.png") or str(eye_wisp_visual.texture.resource_path).ends_with("eye_wisp_fly_strip_normalized_v2.png"), "Level 5 Eye Wisp pilot is not using the promoted runtime texture.")
			eye_wisp.eye_wisp_attack_variant = 0
			eye_wisp.eye_wisp_attack_timer = 0.65
			eye_wisp._update_eye_wisp_animation(0.0)
			_check(str(eye_wisp_visual.texture.resource_path).ends_with("eye_wisp_aim_tell_strip_normalized_v2.png"), "Level 5 Eye Wisp did not bind its aim-tell animation.")
			eye_wisp.eye_wisp_attack_timer = 0.2
			eye_wisp._update_eye_wisp_animation(0.0)
			_check(str(eye_wisp_visual.texture.resource_path).ends_with("eye_wisp_seed_bolt_strip_normalized_v2.png"), "Level 5 Eye Wisp did not bind its seed-bolt animation.")
			eye_wisp.eye_wisp_attack_variant = 1
			eye_wisp.eye_wisp_attack_timer = 0.2
			eye_wisp._update_eye_wisp_animation(0.0)
			_check(str(eye_wisp_visual.texture.resource_path).ends_with("eye_wisp_beam_attack_strip_normalized_v2.png"), "Level 5 Eye Wisp did not bind its beam attack animation.")
			eye_wisp._shoot(Vector2.RIGHT)
			var eye_wisp_projectiles := get_tree().get_nodes_in_group("EnemyProjectile")
			_check(not eye_wisp_projectiles.is_empty(), "Level 5 Eye Wisp did not spawn its projectile.")
			if not eye_wisp_projectiles.is_empty():
				var eye_wisp_projectile := eye_wisp_projectiles.back() as EnemyProjectile
				var eye_wisp_projectile_visual := eye_wisp_projectile.get_node("Visual") as Sprite2D
				_check(eye_wisp_projectile_visual.hframes == 4, "Level 5 Eye Wisp projectile lost its four-frame visual grid.")
				_check(str(eye_wisp_projectile_visual.texture.resource_path).ends_with("eye_wisp_seed_bolt_strip_normalized_v2.png") or str(eye_wisp_projectile_visual.texture.resource_path).ends_with("eye_wisp_beam_attack_strip_normalized_v2.png"), "Level 5 Eye Wisp projectile did not use its fruit-specific visual.")
			eye_wisp.take_damage(1)
			eye_wisp._update_eye_wisp_animation(0.0)
			_check(str(eye_wisp_visual.texture.resource_path).ends_with("eye_wisp_hurt_strip_normalized_v2.png"), "Level 5 Eye Wisp did not bind its hurt animation.")
			eye_wisp.take_damage(4)
			_check(str(eye_wisp_visual.texture.resource_path).ends_with("eye_wisp_death_strip_normalized_v2.png"), "Level 5 Eye Wisp did not play its non-blocking death animation.")
			var root_core_eye := level.get_node("Enemies/RootCoreEye") as EnemyController
			var root_core_eye_visual := root_core_eye.get_node("Visual") as Sprite2D
			_check(root_core_eye_visual.hframes == 4 and root_core_eye_visual.vframes == 1, "Level 5 Root-Core Eye pilot lost its four-frame grid.")
			_check(absf(root_core_eye_visual.position.y + 20.0) < 0.01, "Level 5 Root-Core Eye pilot lost its 840 px baseline offset.")
			_check(str(root_core_eye_visual.texture.resource_path).ends_with("root_core_eye_idle_sealed_normalized_v2.png"), "Level 5 Root-Core Eye pilot did not begin in its sealed visual state.")
			_check(str(root_core_eye._get_standard_death_texture().resource_path).ends_with("root_core_eye_death_strip_normalized_v2.png"), "Level 5 Root-Core Eye lost its promoted death-strip contract.")
			root_core_eye.take_damage(1)
			root_core_eye._update_root_core_eye_animation(0.0)
			_check(str(root_core_eye_visual.texture.resource_path).ends_with("root_core_eye_hurt_strip_normalized_v2.png"), "Level 5 Root-Core Eye did not bind its hurt presentation.")
			root_core_eye.boss_hurt_timer = 0.0
			root_core_eye._update_root_core_eye_animation(0.0)
			var capsule_husk := level.get_node("Enemies/CapsuleHusk01") as EnemyController
			var capsule_husk_visual := capsule_husk.get_node("Visual") as Sprite2D
			_check(capsule_husk_visual.hframes == 4 and capsule_husk_visual.vframes == 1, "Level 5 Capsule Husk pilot lost its four-frame grid.")
			_check(absf(capsule_husk_visual.position.y + 1.5) < 0.01, "Level 5 Capsule Husk pilot lost its 740 px baseline offset.")
			_check(str(capsule_husk_visual.texture.resource_path).ends_with("capsule_husk_idle_strip_normalized_v2.png") or str(capsule_husk_visual.texture.resource_path).ends_with("capsule_husk_move_strip_normalized_v2.png"), "Level 5 Capsule Husk pilot is not using the promoted runtime texture.")
			capsule_husk.capsule_husk_attack_timer = 0.45
			capsule_husk._update_capsule_husk_animation(0.0)
			_check(str(capsule_husk_visual.texture.resource_path).ends_with("capsule_husk_charge_tell_strip_normalized_v2.png"), "Level 5 Capsule Husk did not bind its charge-tell animation.")
			capsule_husk.capsule_husk_attack_timer = 0.2
			capsule_husk._update_capsule_husk_animation(0.0)
			_check(str(capsule_husk_visual.texture.resource_path).ends_with("capsule_husk_core_attack_strip_normalized_v2.png"), "Level 5 Capsule Husk did not hand off to its core attack animation.")
			capsule_husk.take_damage(1)
			capsule_husk._update_capsule_husk_animation(0.0)
			_check(str(capsule_husk_visual.texture.resource_path).ends_with("capsule_husk_hurt_strip_normalized_v2.png"), "Level 5 Capsule Husk did not bind its hurt animation.")
			_check(str(capsule_husk._get_standard_death_texture().resource_path).ends_with("capsule_husk_death_strip_normalized_v2.png"), "Level 5 Capsule Husk lost its death-strip contract.")
			var mixed_elite := level.get_node("Enemies/MixedElite01") as EnemyController
			var mixed_visual := mixed_elite.get_node("Visual") as Sprite2D
			var mixed_accent := mixed_elite.get_node("VisualAccent") as Sprite2D
			_check(mixed_visual.hframes == 4 and mixed_visual.vframes == 1, "Level 5 Mixed Elite body lost its four-frame grid.")
			_check(str(mixed_visual.texture.resource_path).ends_with("capsule_husk_idle_strip_normalized_v2.png"), "Level 5 Mixed Elite body is still using a placeholder or wrong texture.")
			_check(mixed_accent.visible and mixed_accent.hframes == 4 and mixed_accent.vframes == 1, "Level 5 Mixed Elite lost its eye-wisp overlay contract.")
			_check(str(mixed_accent.texture.resource_path).ends_with("eye_wisp_hover_strip_normalized_v2.png"), "Level 5 Mixed Elite overlay is not using the promoted eye-wisp texture.")
			mixed_elite.capsule_husk_attack_timer = 0.45
			mixed_elite._update_capsule_husk_animation(0.0)
			_check(str(mixed_visual.texture.resource_path).ends_with("capsule_husk_charge_tell_strip_normalized_v2.png"), "Level 5 Mixed Elite did not bind its charge-tell body animation.")
			_check(mixed_accent.frame == mixed_visual.frame, "Level 5 Mixed Elite overlay is not synchronized with the body animation.")
			mixed_elite.take_damage(1)
			mixed_elite._update_capsule_husk_animation(0.0)
			_check(str(mixed_visual.texture.resource_path).ends_with("capsule_husk_hurt_strip_normalized_v2.png"), "Level 5 Mixed Elite did not bind its hurt body animation.")
			_check(str(mixed_elite._get_standard_death_texture().resource_path).ends_with("capsule_husk_death_strip_normalized_v2.png"), "Level 5 Mixed Elite lost its death-strip contract.")
		_check(boss_count == 1, "%s did not spawn exactly one boss." % level_id)
		_check(player_count == 1, "%s did not spawn exactly one player." % level_id)
		_check(level.get_node("WorldGeometry").get_child_count() > 0, "%s has no authored world geometry." % level_id)
		_validate_jump_routes(level_id, level.get_node("WorldGeometry"))
		var player := get_tree().get_first_node_in_group("Player") as PlayerController
		var character := CharacterCatalog.get_character(GameManager.selected_character_id)
		var expected_attack := int(character["attack_damage"]) + SaveManager.get_upgrade_level("blade")
		_check(player.attack_damage == expected_attack, "%s did not apply base attack upgrades." % level_id)
		if level_id == "level_01":
			player._start_attack()
			await get_tree().physics_frame
			_check(player.attack_vfx.visible, "Level 1 player attack did not show the generated cutter VFX.")
			_check(player.attack_vfx.sprite_frames.get_frame_count(&"swing") == 4, "Level 1 cutter swing VFX lost its four-frame strip.")
			for _vfx_frame in range(24):
				await get_tree().physics_frame
			_check(not player.attack_vfx.visible, "Level 1 player attack VFX did not hide after playback.")
			var vfx_enemy := get_tree().get_nodes_in_group("Enemy").filter(func(node: Node) -> bool: return node is EnemyController and not node.is_boss)[0] as EnemyController
			vfx_enemy.take_damage(1, Vector2.RIGHT)
			await get_tree().physics_frame
			_check(vfx_enemy.hit_vfx.visible, "Level 1 enemy damage did not show the generated contact VFX.")
			_check(vfx_enemy.hit_vfx.sprite_frames.get_frame_count(&"contact") == 4, "Enemy contact VFX lost its four-frame strip.")
			var expected_enemy_vfx := "thornling_contact_hit_normalized_v2.png" if vfx_enemy.enemy_type == "thornling" else "damage_organic_hit_normalized_v1.png"
			_check(str(vfx_enemy.hit_vfx.sprite_frames.get_frame_texture(&"contact", 0).atlas.resource_path).ends_with(expected_enemy_vfx), "Enemy contact VFX did not use its generated fruit-specific strip.")
			player.take_damage(1, Vector2.LEFT)
			await get_tree().physics_frame
			_check(player.player_hit_vfx.visible, "Player damage did not show the generated player-hit VFX.")
			_check(player.player_hit_vfx.sprite_frames.get_frame_count(&"hit") == 4, "Player-hit VFX lost its four-frame strip.")
			player.show_status_vfx()
			await get_tree().physics_frame
			_check(player.status_vfx.visible, "Hazard status did not show the generated contamination VFX.")
			_check(player.status_vfx.sprite_frames.get_frame_count(&"contamination") == 4, "Contamination VFX lost its four-frame strip.")
			for _damage_cooldown_frame in range(55):
				await get_tree().physics_frame
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
		var boss_death_texture := boss._get_standard_death_texture()
		if boss_death_texture != null:
			_check(str(boss_death_texture.resource_path).contains("death_strip_normalized_v2.png"), "%s boss death texture is not a promoted runtime strip." % level_id)
			_check(boss._get_death_frame_count() == (3 if boss.enemy_type == "maw_sovereign_boss" or boss.enemy_type == "banyan_boss" else 4), "%s boss death strip frame count does not match its native grid." % level_id)
		if level_id == "level_01":
			var thorn_preview_visual := boss.get_node("Visual") as Sprite2D
			_check(str(thorn_preview_visual.texture.resource_path).ends_with("thorn_matriarch_idle_armored_strip_normalized_v2.png"), "Level 1 Thorn Matriarch preview did not begin in its armored visual state.")
		_check(GameManager.current_boss_phase == boss.boss_phase and GameManager.current_boss_phase_count == boss.boss_phase_count, "%s boss preview exposed the wrong phase contract." % level_id)
		var level_hud := level.get_node("HUD") as GameHUD
		_check(int(level_hud.boss_health.value) == boss.health.current_health and int(level_hud.boss_health.max_value) == boss.health.max_health, "%s boss preview exposed stale health." % level_id)
		var expected_boss_frame: String = str({
			"thorn_matriarch": "thorn_matriarch_boss_hud_frame_v1.png",
			"maw_bloom_sovereign": "maw_sovereign_boss_hud_frame_v1.png",
			"possessed_banyan": "possessed_banyan_boss_hud_frame_v1.png",
			"root_hydra": "root_hydra_boss_hud_frame_v1.png",
			"root_core_eye": "root_core_eye_boss_hud_frame_v1.png",
		}.get(str(current_level_data.get("boss_id", "")), ""))
		var frame_texture := level_hud.boss_frame.texture as Texture2D
		_check(frame_texture != null and str(frame_texture.resource_path).ends_with(expected_boss_frame), "%s boss HUD did not bind its generated frame." % level_id)
		_check(level_hud.boss_panel.size.x >= 600.0 and level_hud.boss_panel.size.y >= 180.0, "%s boss HUD frame panel is too small for its aspect-safe art." % level_id)
		await _drain_dialogue(dialogue)
		_check(boss.combat_active and pattern_runner.active, "%s boss did not activate after its introduction completed." % level_id)
		_check(pattern_runner.active, "%s boss projectile runner did not activate." % level_id)
		_check(pattern_runner.projectile_cap == int(LevelCatalog.get_level(level_id)["projectile_cap"]), "%s boss projectile runner ignored its cap." % level_id)
		for _frame in range(50):
			await get_tree().physics_frame
		_check(pattern_runner.get_active_projectile_count() > 0, "%s boss did not emit its opening projectile pattern." % level_id)
		_assert_boss_projectile_visual(pattern_runner, str(pattern_runner.current_pattern.get("pattern_id", "")), level_id)
		if pattern_runner.get_active_projectile_count() > 0:
			var opening_projectile := pattern_runner.active_projectiles[0] as EnemyProjectile
			var opening_visual := opening_projectile.get_node("Visual") as Sprite2D
			var expected_projectile_visual: String = str({
				"level_01": "hair_thorn_spin_strip_normalized_v2.png",
				"level_02": "spore_pod_fall_strip_normalized_v2.png",
				"level_03": "jackfruit_seed_fall_strip_normalized_v2.png",
				"level_04": "root_hydra_nipa_wedge_bolt_normalized_v2.png",
				"level_05": "root_core_eye_spiral_seed_eye_orb_normalized_v2.png",
			}.get(level_id, ""))
			_check(opening_visual.hframes == 4 and opening_visual.vframes == 1, "%s boss projectile lost its four-frame visual grid." % level_id)
			_check(str(opening_visual.texture.resource_path).ends_with(expected_projectile_visual), "%s boss did not bind its fruit-specific opening projectile visual." % level_id)
			_check(float(opening_visual.scale.x) > 0.009, "%s boss projectile visual scale is too small for gameplay readability." % level_id)
		if level_id == "level_01":
			var thorn_cast_visual := boss.get_node("Visual") as Sprite2D
			boss._on_pattern_telegraph_started("thorn_fan_three_way")
			boss._update_thorn_matriarch_animation(0.0)
			_check(str(thorn_cast_visual.texture.resource_path).ends_with("thorn_matriarch_sweep_tell_strip_normalized_v2.png"), "Level 1 Thorn Matriarch did not show its sweep telegraph before the opening cast.")
			boss._on_pattern_started("thorn_fan_three_way")
			boss._update_thorn_matriarch_animation(0.0)
			_check(str(thorn_cast_visual.texture.resource_path).ends_with("thorn_matriarch_fan_cast_strip_normalized_v2.png"), "Level 1 Thorn Matriarch did not bind its fan-cast animation to the opening pattern.")
		if level_id == "level_02":
			var maw_cast_visual := boss.get_node("Visual") as Sprite2D
			_check(str(maw_cast_visual.texture.resource_path).ends_with("maw_sovereign_spore_cast_strip_normalized_v2.png"), "Level 2 Maw Sovereign did not bind its spore-cast animation to the opening pattern.")
		if level_id == "level_03":
			var banyan_cast_visual := boss.get_node("Visual") as Sprite2D
			_check(str(banyan_cast_visual.texture.resource_path).ends_with("possessed_banyan_seed_column_cast_strip_normalized_v2.png"), "Level 3 Possessed Banyan did not bind its seed-column cast animation to the opening pattern.")
		if level_id == "level_04":
			var hydra_cast_visual := boss.get_node("Visual") as Sprite2D
			_check(str(hydra_cast_visual.texture.resource_path).ends_with("root_hydra_crossfire_cast_strip_normalized_v2.png"), "Level 4 Root Hydra did not bind its crossfire cast animation to the opening pattern.")
		if level_id == "level_05":
			var root_core_cast_visual := boss.get_node("Visual") as Sprite2D
			_check(str(root_core_cast_visual.texture.resource_path).ends_with("root_core_eye_spiral_cast_strip_normalized_v2.png"), "Level 5 Root-Core Eye did not bind its spiral cast animation to the opening pattern.")
			var pilot_projectile := pattern_runner.active_projectiles[0] as EnemyProjectile
			var pilot_projectile_visual := pilot_projectile.get_node("Visual") as Sprite2D
			_check(pilot_projectile_visual.hframes == 4 and pilot_projectile_visual.vframes == 1, "Level 5 Root-Core Eye projectile pilot lost its four-frame grid.")
			_check(str(pilot_projectile_visual.texture.resource_path).ends_with("root_core_eye_spiral_seed_eye_orb_normalized_v2.png"), "Level 5 Root-Core Eye projectile did not use the promoted spiral seed-eye texture.")
			_check(absf(pilot_projectile_visual.scale.x - 0.016) < 0.001, "Level 5 Root-Core Eye projectile pilot lost its calibrated scale.")
		_check(pattern_runner.get_active_projectile_count() <= pattern_runner.projectile_cap, "%s boss exceeded its projectile cap." % level_id)
		_check(pattern_runner.all_projectiles.size() <= pattern_runner.projectile_cap, "%s boss projectile pool exceeded its cap." % level_id)
		if boss.boss_phase_count > 1 and level_id != "level_01":
			var phase_damage := ceili(float(boss.health.max_health) / float(boss.boss_phase_count))
			for expected_phase in range(2, boss.boss_phase_count + 1):
				boss.take_damage(phase_damage, Vector2.RIGHT)
				await get_tree().process_frame
				_check(boss.boss_phase == expected_phase and pattern_runner.current_phase == expected_phase, "%s did not enter boss phase %d." % [level_id, expected_phase])
				if level_id == "level_05" and expected_phase == 2:
					var phase_visual := boss.get_node("Visual") as Sprite2D
					_check(str(phase_visual.texture.resource_path).ends_with("root_core_eye_aimed_seed_cast_strip_normalized_v2.png"), "Level 5 Root-Core Eye did not bind its phase-2 aimed-seed cast visual.")
				if level_id == "level_02" and expected_phase == 2:
					var maw_phase_visual := boss.get_node("Visual") as Sprite2D
					_check(str(maw_phase_visual.texture.resource_path).ends_with("maw_sovereign_rotating_volley_cast_strip_normalized_v2.png"), "Level 2 Maw Sovereign did not bind its phase-2 rotating-volley visual.")
				if level_id == "level_03" and expected_phase == 2:
					var banyan_phase_visual := boss.get_node("Visual") as Sprite2D
					_check(str(banyan_phase_visual.texture.resource_path).ends_with("possessed_banyan_diagonal_root_cast_strip_normalized_v2.png"), "Level 3 Possessed Banyan did not bind its phase-2 diagonal-root visual.")
				if level_id == "level_04" and expected_phase == 2:
					var hydra_phase_visual := boss.get_node("Visual") as Sprite2D
					_check(str(hydra_phase_visual.texture.resource_path).ends_with("root_hydra_radial_ring_cast_strip_normalized_v2.png"), "Level 4 Root Hydra did not bind its phase-2 radial-ring cast visual.")
				if level_id == "level_02" and expected_phase == 2:
					var maw_rotating_visual := boss.get_node("Visual") as Sprite2D
					_check(str(maw_rotating_visual.texture.resource_path).ends_with("maw_sovereign_rotating_volley_cast_strip_normalized_v2.png"), "Level 2 Maw Sovereign did not bind its rotating-volley cast animation.")
				if level_id == "level_02" and expected_phase == 3:
					var maw_aimed_visual := boss.get_node("Visual") as Sprite2D
					_check(str(maw_aimed_visual.texture.resource_path).ends_with("maw_sovereign_aimed_volley_cast_strip_normalized_v2.png"), "Level 2 Maw Sovereign did not bind its aimed-volley cast animation.")
				if level_id == "level_03" and expected_phase == 2:
					var banyan_diagonal_visual := boss.get_node("Visual") as Sprite2D
					_check(str(banyan_diagonal_visual.texture.resource_path).ends_with("possessed_banyan_diagonal_root_cast_strip_normalized_v2.png"), "Level 3 Possessed Banyan did not bind its diagonal-root cast animation.")
				if level_id == "level_05" and expected_phase == 3:
					var curtain_visual := boss.get_node("Visual") as Sprite2D
					_check(str(curtain_visual.texture.resource_path).ends_with("root_core_eye_bract_curtain_cast_strip_normalized_v2.png"), "Level 5 Root-Core Eye did not bind its phase-3 bract-curtain cast visual.")
				_check(pattern_runner.get_active_projectile_count() == 0, "%s phase %d did not clear active projectiles." % [level_id, expected_phase])
				_check(int(pattern_runner.current_pattern.get("phase", 0)) == expected_phase, "%s phase %d selected a pattern from the wrong phase." % [level_id, expected_phase])
				for _phase_frame in range(50):
					await get_tree().physics_frame
				_check(pattern_runner.get_active_projectile_count() > 0, "%s phase %d did not emit its projectile pattern." % [level_id, expected_phase])
				_assert_boss_projectile_visual(pattern_runner, str(pattern_runner.current_pattern.get("pattern_id", "")), "%s phase %d" % [level_id, expected_phase])
				if level_id == "level_04":
					var hydra_cast_visual := boss.get_node("Visual") as Sprite2D
					var expected_hydra_cast := "root_hydra_radial_ring_cast_strip_normalized_v2.png" if expected_phase == 2 else "root_hydra_lane_wall_cast_strip_normalized_v2.png"
					_check(str(hydra_cast_visual.texture.resource_path).ends_with(expected_hydra_cast), "Level 4 Root Hydra did not bind its phase-%d cast animation." % expected_phase)
				_check(pattern_runner.get_active_projectile_count() <= pattern_runner.projectile_cap, "%s phase %d exceeded its projectile cap." % [level_id, expected_phase])
		if level_id == "level_01":
			_check(boss.boss_phase == 1 and pattern_runner.current_phase == 1, "%s boss did not begin in phase 1." % level_id)
			var thorn_matriarch_visual := boss.get_node("Visual") as Sprite2D
			_check(thorn_matriarch_visual.hframes == 4 and thorn_matriarch_visual.vframes == 1, "Level 1 Thorn Matriarch pilot lost its four-frame grid.")
			_check(absf(thorn_matriarch_visual.position.y + 20.0) < 0.01, "Level 1 Thorn Matriarch pilot lost its 840 px baseline offset.")
			_check(str(thorn_matriarch_visual.texture.resource_path).ends_with("thorn_matriarch_fan_cast_strip_normalized_v2.png"), "Level 1 Thorn Matriarch pilot did not bind its opening fan-cast visual.")
			_check(int(pattern_runner.current_pattern.get("phase", 0)) == 1, "%s boss opened with a pattern from the wrong phase." % level_id)
			boss.take_damage(1, Vector2.RIGHT)
			boss._update_thorn_matriarch_animation(0.0)
			_check(str(thorn_matriarch_visual.texture.resource_path).ends_with("thorn_matriarch_hurt_strip_normalized_v2.png"), "Level 1 Thorn Matriarch did not bind its hurt animation.")
			for _thorn_hurt_frame in range(15):
				await get_tree().physics_frame
			var phase_damage := ceili(float(boss.health.max_health) / float(boss.boss_phase_count))
			boss.take_damage(phase_damage, Vector2.RIGHT)
			await get_tree().process_frame
			_check(boss.boss_phase == 2 and pattern_runner.current_phase == 2, "%s boss health threshold did not activate phase 2." % level_id)
			_check(str(thorn_matriarch_visual.texture.resource_path).ends_with("thorn_matriarch_phase_break_strip_normalized_v2.png"), "Level 1 Thorn Matriarch did not show its phase-break animation.")
			_check(GameManager.current_boss_phase == 2 and GameManager.current_boss_phase_count == boss.boss_phase_count, "%s boss phase state did not propagate through GameManager." % level_id)
			_check(pattern_runner.get_active_projectile_count() == 0, "%s phase transition did not clear active projectiles." % level_id)
			_check(int(pattern_runner.current_pattern.get("phase", 0)) == 2, "%s phase 2 selected a pattern from the wrong phase." % level_id)
			# Advance the presentation timer deterministically; the live runner may
			# already have moved into its next cast by the time several frames pass.
			boss.thorn_matriarch_phase_break_timer = 0.0
			boss.boss_hurt_timer = 0.0
			boss.thorn_matriarch_action = &"phase_break"
			boss._update_thorn_matriarch_animation(0.0)
			_check(str(thorn_matriarch_visual.texture.resource_path).ends_with("thorn_matriarch_sweep_tell_strip_normalized_v2.png"), "Level 1 Thorn Matriarch did not return from phase break to its sweep telegraph.")
			for _phase_frame in range(50):
				await get_tree().physics_frame
			_check(pattern_runner.get_active_projectile_count() > 0, "%s phase 2 did not emit its projectile pattern." % level_id)
			_assert_boss_projectile_visual(pattern_runner, str(pattern_runner.current_pattern.get("pattern_id", "")), "%s phase 2" % level_id)
			if level_id == "level_01":
				var thorn_phase_cast_visual := boss.get_node("Visual") as Sprite2D
				_check(str(thorn_phase_cast_visual.texture.resource_path).ends_with("thorn_matriarch_mine_cast_strip_normalized_v2.png"), "Level 1 Thorn Matriarch did not bind its lane cast animation to the phase-2 pattern.")
			_check(pattern_runner.get_active_projectile_count() <= pattern_runner.projectile_cap, "%s phase 2 exceeded its projectile cap." % level_id)
			boss.set_combat_active(false)
			await get_tree().process_frame
			_check(get_tree().get_nodes_in_group("BossProjectile").is_empty(), "%s boss projectiles survived combat shutdown." % level_id)
			boss.set_combat_active(true)
			for _frame in range(50):
				await get_tree().physics_frame
			_check(pattern_runner.get_active_projectile_count() > 0, "%s boss projectile runner did not resume after reactivation." % level_id)
			_assert_boss_projectile_visual(pattern_runner, str(pattern_runner.current_pattern.get("pattern_id", "")), "%s resumed phase" % level_id)
		boss.take_damage(999, Vector2.RIGHT)
		await get_tree().process_frame
		await get_tree().process_frame
		_check(get_tree().get_nodes_in_group("BossProjectile").is_empty(), "%s boss projectiles survived boss defeat." % level_id)
		_check(GameManager.mission_phase == GameManager.PHASE_EXTRACTION, "%s did not enter extraction." % level_id)
		_check(portal != null and portal.active, "%s exit portal did not activate after boss defeat." % level_id)
		if level_id == "level_05" and portal != null:
			portal._on_body_entered(player)
			await get_tree().process_frame
			_check(not GameManager.run_active, "Level 5 extraction did not finish the campaign run.")
			_check(level_hud.pending_complete, "Level 5 extraction did not wait for its debrief sequence.")
			var debrief_id := str(current_level_data.get("debrief_sequence", ""))
			_check(requested_sequences.count(debrief_id) == 1, "Level 5 debrief was not requested exactly once.")
			await _drain_dialogue(dialogue)
			_check(level_hud.modal.visible, "Level 5 campaign-complete modal did not open after debrief.")
			_check(level_hud.modal_title.text == LocalizationManager.text("HUD_CAMPAIGN_COMPLETE"), "Level 5 did not show the campaign-complete title.")
			_check("level_05" in SaveManager.profile.get("completed_levels", []), "Level 5 completion was not persisted.")
			_check(int(SaveManager.profile.get("story_stage", 0)) >= 5, "Campaign story stage did not reach the ending act.")
			_check(StoryManager.has_seen(debrief_id), "Level 5 debrief one-shot state was not recorded.")
		StoryManager.sequence_requested.disconnect(capture_sequence)
		level.queue_free()
		await get_tree().process_frame
		await get_tree().process_frame
		await get_tree().process_frame
	GameManager.reset_run()
	get_tree().paused = false


func _assert_boss_projectile_visual(pattern_runner: BossProjectilePatternRunner, pattern_id: String, label: String) -> void:
	var expected_visual: String = str({
		"thorn_fan_three_way": "hair_thorn_spin_strip_normalized_v2.png",
		"thorn_alternating_lanes": "lane_thorn_emerge_strip_normalized_v2.png",
		"maw_spore_rain": "spore_pod_fall_strip_normalized_v2.png",
		"maw_rotating_five_way": "seed_bullet_spin_strip_normalized_v2.png",
		"maw_aimed_seed_burst": "seed_bullet_spin_strip_normalized_v2.png",
		"banyan_seed_columns": "jackfruit_seed_fall_strip_normalized_v2.png",
		"banyan_diagonal_roots": "diagonal_root_line_strip_normalized_v2.png",
		"hydra_head_crossfire": "root_hydra_nipa_wedge_bolt_normalized_v2.png",
		"hydra_offset_rings": "root_hydra_nutrient_ring_orb_normalized_v2.png",
		"hydra_water_lane_walls": "root_hydra_water_lane_eruption_normalized_v2.png",
		"eye_rotating_spirals": "root_core_eye_spiral_seed_eye_orb_normalized_v2.png",
		"eye_aimed_rings": "root_core_eye_pupil_lance_dart_normalized_v2.png",
		"eye_alternating_curtains": "root_core_eye_bract_curtain_blade_normalized_v2.png",
	}.get(pattern_id, ""))
	_check(not expected_visual.is_empty(), "%s selected an unknown projectile visual ID for %s." % [label, pattern_id])
	if pattern_runner.active_projectiles.is_empty():
		_check(false, "%s emitted no projectile to validate its visual binding." % label)
		return
	var projectile := pattern_runner.active_projectiles[0] as EnemyProjectile
	var visual := projectile.get_node("Visual") as Sprite2D
	_check(visual.hframes == 4 and visual.vframes == 1, "%s projectile lost its four-frame visual grid." % label)
	_check(str(visual.texture.resource_path).ends_with(expected_visual), "%s did not bind its canonical projectile visual." % label)
	_check(float(visual.scale.x) > 0.009, "%s projectile visual scale is too small for gameplay readability." % label)


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
	var highest_surface := INF
	var lowest_surface := -INF
	for platform: Node in world_geometry.get_children():
		if not platform.is_in_group("Platform"):
			continue
		var platform_node := platform as Node2D
		var surface_y := platform_node.position.y - 10.0 * platform_node.scale.y
		highest_surface = minf(highest_surface, surface_y)
		lowest_surface = maxf(lowest_surface, surface_y)
	if level_id != "level_01":
		_check(lowest_surface - highest_surface >= 180.0, "%s redesign lost its intended high/low terrain depth." % level_id)
	for route: Array in REQUIRED_JUMP_ROUTES[level_id]:
		var source := world_geometry.get_node(str(route[0])) as Node2D
		var target := world_geometry.get_node(str(route[1])) as Node2D
		var source_surface := source.position.y - 10.0 * source.scale.y
		var target_surface := target.position.y - 10.0 * target.scale.y
		var step_height := source_surface - target_surface
		var horizontal_gap := absf(target.position.x - source.position.x) - 50.0 * absf(source.scale.x) - 50.0 * absf(target.scale.x)
		_check(step_height <= 100.0, "%s route %s -> %s is too high (%.1f px)." % [level_id, route[0], route[1], step_height])
		if level_id != "level_01":
			_check(horizontal_gap <= 165.0, "%s route %s -> %s is too wide (%.1f px edge gap)." % [level_id, route[0], route[1], horizontal_gap])


func _point_is_above_authored_surface(point: Vector2, world_geometry: Node) -> bool:
	for platform: Node in world_geometry.get_children():
		if not platform.is_in_group("Platform"):
			continue
		var platform_collider := platform.get_node_or_null("CollisionShape2D") as CollisionShape2D
		if platform_collider == null or not platform_collider.shape is RectangleShape2D:
			continue
		var shape := platform_collider.shape as RectangleShape2D
		var platform_scale := platform_collider.global_transform.get_scale().abs()
		var half_width := shape.size.x * platform_scale.x * 0.5
		var top_y := platform_collider.global_position.y - shape.size.y * platform_scale.y * 0.5
		var clearance := top_y - point.y
		if absf(point.x - platform_collider.global_position.x) <= half_width and clearance >= 20.0 and clearance <= 80.0:
			return true
	return false


func _character_has_authored_support(character: CharacterBody2D, world_geometry: Node) -> bool:
	var character_collider := character.get_node_or_null("CollisionShape2D") as CollisionShape2D
	if character_collider == null or character_collider.shape == null:
		return false
	var character_half_height := 0.0
	if character_collider.shape is RectangleShape2D:
		character_half_height = (character_collider.shape as RectangleShape2D).size.y * 0.5
	elif character_collider.shape is CapsuleShape2D:
		character_half_height = (character_collider.shape as CapsuleShape2D).height * 0.5
	elif character_collider.shape is CircleShape2D:
		character_half_height = (character_collider.shape as CircleShape2D).radius
	character_half_height *= character_collider.global_transform.get_scale().abs().y
	var bottom_y := character_collider.global_position.y + character_half_height
	for platform: Node in world_geometry.get_children():
		if not platform.is_in_group("Platform"):
			continue
		var platform_collider := platform.get_node_or_null("CollisionShape2D") as CollisionShape2D
		if platform_collider == null or not platform_collider.shape is RectangleShape2D:
			continue
		var shape := platform_collider.shape as RectangleShape2D
		var platform_scale := platform_collider.global_transform.get_scale().abs()
		var half_width := shape.size.x * platform_scale.x * 0.5
		var top_y := platform_collider.global_position.y - shape.size.y * platform_scale.y * 0.5
		if absf(character.global_position.x - platform_collider.global_position.x) <= half_width + 6.0 and absf(bottom_y - top_y) <= 1.0:
			return true
	return false


func _check(condition: bool, message: String) -> void:
	if not condition:
		failures.append(message)


func _count_operator_entries(entries: Array, character_id: String) -> int:
	var count := 0
	for entry: Dictionary in entries:
		if str(entry.get("operator_condition", "")) == character_id:
			count += 1
	return count
