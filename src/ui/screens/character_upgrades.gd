extends Control

const MASTERY_RANK_NODES_TEXTURE: Texture2D = preload("res://assets/ui/mastery/mastery_rank_nodes_normalized_v1.png")

func _ready() -> void:
	LocalizationManager.language_changed.connect(_refresh_text)
	$Margin/Layout/Cards/blade/Content/Purchase.pressed.connect(_purchase_mastery)
	$Margin/Layout/Cards/armor.visible = false
	$Margin/Layout/Cards/engine.visible = false
	_refresh_text(LocalizationManager.current_language)


func _refresh_text(_locale: String = "") -> void:
	var character := CharacterCatalog.get_character(GameManager.selected_character_id)
	var display_name := LocalizationManager.text(character["name_key"])
	$Margin/Layout/Header/Title.text = LocalizationManager.text("MASTERY_TITLE")
	$Margin/Layout/Header/Character.text = LocalizationManager.text("MASTERY_OPERATOR", {"name": display_name})
	$Margin/Layout/Header/Character.add_theme_color_override("font_color", character["color"])
	$Margin/Layout/Resources.text = LocalizationManager.text("LEVEL_SAMPLES", {"count": int(SaveManager.profile.get("total_crystals", 0))})
	var card := $Margin/Layout/Cards/blade
	card.get_node("Content/Icon").text = "★"
	card.get_node("Content/Name").text = LocalizationManager.text("MASTERY_TITLE")
	card.get_node("Content/Description").text = LocalizationManager.text("MASTERY_DESC")
	var rank := SaveManager.get_mastery_rank()
	card.get_node("Content/Level").text = LocalizationManager.text("MASTERY_RANK", {"rank": rank})
	_set_rank_track(card.get_node("Content/RankTrack"), rank)
	var button: Button = card.get_node("Content/Purchase")
	if rank >= 5:
		button.text = LocalizationManager.text("MASTERY_MAX")
		button.disabled = true
	else:
		var cost := SaveManager.get_mastery_cost()
		button.text = LocalizationManager.text("MASTERY_PURCHASE", {"cost": cost})
		button.disabled = int(SaveManager.profile.get("total_crystals", 0)) < cost
	$Margin/Layout/Status.text = LocalizationManager.text("MASTERY_DESC")
	$Margin/Layout/Footer/Back.text = LocalizationManager.text("UI_BACK_MAP")


func _set_rank_track(track: HBoxContainer, rank: int) -> void:
	for index in range(track.get_child_count()):
		var node := track.get_child(index) as TextureRect
		var frame := AtlasTexture.new()
		frame.atlas = MASTERY_RANK_NODES_TEXTURE
		frame.region = Rect2(Vector2(index * 750.0, 0.0), Vector2(750.0, 750.0))
		frame.filter_clip = true
		node.texture = frame
		node.modulate = Color.WHITE if index <= clampi(rank, 0, 5) else Color(0.45, 0.48, 0.44, 1.0)


func _purchase_mastery() -> void:
	AudioManager.play_click()
	SaveManager.purchase_mastery()
	_refresh_text()


func _on_back_pressed() -> void:
	AudioManager.play_click()
	SceneManager.go_to_level_select()
