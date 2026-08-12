class_name GameHUD
extends CanvasLayer

@onready var level_label: Label = $Root/TopMargin/Row/Level
@onready var health_label: Label = $Root/TopMargin/Row/Health
@onready var crystal_label: Label = $Root/TopMargin/Row/Samples
@onready var objective_label: Label = $Root/TopMargin/Row/Objective
@onready var modal: ColorRect = $Root/Modal
@onready var modal_title: Label = $Root/Modal/Center/Panel/Content/Title
@onready var modal_subtitle: Label = $Root/Modal/Center/Panel/Content/Subtitle
@onready var modal_buttons: Array[Button] = [
	$Root/Modal/Center/Panel/Content/Action1,
	$Root/Modal/Center/Panel/Content/Action2,
	$Root/Modal/Center/Panel/Content/Action3,
]

var player: PlayerController
var modal_actions: Array[Callable] = []


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	level_label.text = LevelCatalog.get_level(GameManager.current_level_id)["name"]
	GameManager.currency_changed.connect(_on_currency_changed)
	GameManager.objective_changed.connect(_on_objective_changed)
	_on_currency_changed(GameManager.coin, 0)
	_on_objective_changed(GameManager.defeated_enemies, GameManager.required_enemies)


func bind_player(value: PlayerController) -> void:
	player = value
	player.health_changed.connect(_on_health_changed)
	_on_health_changed(player.health.current_health, player.health.max_health)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and GameManager.run_active:
		if get_tree().paused:
			close_modal()
		else:
			show_pause()


func show_pause() -> void:
	get_tree().paused = true
	_show_modal("หยุดภารกิจชั่วคราว", "ระบบพักการทำงาน", Color("54d6ff"), [
		["ทำต่อ", close_modal], ["เริ่มใหม่", SceneManager.restart_level], ["เลือกภารกิจ", SceneManager.go_to_level_select],
	])


func show_game_over() -> void:
	get_tree().paused = true
	_show_modal("เจ้าหน้าที่เสียชีวิต", "สัญญาณขาดหาย ต้องการเริ่มภารกิจใหม่หรือไม่?", Color("ef476f"), [
		["ลองภารกิจอีกครั้ง", SceneManager.restart_level], ["เลือกภารกิจ", SceneManager.go_to_level_select],
	])


func show_level_complete(is_campaign_complete: bool) -> void:
	get_tree().paused = true
	var title := "จบแคมเปญ" if is_campaign_complete else "ภารกิจสำเร็จ"
	var subtitle := "กองบัญชาการผู้รุกรานถูกทำลายแล้ว" if is_campaign_complete else "เก็บตัวอย่างได้ %d ชิ้น ปลดล็อกพื้นที่ใหม่แล้ว" % GameManager.coin
	var actions: Array = []
	if not is_campaign_complete:
		actions.append(["ภารกิจถัดไป", _play_next_level])
	actions.append(["เลือกภารกิจ", SceneManager.go_to_level_select])
	actions.append(["เมนูหลัก", SceneManager.go_to_main_menu])
	_show_modal(title, subtitle, Color("63ffb0"), actions)


func _show_modal(title: String, subtitle: String, accent: Color, actions: Array) -> void:
	modal_title.text = title
	modal_title.add_theme_color_override("font_color", accent)
	modal_subtitle.text = subtitle
	modal_actions.clear()
	for index in modal_buttons.size():
		var button := modal_buttons[index]
		if index < actions.size():
			button.visible = true
			button.text = actions[index][0]
			modal_actions.append(actions[index][1])
		else:
			button.visible = false
	modal.visible = true


func _activate_action(index: int) -> void:
	if index >= modal_actions.size():
		return
	AudioManager.play_click()
	modal_actions[index].call()


func _on_action_1() -> void:
	_activate_action(0)


func _on_action_2() -> void:
	_activate_action(1)


func _on_action_3() -> void:
	_activate_action(2)


func close_modal() -> void:
	get_tree().paused = false
	modal.visible = false
	modal_actions.clear()


func _play_next_level() -> void:
	var next_level := str(LevelCatalog.get_level(GameManager.current_level_id).get("next_level", ""))
	if next_level.is_empty():
		SceneManager.go_to_level_select()
	else:
		SceneManager.play_level(next_level)


func _on_health_changed(current_health: int, maximum_health: int) -> void:
	health_label.text = "ชีวิต %d/%d" % [current_health, maximum_health]


func _on_currency_changed(current_amount: int, _change: int) -> void:
	crystal_label.text = "ตัวอย่าง %d" % current_amount


func _on_objective_changed(defeated: int, required: int) -> void:
	objective_label.text = "ศัตรู %d/%d" % [mini(defeated, required), required]
