class_name DialogueOverlay
extends Control

@onready var panel: PanelContainer = $Panel
@onready var portrait: TextureRect = $Panel/Body/Portrait
@onready var speaker_label: Label = $Panel/Body/Content/Speaker
@onready var text_label: Label = $Panel/Body/Content/Text
@onready var continue_button: Button = $Panel/Body/Content/Actions/Continue
@onready var skip_button: Button = $Panel/Body/Content/Actions/Skip
@onready var radio_timer: Timer = $RadioTimer

var sequence_id: String = ""
var entries: Array = []
var entry_index: int = 0
var paused_by_dialogue: bool = false
var pending_sequences: Array[String] = []


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	StoryManager.sequence_requested.connect(show_sequence)
	LocalizationManager.language_changed.connect(_on_language_changed)


func show_sequence(requested_sequence_id: String) -> void:
	var requested_entries := DialogueCatalog.get_sequence(requested_sequence_id)
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
	portrait.texture = speaker.get("portrait_texture") as Texture2D
	portrait.visible = portrait.texture != null
	var speaker_key := str(speaker.get("display_name_key", "SPEAKER_OPERATOR"))
	if speaker_id == "selected_operator":
		speaker_key = str(CharacterCatalog.get_character(GameManager.selected_character_id).get("name_key", speaker_key))
	speaker_label.text = LocalizationManager.text(speaker_key)
	speaker_label.add_theme_color_override("font_color", speaker.get("dialogue_color", Color.WHITE))
	text_label.text = LocalizationManager.text(str(entry.get("text_key", "")))
	continue_button.text = LocalizationManager.text("DIALOGUE_CONTINUE")
	skip_button.text = LocalizationManager.text("DIALOGUE_SKIP")
	var is_radio := str(entry.get("presentation_mode", "briefing")) == "radio"
	continue_button.visible = not is_radio
	skip_button.visible = not is_radio and bool(entry.get("skippable", true))
	if bool(entry.get("pause_game", false)) and not get_tree().paused:
		get_tree().paused = true
		paused_by_dialogue = true
	if is_radio:
		radio_timer.start(4.5)


func _on_continue_pressed() -> void:
	entry_index += 1
	_show_current_entry()


func _on_skip_pressed() -> void:
	_complete()


func _on_radio_timeout() -> void:
	entry_index += 1
	_show_current_entry()


func _complete() -> void:
	radio_timer.stop()
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
