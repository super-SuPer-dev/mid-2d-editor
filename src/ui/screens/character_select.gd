extends Control


func _ready() -> void:
	for character_id in CharacterCatalog.get_ids():
		var card := $Layout/Cards.get_node(character_id)
		var data := CharacterCatalog.get_character(character_id)
		var portrait: TextureRect = card.get_node("Content/PortraitColumn/Portrait")
		portrait.texture = CharacterCatalog.get_sprite_frame(
			data["art_texture"], 0, 0, float(data.get("frame_inset", CharacterCatalog.FRAME_INSET))
		)
		var name_label: Label = card.get_node("Content/Info/Name")
		name_label.text = data["name"]
		name_label.add_theme_color_override("font_color", data["color"])
		card.get_node("Content/Info/Role").text = data["role"]
		card.get_node("Content/PortraitColumn/Stats").text = "ชีวิต %d • โจมตี %d • เร็ว %d" % [data["max_health"], data["attack_damage"], int(data["move_speed"])]
		card.get_node("Content/Info/Description").text = data["description"]
		card.get_node("Content/Info/Deploy").pressed.connect(_select_character.bind(character_id))


func _select_character(character_id: String) -> void:
	AudioManager.play_click()
	SaveManager.set_selected_character(character_id)
	SceneManager.go_to_level_select()


func _on_back_pressed() -> void:
	AudioManager.play_click()
	SceneManager.go_to_main_menu()
