extends Control

const MASTERY_RANK_NODES_TEXTURE: Texture2D = preload("res://assets/ui/mastery/mastery_rank_nodes_normalized_v1.png")

var target_character_id: String = CharacterCatalog.DEFAULT_CHARACTER
var feedback_key := ""
var feedback_values: Dictionary = {}


func _ready() -> void:
	AudioManager.play_music(&"main_theme")
	target_character_id = CharacterCatalog.resolve_character_id(GameManager.selected_character_id)
	LocalizationManager.language_changed.connect(_refresh_text)
	for character_id: String in CharacterCatalog.get_ids():
		var selector := $Margin/Layout/Cards/OperatorList/Content/Selectors.get_node(character_id) as Button
		selector.pressed.connect(_select_operator.bind(character_id))
	$Margin/Layout/Cards/blade/Content/Purchase.pressed.connect(_purchase_mastery)
	$Margin/Layout/Cards/armor.visible = false
	$Margin/Layout/Cards/engine.visible = false
	_refresh_text(LocalizationManager.current_language)


func _refresh_text(_locale: String = "") -> void:
	var character := CharacterCatalog.get_character(target_character_id)
	var display_name := LocalizationManager.text(character["name_key"])
	$Margin/Layout/Header/Title.text = LocalizationManager.text("MASTERY_TITLE")
	$Margin/Layout/Header/Character.text = LocalizationManager.text("MASTERY_OPERATOR", {"name": display_name})
	$Margin/Layout/Header/Character.add_theme_color_override("font_color", character["color"])
	var samples := int(SaveManager.profile.get("total_crystals", 0))
	$Margin/Layout/Resources.text = LocalizationManager.text("LEVEL_SAMPLES", {"count": samples})
	_refresh_operator_selectors()

	var card := $Margin/Layout/Cards/blade
	card.get_node("Content/Icon").text = _operator_icon(target_character_id)
	card.get_node("Content/Icon").add_theme_color_override("font_color", character["color"])
	card.get_node("Content/Name").text = display_name
	card.get_node("Content/Description").text = LocalizationManager.text(character["role_key"])
	var rank := SaveManager.get_mastery_rank(target_character_id)
	card.get_node("Content/Level").text = LocalizationManager.text("MASTERY_RANK", {"rank": rank})
	card.get_node("Content/CurrentBenefit").text = LocalizationManager.text("MASTERY_CURRENT_EFFECT", {"effect": _effect_text(target_character_id, rank)})
	card.get_node("Content/NextBenefit").text = LocalizationManager.text("MASTERY_NEXT_EFFECT", {"effect": _effect_text(target_character_id, mini(rank + 1, 5))}) if rank < 5 else LocalizationManager.text("MASTERY_ALL_UNLOCKED")
	_set_rank_track(card.get_node("Content/RankTrack"), rank)

	var button: Button = card.get_node("Content/Purchase")
	if rank >= 5:
		button.text = LocalizationManager.text("MASTERY_MAX")
		button.disabled = true
	else:
		var cost := SaveManager.get_mastery_cost(target_character_id)
		button.disabled = false
		if samples >= cost:
			button.text = LocalizationManager.text("MASTERY_PURCHASE", {"cost": cost})
		else:
			button.text = LocalizationManager.text("MASTERY_NEED_SAMPLES", {"missing": cost - samples, "cost": cost})
	_refresh_status(samples, rank)
	$Margin/Layout/Footer/Back.text = LocalizationManager.text("UI_BACK_MAP")


func _refresh_operator_selectors() -> void:
	$Margin/Layout/Cards/OperatorList/Content/Title.text = LocalizationManager.text("MASTERY_SELECT_OPERATOR")
	for character_id: String in CharacterCatalog.get_ids():
		var selector := $Margin/Layout/Cards/OperatorList/Content/Selectors.get_node(character_id) as Button
		var character := CharacterCatalog.get_character(character_id)
		var name := LocalizationManager.text(character["name_key"])
		var rank := SaveManager.get_mastery_rank(character_id)
		var active_marker := "  ◆" if character_id == GameManager.selected_character_id else ""
		selector.text = "%s  •  R%d%s" % [name, rank, active_marker]
		selector.button_pressed = character_id == target_character_id
		selector.add_theme_color_override("font_color", character["color"] if selector.button_pressed else Color(0.82, 0.84, 0.76))


