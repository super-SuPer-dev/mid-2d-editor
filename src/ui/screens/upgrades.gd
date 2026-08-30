extends Control

const UPGRADE_DATA := {
	"blade": {"name_key": "UPGRADE_BLADE_NAME", "description_key": "UPGRADE_BLADE_DESC", "color": Color("91bd45")},
	"engine": {"name_key": "UPGRADE_ENGINE_NAME", "description_key": "UPGRADE_ENGINE_DESC", "color": Color("c58b43")},
	"armor": {"name_key": "UPGRADE_ARMOR_NAME", "description_key": "UPGRADE_ARMOR_DESC", "color": Color("6e91a8")},
}


func _ready() -> void:
	LocalizationManager.language_changed.connect(_refresh_text)
	resized.connect(_refresh_wrapped_descriptions)
	for upgrade_id in UPGRADE_DATA:
		var row := $Layout/Cards.get_node(upgrade_id)
		var data: Dictionary = UPGRADE_DATA[upgrade_id]
		row.get_node("Row/Badge").color = data["color"]
		row.get_node("Row/Copy/Name").add_theme_color_override("font_color", data["color"])
		row.get_node("Row/Purchase").pressed.connect(_purchase.bind(upgrade_id))
	_refresh_text(LocalizationManager.current_language)


func _refresh_text(_locale: String = "") -> void:
	$Layout/Header/Back.text = LocalizationManager.text("UI_BACK_MAP")
	$Layout/Header/Title.text = LocalizationManager.text("UPGRADES_TITLE")
	$Layout/Intro.text = LocalizationManager.text("UPGRADES_INTRO")
	$Layout/Header/Samples.text = LocalizationManager.text("UPGRADE_SAMPLES", {"count": int(SaveManager.profile.get("total_crystals", 0))})
	for upgrade_id in UPGRADE_DATA:
		var row := $Layout/Cards.get_node(upgrade_id)
		var data: Dictionary = UPGRADE_DATA[upgrade_id]
		row.get_node("Row/Copy/Name").text = LocalizationManager.text(data["name_key"])
		_set_word_wrapped_text(row.get_node("Row/Copy/Description"), LocalizationManager.text(data["description_key"]), 320.0)
		var level := SaveManager.get_upgrade_level(upgrade_id)
		row.get_node("Row/Level").text = LocalizationManager.text("UPGRADE_LEVEL", {"level": level})
		var button: Button = row.get_node("Row/Purchase")
		if level >= 5:
			button.text = LocalizationManager.text("UPGRADE_MAX")
			button.disabled = true
		else:
			var cost := SaveManager.get_upgrade_cost(upgrade_id)
			button.text = LocalizationManager.text("UPGRADE_PURCHASE", {"cost": cost})
			button.disabled = int(SaveManager.profile.get("total_crystals", 0)) < cost
	call_deferred("_refresh_wrapped_descriptions")


func _refresh_wrapped_descriptions() -> void:
	for upgrade_id in UPGRADE_DATA:
		var row := $Layout/Cards.get_node(upgrade_id)
		var data: Dictionary = UPGRADE_DATA[upgrade_id]
		_set_word_wrapped_text(row.get_node("Row/Copy/Description"), LocalizationManager.text(data["description_key"]), 320.0)


func _set_word_wrapped_text(label: Label, source_text: String, fallback_width: float) -> void:
	label.autowrap_mode = TextServer.AUTOWRAP_OFF
	var available_width := maxf(maxf(label.size.x, label.custom_minimum_size.x), fallback_width)
	var font := label.get_theme_font("font")
	var font_size := label.get_theme_font_size("font_size")
	var lines := PackedStringArray()
	var current_line := ""
	for word: String in source_text.split(" ", false):
		var candidate := word if current_line.is_empty() else "%s %s" % [current_line, word]
		if current_line.is_empty() or font.get_string_size(candidate, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x <= available_width:
			current_line = candidate
		else:
			lines.append(current_line)
			current_line = word
	if not current_line.is_empty():
		lines.append(current_line)
	label.text = "\n".join(lines)


func _purchase(upgrade_id: String) -> void:
	AudioManager.play_click()
	SaveManager.purchase_upgrade(upgrade_id)
	_refresh_text()


func _on_back_pressed() -> void:
	AudioManager.play_click()
	SceneManager.go_to_level_select()
