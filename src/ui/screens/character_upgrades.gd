extends Control

const UPGRADE_DATA := {
	"blade": {
		"name": "ฝึกใช้อาวุธ",
		"description": "+1 พลังโจมตีเฉพาะตัวละครนี้",
		"color": Color("91bd45"),
	},
	"armor": {
		"name": "เสริมความแข็งแกร่ง",
		"description": "+1 พลังชีวิตสูงสุดเฉพาะตัวละครนี้",
		"color": Color("6e91a8"),
	},
	"engine": {
		"name": "ฝึกความคล่องตัว",
		"description": "+5% ความเร็วเคลื่อนที่และพุ่งหลบเฉพาะตัวละครนี้",
		"color": Color("c58b43"),
	},
}


func _ready() -> void:
	var character := CharacterCatalog.get_character(GameManager.selected_character_id)
	$Margin/Layout/Header/Character.text = "ตัวละคร: %s" % character["name"]
	$Margin/Layout/Header/Character.add_theme_color_override("font_color", character["color"])
	for upgrade_id in UPGRADE_DATA:
		_configure_card(upgrade_id)
	_refresh()


func _configure_card(upgrade_id: String) -> void:
	var card: PanelContainer = $Margin/Layout/Cards.get_node(upgrade_id)
	var data: Dictionary = UPGRADE_DATA[upgrade_id]
	var title: Label = card.get_node("Content/Name")
	title.text = data["name"]
	title.add_theme_color_override("font_color", data["color"])
	card.get_node("Content/Description").text = data["description"]
	card.get_node("Content/Purchase").pressed.connect(_purchase.bind(upgrade_id))


func _purchase(upgrade_id: String) -> void:
	AudioManager.play_click()
	SaveManager.purchase_character_upgrade(upgrade_id)
	_refresh()


func _refresh() -> void:
	$Margin/Layout/Resources.text = "ตัวอย่างต่างดาว: %d" % int(SaveManager.profile.get("total_crystals", 0))
	for upgrade_id in UPGRADE_DATA:
		var card: PanelContainer = $Margin/Layout/Cards.get_node(upgrade_id)
		var level := SaveManager.get_character_upgrade_level(upgrade_id)
		card.get_node("Content/Level").text = "ระดับ %d/5" % level
		var button: Button = card.get_node("Content/Purchase")
		if level >= 5:
			button.text = "ระดับสูงสุด"
			button.disabled = true
		else:
			var cost := SaveManager.get_character_upgrade_cost(upgrade_id)
			button.text = "อัปเกรด • %d" % cost
			button.disabled = int(SaveManager.profile.get("total_crystals", 0)) < cost


func _on_back_pressed() -> void:
	AudioManager.play_click()
	SceneManager.go_to_level_select()
