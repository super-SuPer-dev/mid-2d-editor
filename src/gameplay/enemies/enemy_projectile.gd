class_name EnemyProjectile
extends Area2D

signal retired(projectile: EnemyProjectile)

@export var speed: float = 260.0
var direction: Vector2 = Vector2.LEFT
var damage: int = 1
var lifetime: float = 4.0
var recyclable: bool = false
var active: bool = true


func _ready() -> void:
	rotation = direction.angle() - PI
	add_to_group("EnemyProjectile")


func _physics_process(delta: float) -> void:
	if not active:
		return
	position += direction * speed * delta
	lifetime -= delta
	if lifetime <= 0.0:
		_retire()


func _on_body_entered(body: Node2D) -> void:
	if not active:
		return
	if body.has_method("take_damage"):
		body.take_damage(damage, direction)
	_retire()


func activate(origin: Vector2, travel_direction: Vector2, travel_speed: float, hit_damage: int, active_lifetime: float) -> void:
	global_position = origin
	direction = travel_direction.normalized()
	speed = travel_speed
	damage = hit_damage
	lifetime = active_lifetime
	rotation = direction.angle() - PI
	active = true
	visible = true
	monitoring = true
	monitorable = true
	set_physics_process(true)
	$CollisionShape2D.set_deferred("disabled", false)


func retire_now() -> void:
	_retire()


func _retire() -> void:
	if not active:
		return
	active = false
	monitoring = false
	monitorable = false
	visible = false
	set_physics_process(false)
	$CollisionShape2D.set_deferred("disabled", true)
	if recyclable:
		retired.emit(self)
	else:
		queue_free()
