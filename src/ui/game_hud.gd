class_name GameHUD
extends CanvasLayer

@onready var level_label: Label = $Root/TopMargin/Row/Level
@onready var health_label: Label = $Root/TopMargin/Row/Health
@onready var crystal_label: Label = $Root/TopMargin/Row/Samples
@onready var objective_label: Label = $Root/TopMargin/Row/Objective
@onready var hint_label: Label = $Root/Hint
@onready var boss_panel: PanelContainer = $Root/BossPanel
@onready var boss_name: Label = $Root/BossPanel/Content/Name
@onready var boss_health: ProgressBar = $Root/BossPanel/Content/Health
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
var pending_complete: bool = false
var pending_campaign_complete: bool = false
var last_health := Vector2i(0, 0)


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	GameManager.currency_changed.connect(_on_currency_changed)
	GameManager.objective_changed.connect(_on_objective_changed)
	GameManager.mission_phase_changed.connect(_on_mission_phase_changed)
	GameManager.boss_health_changed.connect(_on_boss_health_changed)
	LocalizationManager.language_changed.connect(_refresh_text)
	StoryManager.sequence_completed.connect(_on_sequence_completed)
	_on_currency_changed(GameManager.coin, 0)
	_on_objective_changed(GameManager.defeated_enemies, GameManager.required_enemies)
	_on_mission_phase_changed(GameManager.mission_phase)
	_refresh_text(LocalizationManager.current_language)


func bind_player(value: PlayerController) -> void:
	player = value
	player.health_changed.connect(_on_health_changed)
	_on_health_changed(player.health.current_health, player.health.max_health)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and GameManager.run_active:
		if get_tree().paused and modal.visible:
			close_modal()
		elif not get_tree().paused:
			show_pause()


func show_pause() -> void:
	get_tree().paused = true
	_show_modal("HUD_PAUSE_TITLE", "HUD_PAUSE_SUBTITLE", Color("54d6ff"), [
		["HUD_RESUME", close_modal], ["HUD_RESTART", SceneManager.restart_level], ["HUD_SELECT_MISSION", SceneManager.go_to_level_select],
	])


func show_game_over() -> void:
	get_tree().paused = true
	_show_modal("HUD_GAME_OVER", "HUD_GAME_OVER_SUBTITLE", Color("ef476f"), [
		["HUD_RETRY", SceneManager.restart_level], ["HUD_SELECT_MISSION", SceneManager.go_to_level_select],
	])


func show_level_complete(is_campaign_complete: bool) -> void:
	pending_campaign_complete = is_campaign_complete
	var debrief_id := str(LevelCatalog.get_level(GameManager.current_level_id).get("debrief_sequence", ""))
	if not debrief_id.is_empty() and StoryManager.request_sequence(debrief_id):
		pending_complete = true
		return
	_show_complete_modal()


func _show_complete_modal() -> void:
	pending_complete = false
	get_tree().paused = true
	var title_key := "HUD_CAMPAIGN_COMPLETE" if pending_campaign_complete else "HUD_MISSION_COMPLETE"
	var subtitle_key := "HUD_CAMPAIGN_COMPLETE_SUBTITLE" if pending_campaign_complete else "HUD_MISSION_COMPLETE_SUBTITLE"
	var values := {} if pending_campaign_complete else {"count": GameManager.coin}
	var actions: Array = []
	if not pending_campaign_complete:
		actions.append(["HUD_NEXT_MISSION", _play_next_level])
	actions.append(["HUD_SELECT_MISSION", SceneManager.go_to_level_select])
	if pending_campaign_complete:
		actions.append(["HUD_MAIN_MENU", SceneManager.go_to_main_menu])
	_show_modal(title_key, subtitle_key, Color("63ffb0"), actions, values)


func _show_modal(title_key: String, subtitle_key: String, accent: Color, actions: Array, subtitle_values: Dictionary = {}) -> void:
	modal_title.text = LocalizationManager.text(title_key)
	modal_title.add_theme_color_override("font_color", accent)
	modal_subtitle.text = LocalizationManager.text(subtitle_key, subtitle_values)
	modal_actions.clear()
	for index in modal_buttons.size():
		var button := modal_buttons[index]
		if index < actions.size():
			button.visible = true
			button.text = LocalizationManager.text(str(actions[index][0]))
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
	if next_level.is_empty() or not bool(LevelCatalog.get_level(next_level).get("implemented", false)):
		SceneManager.go_to_level_select()
	else:
		SceneManager.play_level(next_level)


func _refresh_text(_locale: String) -> void:
	level_label.text = LevelCatalog.get_display_name(GameManager.current_level_id)
	hint_label.text = LocalizationManager.text("HUD_HINT")
	_on_currency_changed(GameManager.coin, 0)
	_on_objective_changed(GameManager.defeated_enemies, GameManager.required_enemies)
	if last_health.y > 0:
		_on_health_changed(last_health.x, last_health.y)
	if GameManager.mission_phase == GameManager.PHASE_BOSS_ACTIVE:
		boss_name.text = LocalizationManager.text(GameManager.current_boss_name_key)


func _on_health_changed(current_health: int, maximum_health: int) -> void:
	last_health = Vector2i(current_health, maximum_health)
	health_label.text = LocalizationManager.text("HUD_HEALTH", {"current": current_health, "maximum": maximum_health})


func _on_currency_changed(current_amount: int, _change: int) -> void:
	crystal_label.text = LocalizationManager.text("HUD_SAMPLES", {"count": current_amount})


func _on_objective_changed(defeated: int, required: int) -> void:
	if GameManager.mission_phase == GameManager.PHASE_CLEAR_THREATS:
		objective_label.text = LocalizationManager.text("HUD_THREATS", {"current": mini(defeated, required), "required": required})
		objective_label.remove_theme_color_override("font_color")


func _on_mission_phase_changed(phase: StringName) -> void:
	match phase:
		GameManager.PHASE_BOSS_ACTIVE:
			objective_label.text = LocalizationManager.text("HUD_BOSS_INCOMING")
			objective_label.add_theme_color_override("font_color", Color("ef9b6c"))
			boss_panel.visible = true
			boss_name.text = LocalizationManager.text(GameManager.current_boss_name_key)
		GameManager.PHASE_EXTRACTION:
			objective_label.text = LocalizationManager.text("HUD_EXTRACTION")
			objective_label.add_theme_color_override("font_color", Color("63ffb0"))
			boss_panel.visible = false
		_:
			boss_panel.visible = false
			_on_objective_changed(GameManager.defeated_enemies, GameManager.required_enemies)


func _on_boss_health_changed(current_health: int, maximum_health: int) -> void:
	boss_health.max_value = maximum_health
	boss_health.value = current_health


func _on_sequence_completed(completed_sequence_id: String) -> void:
	if pending_complete and completed_sequence_id == str(LevelCatalog.get_level(GameManager.current_level_id).get("debrief_sequence", "")):
		_show_complete_modal()
