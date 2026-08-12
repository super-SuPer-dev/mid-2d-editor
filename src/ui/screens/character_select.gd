extends Control


func _ready() -> void:
	for character_id in CharacterCatalog.get_ids():
		var card := $Layout/Cards.get_node(character_id)
		var data := CharacterCatalog.get_character(character_id)
		card.get_node("Content/Portrait").color = data["color"]
		var name_label: Label = card.get_node("Content/Name")
		name_label.text = data["name"]
		name_label.add_theme_color_override("font_color", data["color"])
		card.get_node("Content/Role").text = data["role"]
		card.get_node("Content/Stats").text = "HP %d  ATK %d\nSPD %d" % [data["max_health"], data["attack_damage"], int(data["move_speed"])]
		card.get_node("Content/Description").text = data["description"]
		card.get_node("Content/Deploy").pressed.connect(_select_character.bind(character_id))


func _select_character(character_id: String) -> void:
	AudioManager.play_click()
	SaveManager.set_selected_character(character_id)
	SceneManager.go_to_level_select()


func _on_back_pressed() -> void:
	AudioManager.play_click()
	SceneManager.go_to_main_menu()