func _refresh_status(samples: int, rank: int) -> void:
	var status: Label = $Margin/Layout/Status
	status.visible = true
	if not feedback_key.is_empty():
		status.text = LocalizationManager.text(feedback_key, feedback_values)
		status.add_theme_color_override("font_color", Color("9fcf64") if feedback_key == "MASTERY_PURCHASED" else Color("efbd65"))
		return
	if rank >= 5:
		status.text = LocalizationManager.text("MASTERY_ALL_UNLOCKED")
		status.add_theme_color_override("font_color", Color("9fcf64"))
		return
	var cost := SaveManager.get_mastery_cost(target_character_id)
	if samples < cost:
		status.text = LocalizationManager.text("MASTERY_INSUFFICIENT", {"missing": cost - samples})
		status.add_theme_color_override("font_color", Color("efbd65"))
	else:
		status.text = LocalizationManager.text("MASTERY_READY")
		status.add_theme_color_override("font_color", Color("b8c7ad"))


func _effect_text(character_id: String, rank: int) -> String:
	var strength := CharacterCatalog.get_passive_strength(character_id, rank)
	var passive_text := ""
	match CharacterCatalog.resolve_character_id(character_id):
		"tonkla":
			passive_text = LocalizationManager.text("MASTERY_EFFECT_TONKLA", {"value": int(strength)})
		"rin":
			passive_text = LocalizationManager.text("MASTERY_EFFECT_RIN", {"value": int(round(strength * 100.0))})
		"khem":
			passive_text = LocalizationManager.text("MASTERY_EFFECT_KHEM", {"value": int(round(strength * 100.0))})
		"t800":
			passive_text = LocalizationManager.text("MASTERY_EFFECT_T800", {"value": int(strength)})
	var vitality := LocalizationManager.text("MASTERY_EFFECT_VITALITY", {"value": CharacterCatalog.get_mastery_health_bonus(rank)})
	return "%s  •  %s" % [passive_text, vitality]


func _operator_icon(character_id: String) -> String:
	match CharacterCatalog.resolve_character_id(character_id):
		"tonkla":
			return "✦"
		"rin":
			return "➤"
		"khem":
			return "◆"
		"t800":
			return "⬢"
	return "★"


func _set_rank_track(track: HBoxContainer, rank: int) -> void:
	for index in range(track.get_child_count()):
		var node := track.get_child(index) as TextureRect
		var frame := AtlasTexture.new()
		frame.atlas = MASTERY_RANK_NODES_TEXTURE
		frame.region = Rect2(Vector2(index * 750.0, 0.0), Vector2(750.0, 750.0))
		frame.filter_clip = true
		node.texture = frame
		node.modulate = Color.WHITE if index <= clampi(rank, 0, 5) else Color(0.45, 0.48, 0.44, 1.0)


func _select_operator(character_id: String) -> void:
	if target_character_id != character_id:
		AudioManager.play_click()
	target_character_id = CharacterCatalog.resolve_character_id(character_id)
	feedback_key = ""
	feedback_values.clear()
	_refresh_text()


func _purchase_mastery() -> void:
	var rank_before := SaveManager.get_mastery_rank(target_character_id)
	var cost := SaveManager.get_mastery_cost(target_character_id)
	var samples := int(SaveManager.profile.get("total_crystals", 0))
	var purchased := SaveManager.purchase_mastery(target_character_id)
	if purchased:
		feedback_key = "MASTERY_PURCHASED"
		feedback_values = {"rank": rank_before + 1}
	elif rank_before >= 5:
		feedback_key = "MASTERY_ALL_UNLOCKED"
		feedback_values.clear()
	else:
		feedback_key = "MASTERY_INSUFFICIENT"
		feedback_values = {"missing": maxi(cost - samples, 0)}
	AudioManager.play_named_sfx(&"upgrade_purchase" if purchased else &"menu_back", 1.0, -12.0)
	_refresh_text()


func _on_back_pressed() -> void:
	AudioManager.play_named_sfx(&"menu_back", 1.0, -12.0)
	SceneManager.go_to_level_select()
