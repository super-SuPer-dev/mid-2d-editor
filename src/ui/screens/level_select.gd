extends Control

var selected_level_id: String = LevelCatalog.LEVEL_ORDER[0]


func _ready() -> void:
	AudioManager.play_music(&"main_theme")
	LocalizationManager.language_changed.connect(_refresh_text)
	for level_id in LevelCatalog.LEVEL_ORDER:
		var item := $MissionMarkers.get_node(level_id) as TextureButton
		item.pressed.connect(_select_mission.bind(level_id))
	_refresh_text(LocalizationManager.current_language)
	_select_mission(_first_selectable_level())


func _refresh_text(_locale: String) -> void:
	var operative := CharacterCatalog.get_character(GameManager.selected_character_id)
	$TitlePlate/Title.text = LocalizationManager.text("LEVEL_SELECT_TITLE")
	$Operator.text = LocalizationManager.text("LEVEL_OPERATOR", {"name": LocalizationManager.text(operative["name_key"])})
	$Operator.add_theme_color_override("font_color", operative["color"])
	$Samples.text = LocalizationManager.text("LEVEL_SAMPLES", {"count": int(SaveManager.profile.get("total_crystals", 0))})
	$FooterActions/Back.text = LocalizationManager.text("UI_BACK")
	$FooterActions/Upgrades.text = LocalizationManager.text("LEVEL_BASE_UPGRADES")
	$FooterActions/CharacterUpgrades.text = LocalizationManager.text("LEVEL_OPERATOR_MASTERY")
	var unlocked_count := 0
	for level_id in LevelCatalog.LEVEL_ORDER:
		_configure_mission(level_id)
		if _is_selectable(level_id):
			unlocked_count += 1
	$MissionPath.set_unlocked_count(unlocked_count)
	if _is_selectable(selected_level_id):
		_update_mission_details(selected_level_id)


func _configure_mission(level_id: String) -> void:
	var data := LevelCatalog.get_level(level_id)
	var item := $MissionMarkers.get_node(level_id) as TextureButton
	var selectable := _is_selectable(level_id)
	var completed: bool = level_id in SaveManager.profile.get("completed_levels", [])
	item.disabled = not selectable
	item.tooltip_text = LocalizationManager.text(data["name_key"]) if selectable else LocalizationManager.text("LEVEL_LOCKED")
	item.get_node("Number").text = str(LevelCatalog.get_level_number(level_id))
	var status := item.get_node_or_null("Status") as Label
	if status != null:
		status.text = "★" if completed else (LocalizationManager.text("LEVEL_LOCKED_SHORT") if not selectable else "")
	item.modulate = Color.WHITE if selectable else Color(0.58, 0.58, 0.58, 0.9)


func _select_mission(level_id: String) -> void:
	if not _is_selectable(level_id):
		return
	selected_level_id = level_id
	for mission_id in LevelCatalog.LEVEL_ORDER:
		var marker := $MissionMarkers.get_node(mission_id) as TextureButton
		marker.button_pressed = mission_id == level_id
	_update_mission_details(level_id)


func _update_mission_details(level_id: String) -> void:
	var data := LevelCatalog.get_level(level_id)
	var completed: bool = level_id in SaveManager.profile.get("completed_levels", [])
	var best := int(SaveManager.profile.get("best_crystals", {}).get(level_id, 0))
	var number := "%02d" % LevelCatalog.get_level_number(level_id)
	$MissionDetails/Content/MissionTitle.text = LocalizationManager.text("LEVEL_TITLE", {"number": number, "name": LocalizationManager.text(data["name_key"])})
	$MissionDetails/Content/Description.text = "%s\n%s" % [LocalizationManager.text(data["subtitle_key"]), LocalizationManager.text(data["location_key"])]
	$MissionDetails/Content/Progress.text = LocalizationManager.text("LEVEL_COMPLETED_BEST", {"count": best}) if completed else LocalizationManager.text("LEVEL_OBJECTIVE", {"count": int(data["threat_quota"])})
	$MissionDetails/Content/MissionTitle.add_theme_color_override("font_color", data["accent"])
	$StartMission.disabled = false
	$StartMission.text = LocalizationManager.text("LEVEL_START", {"number": number})


func _first_selectable_level() -> String:
	for level_id in LevelCatalog.LEVEL_ORDER:
		if _is_selectable(level_id):
			return level_id
	return LevelCatalog.LEVEL_ORDER[0]


func _is_selectable(level_id: String) -> bool:
	return bool(LevelCatalog.get_level(level_id).get("implemented", false)) and SaveManager.is_level_unlocked(level_id)


func _on_start_pressed() -> void:
	AudioManager.play_click()
	SceneManager.play_level(selected_level_id)


func _on_back_pressed() -> void:
	AudioManager.play_click()
	SceneManager.go_to_main_menu()


func _on_operator_pressed() -> void:
	AudioManager.play_click()
	SceneManager.go_to_character_select()


func _on_upgrades_pressed() -> void:
	AudioManager.play_click()
	SceneManager.go_to_upgrades()


func _on_character_upgrades_pressed() -> void:
	AudioManager.play_click()
	SceneManager.go_to_character_upgrades()
