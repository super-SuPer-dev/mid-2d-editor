class_name ExitPortal
extends Area2D

signal player_entered

@onready var visual: Polygon2D = $Visual
@onready var label: Label = $Label

var active: bool = false
var elapsed: float = 0.0


func _process(delta: float) -> void:
	elapsed += delta
	visual.rotation = elapsed * (1.5 if active else 0.25)
	visual.color = Color("91bd45") if active else Color("55584b")
	label.text = "EXTRACT" if active else "AREA UNCLEAR"


func set_active(enabled: bool) -> void:
	active = enabled


func _on_body_entered(body: Node2D) -> void:
	if active and body.is_in_group("Player"):
		player_entered.emit()
