class_name ExitPortal
extends Area2D

signal player_entered

@onready var visual: Sprite2D = $Visual
@onready var label: Label = $Label

var active: bool = false
var elapsed: float = 0.0


func _process(delta: float) -> void:
	elapsed += delta
	visual.modulate = Color("c9ff8c") if active else Color("9a9d91")
	visual.scale = Vector2.ONE * (1.0 + sin(elapsed * (4.0 if active else 1.5)) * 0.025)
	label.text = "จุดถอนกำลัง" if active else "พื้นที่ยังไม่ปลอดภัย"


func set_active(enabled: bool) -> void:
	active = enabled


func _on_body_entered(body: Node2D) -> void:
	if active and body.is_in_group("Player"):
		player_entered.emit()
