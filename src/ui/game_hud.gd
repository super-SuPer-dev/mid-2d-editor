class_name GameHUD
extends CanvasLayer

@onready var level_label: Label = $Root/TopMargin/Row/Level
@onready var health_label: Label = $Root/TopMargin/Row/Health
@onready var crystal_label: Label = $Root/TopMargin/Row/Samples
@onready var objective_label: Label = $Root/TopMargin/Row/Objective
@onready var hint_label: Label = $Root/Hint
@onready var boss_panel: Panel = $Root/BossPanel
@onready var boss_name: Label = $Root/BossPanel/Content/Name
@onready var boss_phase_pips: HBoxContainer = $Root/BossPanel/Content/PhaseRow/PhasePips
@onready var boss_phase_value: Label = $Root/BossPanel/Content/PhaseRow/PhaseValue
@onready var boss_health_trail: ProgressBar = $Root/BossPanel/Content/HealthStack/Trail
@onready var boss_health: ProgressBar = $Root/BossPanel/Content/HealthStack/Health
@onready var boss_health_value: Label = $Root/BossPanel/Content/HealthStack/Value
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
var boss_health_initialized := false
var modal_transition_token: int = 0
var modal_mouse_release_required: bool = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	GameManager.currency_changed.connect(_on_currency_changed)
	GameManager.objective_changed.connect(_on_objective_changed)
	GameManager.mission_phase_changed.connect(_on_mission_phase_changed)
	GameManager.boss_health_changed.connect(_on_boss_health_changed)
	GameManager.boss_phase_changed.connect(_on_boss_phase_changed)
	LocalizationManager.language_changed.connect(_refresh_text)
	StoryManager.sequence_completed.connect(_on_sequence_completed)
	_on_currency_changed(GameManager.coin, 0)
	_on_objective_changed(GameManager.defeated_enemies, GameManager.required_enemies)
	_on_mission_phase_changed(GameManager.mission_phase)
	_refresh_text(LocalizationManager.current_language)

func _process(delta: float) -> void:
	if not boss_panel.visible or not boss_health_initialized:
		return
	if boss_health_trail.value > boss_health.value:
		var trail_speed := maxf(12.0, boss_health.max_value * 0.55)
		boss_health_trail.value = move_toward(boss_health_trail.value, boss_health.value, trail_speed * delta)

func bind_player(value: PlayerController) -> void:
	player = value
	player.health_changed.connect(_on_health_changed)
	_on_health_changed(player.health.current_health, player.health.max_health)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		modal_mouse_release_required = false

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
	AudioManager.play_named_sfx(&"defeat_stinger", 1.0, -8.0)
	modal_mouse_release_required = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	get_tree().paused = true
	_show_modal("HUD_GAME_OVER", "HUD_GAME_OVER_SUBTITLE", Color("ef476f"), [
		["HUD_RETRY", SceneManager.restart_level], ["HUD_SELECT_MISSION", SceneManager.go_to_level_select],
	], {}, true)

func show_level_complete(is_campaign_complete: bool) -> void:
	pending_campaign_complete = is_campaign_complete
	var debrief_id := str(LevelCatalog.get_level(GameManager.current_level_id).get("debrief_sequence", ""))
	if not debrief_id.is_empty() and StoryManager.request_sequence(debrief_id):
		pending_complete = true
		return
	_show_complete_modal()

func _show_complete_modal() -> void:
	AudioManager.play_named_sfx(&"victory_stinger", 1.0, -8.0)
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

func _show_modal(title_key: String, subtitle_key: String, accent: Color, actions: Array, subtitle_values: Dictionary = {}, animate_in: bool = false) -> void:
	modal_transition_token += 1
	var transition_token := modal_transition_token
	modal_title.text = LocalizationManager.text(title_key)
	modal_title.add_theme_color_override("font_color", accent)
	modal_subtitle.text = LocalizationManager.text(subtitle_key, subtitle_values)
	modal_actions.clear()
	for index in modal_buttons.size():
		var button := modal_buttons[index]
		button.disabled = animate_in
		if index < actions.size():
			button.visible = true
			button.text = LocalizationManager.text(str(actions[index][0]))
			modal_actions.append(actions[index][1])
		else:
			button.visible = false
	modal.modulate.a = 0.0 if animate_in else 1.0
	modal.visible = true
	if animate_in:
		await get_tree().create_timer(0.45, true).timeout
		while modal_mouse_release_required:
			await get_tree().process_frame
		if transition_token != modal_transition_token or not modal.visible:
			return
		modal.modulate.a = 1.0
		for button in modal_buttons:
			button.disabled = false

func _activate_action(index: int) -> void:
	if index >= modal_actions.size():
		return
	var action: Callable = modal_actions[index]
	modal_actions.clear()
	for button in modal_buttons:
		button.disabled = true
	AudioManager.play_click()
	action.call_deferred()

func _on_action_1() -> void:
	_activate_action(0)

func _on_action_2() -> void:
	_activate_action(1)

func _on_action_3() -> void:
	_activate_action(2)

func close_modal() -> void:
	modal_transition_token += 1
	get_tree().paused = false
	modal.modulate.a = 1.0
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
		_refresh_boss_name()

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
			_refresh_boss_name()
		GameManager.PHASE_EXTRACTION:
			objective_label.text = LocalizationManager.text("HUD_EXTRACTION")
			objective_label.add_theme_color_override("font_color", Color("63ffb0"))
			boss_panel.visible = false
		_:
			boss_panel.visible = false
			_on_objective_changed(GameManager.defeated_enemies, GameManager.required_enemies)

func _refresh_boss_name() -> void:
	boss_name.text = LocalizationManager.text(GameManager.current_boss_name_key)
	_refresh_boss_phase_meter()

func _refresh_boss_phase_meter() -> void:
	var total := maxi(GameManager.current_boss_phase_count, 1)
	var current := clampi(GameManager.current_boss_phase, 1, total)
	boss_phase_value.text = "%02d / %02d" % [current, total]
	for child in boss_phase_pips.get_children():
		boss_phase_pips.remove_child(child)
		child.queue_free()
	for index in range(total):
		var pip := Panel.new()
		pip.custom_minimum_size = Vector2(0.0, 6.0)
		pip.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		pip.mouse_filter = Control.MOUSE_FILTER_IGNORE
		var style := StyleBoxFlat.new()
		style.bg_color = Color("ef5a65") if index < current else Color("3d252c")
		style.border_color = Color("ffad72") if index < current else Color("6d4245")
		style.set_border_width_all(1)
		style.set_corner_radius_all(3)
		pip.add_theme_stylebox_override("panel", style)
		boss_phase_pips.add_child(pip)

func _on_boss_health_changed(current_health: int, maximum_health: int) -> void:
	boss_health.max_value = maximum_health
	boss_health_trail.max_value = maximum_health
	if not boss_health_initialized or current_health > boss_health_trail.value:
		boss_health_trail.value = current_health
	boss_health_initialized = true
	boss_health.value = current_health
	boss_health_value.text = "%d / %d" % [current_health, maximum_health]

func _on_boss_phase_changed(_current_phase: int, _phase_count: int) -> void:
	_refresh_boss_name()

func _on_sequence_completed(completed_sequence_id: String) -> void:
	if pending_complete and completed_sequence_id == str(LevelCatalog.get_level(GameManager.current_level_id).get("debrief_sequence", "")):
		_show_complete_modal()
