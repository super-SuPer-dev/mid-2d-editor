class_name EnemyProjectile
extends Area2D

@export var speed: float = 260.0
var direction: Vector2 = Vector2.LEFT
var damage: int = 1
var lifetime: float = 4.0


func _ready() -> void:
	rotation = direction.angle() - PI


func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	lifetime -= delta
	if lifetime <= 0.0:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage, direction)
	queue_free()
