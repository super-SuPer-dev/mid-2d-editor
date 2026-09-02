class_name RinProjectile
extends Area2D

const DEFAULT_TEXTURE: Texture2D = preload("res://assets/placeholders/rin_projectile.svg")

@onready var visual: Sprite2D = $Visual

var direction: Vector2 = Vector2.RIGHT
var speed: float = 640.0
var damage: int = 1
var lifetime: float = 1.4
var active: bool = true


func _ready() -> void:
	add_to_group("PlayerProjectile")


func activate(
	origin: Vector2,
	travel_direction: Vector2,
	travel_speed: float,
	hit_damage: int,
	active_lifetime: float
) -> void:
	global_position = origin
	direction = travel_direction.normalized()
	speed = travel_speed
	damage = hit_damage
	lifetime = active_lifetime
	active = true
	visible = true
	monitoring = true
	monitorable = true
	rotation = direction.angle()
	visual.texture = DEFAULT_TEXTURE
	visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST


func _physics_process(delta: float) -> void:
	if not active:
		return
	position += direction * speed * delta
	lifetime -= delta
	if lifetime <= 0.0:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if not active:
		return
	var target := area.get_parent()
	if target.is_in_group("Enemy") and target.has_method("take_damage"):
		active = false
		target.take_damage(damage, direction)
		queue_free()
