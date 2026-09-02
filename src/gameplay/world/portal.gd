class_name ExitPortal
extends Area2D

signal player_entered

@onready var visual: Sprite2D = $Visual
@onready var label: Label = $Label

var active: bool = false
var elapsed: float = 0.0
var base_visual_scale: Vector2
var _label_text: String = ""


func _ready() -> void:
	base_visual_scale = visual.scale
	_refresh_label()


func _process(delta: float) -> void:
	elapsed += delta
	visual.modulate = Color("c9ff8c") if active else Color("9a9d91")
	visual.scale = base_visual_scale * (1.0 + sin(elapsed * (4.0 if active else 1.5)) * 0.025)


func set_active(enabled: bool) -> void:
	if active != enabled and enabled:
		AudioManager.play_named_sfx(&"portal_open", 1.0, -12.0)
	active = enabled
	visible = enabled
	monitoring = enabled
	_refresh_label()


func _refresh_label() -> void:
	# Only touch the label when the localized state actually changes; per-frame
	# dictionary lookups and text assignments are wasted work for a static label.
	var text := LocalizationManager.text("PORTAL_READY" if active else "PORTAL_LOCKED")
	if text != _label_text:
		_label_text = text
		label.text = text


func _on_body_entered(body: Node2D) -> void:
	if active and body.is_in_group("Player"):
		AudioManager.play_named_sfx(&"portal_extract", 1.0, -10.0)
		player_entered.emit()
