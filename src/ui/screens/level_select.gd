extends Control

var selected_level_id: String = LevelCatalog.LEVEL_ORDER[0]


func _ready() -> void:
	var operative := CharacterCatalog.get_character(GameManager.selected_character_id)
	$Operator.text = "เจ้าหน้าที่: %s" % operative["name"]
	$Operator.add_theme_color_override("font_color", operative["color"])
	$Samples.text = "ตัวอย่างต่างดาว  %d" % int(SaveManager.profile.get("total_crystals", 0))
	var unlocked_count := 0
	for level_id in LevelCatalog.LEVEL_ORDER:
		_configure_mission(level_id)
		if SaveManager.is_level_unlocked(level_id):
			unlocked_count += 1
	$MissionPath.set_unlocked_count(unlocked_count)
	_select_mission(LevelCatalog.LEVEL_ORDER[0])


func _configure_mission(level_id: String) -> void:
	var data := LevelCatalog.get_level(level_id)
	var item: TextureButton = $MissionMarkers.get_node(level_id)
	var unlocked := SaveManager.is_level_unlocked(level_id)
	var completed: bool = level_id in SaveManager.profile.get("completed_levels", [])
	item.disabled = not unlocked
	item.tooltip_text = data["name"] if unlocked else "ทำภารกิจก่อนหน้าเพื่อปลดล็อก"
	item.get_node("Number").text = str(LevelCatalog.get_level_number(level_id))
	item.get_node("Status").text = "★" if completed else ("ล็อก" if not unlocked else "")
	item.modulate = Color.WHITE if unlocked else Color(0.58, 0.58, 0.58, 0.9)
	item.pressed.connect(_select_mission.bind(level_id))


func _select_mission(level_id: String) -> void:
	if not SaveManager.is_level_unlocked(level_id):
		return
	selected_level_id = level_id
	for mission_id in LevelCatalog.LEVEL_ORDER:
		var marker: TextureButton = $MissionMarkers.get_node(mission_id)
		marker.button_pressed = mission_id == level_id
	var data := LevelCatalog.get_level(level_id)
	var completed: bool = level_id in SaveManager.profile.get("completed_levels", [])
	var best := int(SaveManager.profile.get("best_crystals", {}).get(level_id, 0))
	$MissionDetails/Content/MissionTitle.text = "ด่าน %02d • %s" % [LevelCatalog.get_level_number(level_id), data["name"]]
	$MissionDetails/Content/Description.text = "%s\n%s" % [data["subtitle"], data["location"]]
	$MissionDetails/Content/Progress.text = "สำเร็จแล้ว • ดีที่สุด %d ตัวอย่าง" % best if completed else "เป้าหมาย • กำจัดศัตรู %d ตัว" % int(data["required_kills"])
	$MissionDetails/Content/MissionTitle.add_theme_color_override("font_color", data["accent"])
	$StartMission.disabled = false
	$StartMission.text = "เริ่มภารกิจ  %02d" % LevelCatalog.get_level_number(level_id)


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
