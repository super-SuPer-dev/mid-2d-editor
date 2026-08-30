extends Control


func _ready() -> void:
	LocalizationManager.language_changed.connect(_refresh_text)
	for character_id in CharacterCatalog.get_ids():
		var card := $Layout/Cards.get_node(character_id)
		var data := CharacterCatalog.get_character(character_id)
		var portrait: TextureRect = card.get_node("Content/PortraitColumn/Portrait")
		portrait.texture = CharacterCatalog.get_sprite_frame(
			data["art_texture"], 0, 0, float(data.get("frame_inset", CharacterCatalog.FRAME_INSET))
		)
		var name_label: Label = card.get_node("Content/Info/Name")
		name_label.add_theme_color_override("font_color", data["color"])
		card.get_node("Content/Info/Deploy").pressed.connect(_select_character.bind(character_id))
	_refresh_text(LocalizationManager.current_language)


func _refresh_text(_locale: String) -> void:
	$Layout/Header/Back.text = LocalizationManager.text("UI_BACK")
	$Layout/Header/Title.text = LocalizationManager.text("CHARACTER_SELECT_TITLE")
	for character_id in CharacterCatalog.get_ids():
		var card := $Layout/Cards.get_node(character_id)
		var data := CharacterCatalog.get_character(character_id)
		card.get_node("Content/Info/Name").text = LocalizationManager.text(data["name_key"])
		card.get_node("Content/Info/Role").text = LocalizationManager.text(data["role_key"])
		card.get_node("Content/PortraitColumn/Stats").text = LocalizationManager.text("CHARACTER_STATS", {
			"health": data["max_health"], "attack": data["attack_damage"], "speed": int(data["move_speed"]),
		})
		card.get_node("Content/Info/Description").text = LocalizationManager.text(data["description_key"])
		card.get_node("Content/Info/Deploy").text = LocalizationManager.text("CHARACTER_DEPLOY")


func _select_character(character_id: String) -> void:
	AudioManager.play_click()
	SaveManager.set_selected_character(character_id)
	SceneManager.go_to_level_select()


func _on_back_pressed() -> void:
	AudioManager.play_click()
	SceneManager.go_to_main_menu()
