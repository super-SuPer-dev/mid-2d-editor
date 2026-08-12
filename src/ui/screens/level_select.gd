extends Control


func _ready() -> void:
	var operative := CharacterCatalog.get_character(GameManager.selected_character_id)
	$Layout/Header/Operator.text = "เจ้าหน้าที่: %s" % operative["name"]
	$Layout/Header/Operator.add_theme_color_override("font_color", operative["color"])
	$Layout/Footer/Samples.text = "ตัวอย่างต่างดาว: %d" % int(SaveManager.profile.get("total_crystals", 0))
	for level_id in LevelCatalog.LEVEL_ORDER:
		_configure_mission(level_id)


func _configure_mission(level_id: String) -> void:
	var data := LevelCatalog.get_level(level_id)
	var item: Button = $Layout/Missions.get_node(level_id)
	var unlocked := SaveManager.is_level_unlocked(level_id)
	var completed: bool = level_id in SaveManager.profile.get("completed_levels", [])
	var best := int(SaveManager.profile.get("best_crystals", {}).get(level_id, 0))
	item.text = "%02d  %s\n%s     %s" % [LevelCatalog.get_level_number(level_id), data["name"], data["subtitle"], "ดีที่สุด %d" % best if completed else data["location"]]
	item.disabled = not unlocked
	item.add_theme_color_override("font_color", data["accent"])
	if not unlocked:
		item.text = "%02d  ปิดลับ\nทำภารกิจก่อนหน้าให้สำเร็จเพื่อปลดล็อก" % LevelCatalog.get_level_number(level_id)
	item.pressed.connect(_play_level.bind(level_id))


func _play_level(level_id: String) -> void:
	AudioManager.play_click()
	SceneManager.play_level(level_id)


func _on_back_pressed() -> void:
	AudioManager.play_click()
	SceneManager.go_to_main_menu()


func _on_operator_pressed() -> void:
	AudioManager.play_click()
	SceneManager.go_to_character_select()


func _on_upgrades_pressed() -> void:
	AudioManager.play_click()
	SceneManager.go_to_upgrades()
