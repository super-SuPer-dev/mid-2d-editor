class_name EnemyController
extends CharacterBody2D

const GRAVITY := 1200.0
const PROJECTILE_SCENE := preload("res://Scenes/gameplay/enemy_projectile.tscn")

@onready var visual: Sprite2D = $Visual
@onready var health: HealthComponent = $HealthComponent
@onready var health_bar: ProgressBar = $HealthBar

@export_enum("thornling", "spitter", "maw", "banyan_boss") var enemy_type: String = "thornling"
var target: PlayerController
var move_speed: float = 85.0
var contact_damage: int = 1
var detection_range: float = 430.0
var attack_cooldown: float = 0.0
var shoot_cooldown: float = 0.0
var facing: float = -1.0
var defeated: bool = false


func configure(type_id: String) -> void:
	enemy_type = type_id
	match enemy_type:
		"spitter":
			move_speed = 35.0
			health.max_health = 5
			contact_damage = 2
			visual.modulate = Color("b7d46c")
		"maw":
			move_speed = 70.0
			health.max_health = 8
			contact_damage = 2
			visual.modulate = Color("9b6b78")
			scale = Vector2(1.25, 1.25)
		"banyan_boss":
			move_speed = 105.0
			health.max_health = 24
			contact_damage = 2
			detection_range = 700.0
			visual.modulate = Color("a46aa4")
			scale = Vector2(1.8, 1.8)
		_:
			health.max_health = 3
			visual.modulate = Color.WHITE
	health.reset()


func _ready() -> void:
	configure(enemy_type)
	health.health_changed.connect(_on_health_changed)
	health.died.connect(_on_died)
	call_deferred("_find_target")
	_on_health_changed(health.current_health, health.max_health)


func _find_target() -> void:
	target = get_tree().get_first_node_in_group("Player") as PlayerController


func _physics_process(delta: float) -> void:
	if global_position.y > 1000.0:
		_on_died()
		return
	attack_cooldown = maxf(attack_cooldown - delta, 0.0)
	shoot_cooldown = maxf(shoot_cooldown - delta, 0.0)
	velocity.y += GRAVITY * delta
	if is_instance_valid(target):
		var offset := target.global_position - global_position
		if absf(offset.x) < detection_range and absf(offset.y) < 180.0:
			facing = signf(offset.x)
			if enemy_type == "spitter":
				velocity.x = 0.0
				if shoot_cooldown <= 0.0:
					_shoot(offset.normalized())
			else:
				velocity.x = facing * move_speed
			if offset.length() < 58.0 and attack_cooldown <= 0.0:
				target.take_damage(contact_damage, Vector2(facing, 0.0))
				attack_cooldown = 0.9
		else:
			velocity.x = move_toward(velocity.x, 0.0, 500.0 * delta)
	visual.scale.x = absf(visual.scale.x) * facing
	move_and_slide()


func _shoot(direction: Vector2) -> void:
	shoot_cooldown = 1.8
	var projectile := PROJECTILE_SCENE.instantiate() as EnemyProjectile
	projectile.direction = direction
	projectile.damage = contact_damage
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position + Vector2(facing * 28.0, -8.0)


func take_damage(amount: int = 1, source_direction: Vector2 = Vector2.ZERO) -> bool:
	var applied := health.take_damage(amount)
	if applied:
		velocity = Vector2(source_direction.x * 180.0, -120.0)
	return applied


func _on_health_changed(current_health: int, maximum_health: int) -> void:
	health_bar.max_value = maximum_health
	health_bar.value = current_health
	health_bar.visible = current_health < maximum_health


func _on_died() -> void:
	if defeated:
		return
	defeated = true
	AudioManager.play_sfx(0.55 if enemy_type == "banyan_boss" else 0.85, -8.0)
	GameManager.register_enemy_defeated()
	queue_free()
