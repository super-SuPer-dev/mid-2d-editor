class_name DialogueOverlay
extends Control

@onready var panel: PanelContainer = $Panel
@onready var portrait: TextureRect = $Panel/Body/Portrait
@onready var body: HBoxContainer = $Panel/Body
@onready var speaker_label: Label = $Panel/Body/Content/Speaker
@onready var text_label: Label = $Panel/Body/Content/Text
@onready var actions: HBoxContainer = $Panel/Body/Content/Actions
@onready var continue_button: Button = $Panel/Body/Content/Actions/Continue
@onready var skip_button: Button = $Panel/Body/Content/Actions/Skip
@onready var radio_timer: Timer = $RadioTimer

var sequence_id: String = ""
var entries: Array = []
var entry_index: int = 0
var paused_by_dialogue: bool = false
var pending_sequences: Array[String] = []
var dialogue_frame_style: StyleBoxFlat
var radio_frame_style: StyleBoxFlat
var briefing_frame_style: StyleBoxFlat
var debrief_frame_style: StyleBoxFlat
var boss_frame_style: StyleBoxFlat
var text_reveal_tween: Tween


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	StoryManager.sequence_requested.connect(show_sequence)
	LocalizationManager.language_changed.connect(_on_language_changed)
	dialogue_frame_style = _build_panel_style(Color("88a84f"))
	radio_frame_style = _build_panel_style(Color("5ba98c"), true)
	briefing_frame_style = _build_panel_style(Color("d2a63f"))
	debrief_frame_style = _build_panel_style(Color("79b9a5"))
	boss_frame_style = _build_panel_style(Color("b85d8e"))


func show_sequence(requested_sequence_id: String) -> void:
	var requested_entries := DialogueCatalog.get_sequence(requested_sequence_id, GameManager.selected_character_id)
	if requested_entries.is_empty():
		return
	if visible:
		pending_sequences.append(requested_sequence_id)
		return
	sequence_id = requested_sequence_id
	entries = requested_entries
	entry_index = 0
	visible = true
	_show_current_entry()


func _show_current_entry() -> void:
	if entry_index >= entries.size():
		_complete()
		return
	var entry: Dictionary = entries[entry_index]
	var speaker_id := str(entry.get("speaker_id", ""))
	var speaker := SpeakerCatalog.get_speaker(speaker_id)
	portrait.texture = SpeakerCatalog.get_portrait_texture(speaker_id, str(entry.get("portrait_expression", "neutral")))
	portrait.visible = portrait.texture != null
	var speaker_key := str(speaker.get("display_name_key", "SPEAKER_OPERATOR"))
	if speaker_id == "selected_operator":
		speaker_key = str(CharacterCatalog.get_character(GameManager.selected_character_id).get("name_key", speaker_key))
	speaker_label.text = LocalizationManager.text(speaker_key)
	speaker_label.add_theme_color_override("font_color", speaker.get("dialogue_color", Color.WHITE))
	text_label.text = LocalizationManager.text(str(entry.get("text_key", "")))
	text_label.visible_ratio = 1.0
	continue_button.text = LocalizationManager.text("DIALOGUE_CONTINUE")
	skip_button.text = LocalizationManager.text("DIALOGUE_SKIP")
	var presentation_mode := str(entry.get("presentation_mode", "briefing"))
	var is_radio := presentation_mode == "radio"
	_apply_presentation_mode(presentation_mode)
	continue_button.visible = not is_radio
	skip_button.visible = not is_radio and bool(entry.get("skippable", true))
	if bool(entry.get("pause_game", false)) and not get_tree().paused:
		get_tree().paused = true
		paused_by_dialogue = true
	if is_radio:
		AudioManager.play_named_sfx(&"radio_beep", 1.0, -14.0)
		radio_timer.start(4.5)
	elif not bool(SaveManager.profile.get("settings", {}).get("immediate_dialogue_text", false)):
		text_label.visible_ratio = 0.0
		if text_reveal_tween != null and text_reveal_tween.is_valid():
			text_reveal_tween.kill()
		var reveal_duration := clampf(float(text_label.text.length()) * 0.012, 0.25, 1.8)
		text_reveal_tween = create_tween()
		text_reveal_tween.tween_property(text_label, "visible_ratio", 1.0, reveal_duration)


