extends Control

const UPGRADE_DATA := {
	"blade": {"name": "ใบมีดเครื่องตัด", "description": "+1 พลังโจมตีต่อระดับ", "color": Color("91bd45")},
	"engine": {"name": "เครื่องยนต์ตัดหญ้า", "description": "+5% ความเร็วเคลื่อนที่และพุ่งหลบ", "color": Color("c58b43")},
	"armor": {"name": "เกราะภาคสนาม", "description": "+1 พลังชีวิตสูงสุดต่อระดับ", "color": Color("6e91a8")},
}


func _ready() -> void:
	for upgrade_id in UPGRADE_DATA:
		var row := $Layout/Cards.get_node(upgrade_id)
		var data: Dictionary = UPGRADE_DATA[upgrade_id]
		row.get_node("Row/Badge").color = data["color"]
		var title: Label = row.get_node("Row/Copy/Name")
		title.text = data["name"]
		title.add_theme_color_override("font_color", data["color"])
		row.get_node("Row/Copy/Description").text = data["description"]
		row.get_node("Row/Purchase").pressed.connect(_purchase.bind(upgrade_id))
	_refresh()


func _purchase(upgrade_id: String) -> void:
	AudioManager.play_click()
	SaveManager.purchase_upgrade(upgrade_id)
	_refresh()


func _refresh() -> void:
	$Layout/Header/Samples.text = "ตัวอย่าง %d" % int(SaveManager.profile.get("total_crystals", 0))
	for upgrade_id in UPGRADE_DATA:
		var row := $Layout/Cards.get_node(upgrade_id)
		var level := SaveManager.get_upgrade_level(upgrade_id)
		row.get_node("Row/Level").text = "ระดับ %d/5" % level
		var button: Button = row.get_node("Row/Purchase")
		if level >= 5:
			button.text = "สูงสุด"
			button.disabled = true
		else:
			var cost := SaveManager.get_upgrade_cost(upgrade_id)
			button.text = "อัปเกรด • %d" % cost
			button.disabled = int(SaveManager.profile.get("total_crystals", 0)) < cost


func _on_back_pressed() -> void:
	AudioManager.play_click()
	SceneManager.go_to_level_select()
