class_name DamageHazard
extends Area2D

@export var damage: int = 2


func set_size(size: Vector2) -> void:
	var shape := RectangleShape2D.new()
	shape.size = size
	$CollisionShape2D.shape = shape
	var half := size * 0.5
	$Visual.polygon = PackedVector2Array([
		Vector2(-half.x, half.y), Vector2(-half.x * 0.75, -half.y),
		Vector2(-half.x * 0.5, half.y), Vector2(-half.x * 0.25, -half.y),
		Vector2(0, half.y), Vector2(half.x * 0.25, -half.y),
		Vector2(half.x * 0.5, half.y), Vector2(half.x * 0.75, -half.y),
		Vector2(half.x, half.y),
	])


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage, Vector2(0.0, -1.0))