func _apply_presentation_mode(mode: String) -> void:
	var is_radio := mode == "radio"
	var frame_style: StyleBoxFlat = dialogue_frame_style
	if mode == "radio":
		frame_style = radio_frame_style
	elif mode == "briefing":
		frame_style = briefing_frame_style
	elif mode == "debrief":
		frame_style = debrief_frame_style
	elif mode == "boss":
		frame_style = boss_frame_style
	panel.add_theme_stylebox_override("panel", frame_style)
	if is_radio:
		body.add_theme_constant_override("separation", 12)
		panel.custom_minimum_size = Vector2(520.0, 136.0)
		panel.anchor_left = 1.0
		panel.anchor_top = 0.0
		panel.anchor_right = 1.0
		panel.anchor_bottom = 0.0
		panel.offset_left = -550.0
		panel.offset_top = 190.0
		panel.offset_right = -30.0
		panel.offset_bottom = 326.0
		portrait.custom_minimum_size = Vector2(76.0, 92.0)
		text_label.custom_minimum_size = Vector2(0.0, 42.0)
		speaker_label.add_theme_font_size_override("font_size", 18)
		text_label.add_theme_font_size_override("font_size", 16)
		actions.visible = false
	else:
		body.add_theme_constant_override("separation", 20)
		panel.custom_minimum_size = Vector2(920.0, 240.0)
		panel.anchor_left = 0.5
		panel.anchor_top = 1.0
		panel.anchor_right = 0.5
		panel.anchor_bottom = 1.0
		panel.offset_left = -460.0
		panel.offset_top = -270.0
		panel.offset_right = 460.0
		panel.offset_bottom = -30.0
		portrait.custom_minimum_size = Vector2(160.0, 190.0)
		text_label.custom_minimum_size = Vector2(0.0, 76.0)
		speaker_label.add_theme_font_size_override("font_size", 22)
		text_label.add_theme_font_size_override("font_size", 20)
		actions.visible = true


func _build_panel_style(border_color: Color, compact: bool = false) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.018, 0.035, 0.028, 0.97)
	style.border_color = border_color
	style.border_width_left = 3
	style.border_width_top = 3
	style.border_width_right = 3
	style.border_width_bottom = 3
	style.corner_radius_top_left = 10
	style.corner_radius_top_right = 10
	style.corner_radius_bottom_right = 10
	style.corner_radius_bottom_left = 10
	style.content_margin_left = 16.0 if compact else 22.0
	style.content_margin_top = 12.0 if compact else 18.0
	style.content_margin_right = 16.0 if compact else 22.0
	style.content_margin_bottom = 12.0 if compact else 18.0
	style.shadow_color = Color(0.0, 0.0, 0.0, 0.45)
	style.shadow_size = 8
	return style


func _on_continue_pressed() -> void:
	if text_label.visible_ratio < 0.999:
		if text_reveal_tween != null and text_reveal_tween.is_valid():
			text_reveal_tween.kill()
		text_label.visible_ratio = 1.0
		return
	entry_index += 1
	AudioManager.play_named_sfx(&"dialogue_advance", 1.0, -18.0)
	_show_current_entry()


func _on_skip_pressed() -> void:
	_complete()


func _on_radio_timeout() -> void:
	entry_index += 1
	_show_current_entry()


func _complete() -> void:
	radio_timer.stop()
	if text_reveal_tween != null and text_reveal_tween.is_valid():
		text_reveal_tween.kill()
	text_label.visible_ratio = 1.0
	visible = false
	if paused_by_dialogue:
		get_tree().paused = false
		paused_by_dialogue = false
	var completed_id := sequence_id
	sequence_id = ""
	entries.clear()
	StoryManager.complete_sequence(completed_id)
	if not pending_sequences.is_empty():
		var next_id: String = pending_sequences.pop_front()
		call_deferred("show_sequence", next_id)


func _on_language_changed(_locale: String) -> void:
	if visible:
		_show_current_entry()
