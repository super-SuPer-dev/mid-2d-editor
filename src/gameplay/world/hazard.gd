class_name DamageHazard
extends Area2D

@export var damage: int = 2


func set_size(size: Vector2) -> void:
	var shape := RectangleShape2D.new()
	shape.size = size
	$CollisionShape2D.shape = shape
	$Visual.scale = Vector2(size.x / 64.0, size.y / 20.0)


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage, Vector2(0.0, -1.0))
