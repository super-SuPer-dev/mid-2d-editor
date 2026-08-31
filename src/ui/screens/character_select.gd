extends Control

const PASSIVE_ICONS := {
	"tonkla": preload("res://assets/UI/icons/passive_tonkla_field_recovery_normalized_v1.png"),
	"rin": preload("res://assets/UI/icons/passive_rin_rapid_evade_normalized_v1.png"),
	"khem": preload("res://assets/UI/icons/passive_khem_wide_cut_normalized_v1.png"),
	"t800": preload("res://assets/UI/icons/passive_t800_reinforced_chassis_normalized_v1.png"),
}


func _ready() -> void:
	LocalizationManager.language_changed.connect(_refresh_text)
	resized.connect(_refresh_wrapped_text)
	for character_id in CharacterCatalog.get_ids():
		var card := $Layout/Cards.get_node(character_id)
		var data := CharacterCatalog.get_character(character_id)
		var portrait: TextureRect = card.get_node("Content/PortraitColumn/Portrait")
		portrait.texture = CharacterCatalog.get_sprite_frame(
			data["art_texture"], 0, 0, float(data.get("frame_inset", CharacterCatalog.FRAME_INSET))
		)
		(card.get_node("Content/Info/PassiveIcon") as TextureRect).texture = PASSIVE_ICONS.get(character_id)
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
		_set_word_wrapped_text(card.get_node("Content/Info/Role"), LocalizationManager.text(data["role_key"]), 330.0)
		_set_stats_text(card.get_node("Content/PortraitColumn/Stats"), LocalizationManager.text("CHARACTER_STATS", {
			"health": data["max_health"], "attack": data["attack_damage"], "speed": int(data["move_speed"]),
		}))
		_set_word_wrapped_text(card.get_node("Content/Info/Description"), LocalizationManager.text(data["description_key"]), 330.0)
		card.get_node("Content/Info/Deploy").text = LocalizationManager.text("CHARACTER_DEPLOY")
	call_deferred("_refresh_wrapped_text")


func _refresh_wrapped_text() -> void:
	for character_id in CharacterCatalog.get_ids():
		var card := $Layout/Cards.get_node(character_id)
		var data := CharacterCatalog.get_character(character_id)
		_set_stats_text(card.get_node("Content/PortraitColumn/Stats"), LocalizationManager.text("CHARACTER_STATS", {
			"health": data["max_health"], "attack": data["attack_damage"], "speed": int(data["move_speed"]),
		}))
		_set_word_wrapped_text(card.get_node("Content/Info/Role"), LocalizationManager.text(data["role_key"]), 330.0)
		_set_word_wrapped_text(card.get_node("Content/Info/Description"), LocalizationManager.text(data["description_key"]), 330.0)


func _set_stats_text(label: Label, source_text: String) -> void:
	var segments := source_text.split(" • ", false)
	label.autowrap_mode = TextServer.AUTOWRAP_OFF
	if segments.size() >= 3:
		label.text = "%s • %s\n%s" % [segments[0], segments[1], segments[2]]
	else:
		label.text = source_text


func _set_word_wrapped_text(label: Label, source_text: String, fallback_width: float) -> void:
	label.autowrap_mode = TextServer.AUTOWRAP_OFF
	var available_width := maxf(maxf(label.size.x, label.custom_minimum_size.x), fallback_width)
	if available_width <= 0.0:
		label.text = source_text
		return
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
	label.autowrap_mode = TextServer.AUTOWRAP_OFF
	label.text = "\n".join(lines)


func _select_character(character_id: String) -> void:
	AudioManager.play_click()
	SaveManager.set_selected_character(character_id)
	SceneManager.go_to_level_select()


func _on_back_pressed() -> void:
	AudioManager.play_click()
	SceneManager.go_to_main_menu()
