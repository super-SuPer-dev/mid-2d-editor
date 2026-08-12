class_name PlayerController
extends CharacterBody2D

signal died
signal health_changed(current_health: int, maximum_health: int)

const GRAVITY := 1200.0
const COYOTE_TIME := 0.12
const JUMP_BUFFER_TIME := 0.12
const DASH_DURATION := 0.16
const DASH_COOLDOWN := 0.7
const ATTACK_DURATION := 0.15

@onready var body_visual: Sprite2D = $BodyVisual
@onready var attack_area: Area2D = $AttackArea
@onready var attack_arc: Sprite2D = $AttackArea/AttackArc
@onready var health: HealthComponent = $HealthComponent

var move_speed: float = 190.0
var jump_velocity: float = -390.0
var attack_damage: int = 2
var dash_speed: float = 470.0
var movement_enabled: bool = true
var facing: float = 1.0
var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0
var dash_timer: float = 0.0
var dash_cooldown_timer: float = 0.0
var attack_timer: float = 0.0
var invulnerability_timer: float = 0.0
var hit_targets: Dictionary = {}


func _ready() -> void:
	var character := CharacterCatalog.get_character(GameManager.selected_character_id)
	move_speed = float(character["move_speed"])
	jump_velocity = float(character["jump_velocity"])
	attack_damage = int(character["attack_damage"])
	dash_speed = float(character["dash_speed"])
	attack_damage += SaveManager.get_upgrade_level("blade")
	move_speed *= 1.0 + SaveManager.get_upgrade_level("engine") * 0.05
	dash_speed *= 1.0 + SaveManager.get_upgrade_level("engine") * 0.04
	health.max_health = int(character["max_health"]) + SaveManager.get_upgrade_level("armor")
	health.reset()
	body_visual.self_modulate = Color.WHITE.lerp(character["color"], 0.22)
	health.health_changed.connect(_on_health_changed)
	health.died.connect(_on_died)
	GameManager.player_movement_changed.connect(_on_movement_changed)
	GameManager.god_mode_changed.connect(_on_god_mode_changed)
	_on_health_changed(health.current_health, health.max_health)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up"):
		jump_buffer_timer = JUMP_BUFFER_TIME
	elif event.is_action_pressed("attack") and attack_timer <= 0.0 and movement_enabled:
		_start_attack()
	elif event.is_action_pressed("dash") and dash_cooldown_timer <= 0.0 and movement_enabled:
		_start_dash()
	elif event.is_action_pressed("god"):
		GameManager.toggle_god_mode()


func _physics_process(delta: float) -> void:
	_update_timers(delta)
	if global_position.y > 1000.0:
		take_damage(999, Vector2.UP)
		return

	if dash_timer > 0.0:
		velocity = Vector2(facing * dash_speed, 0.0)
	else:
		velocity.y += GRAVITY * delta
		var direction := Input.get_axis("move_left", "move_right") if movement_enabled else 0.0
		velocity.x = move_toward(velocity.x, direction * move_speed, 1500.0 * delta)
		if not is_zero_approx(direction):
			facing = signf(direction)
			body_visual.scale.x = absf(body_visual.scale.x) * facing

	if is_on_floor():
		coyote_timer = COYOTE_TIME
	if jump_buffer_timer > 0.0 and coyote_timer > 0.0 and movement_enabled and dash_timer <= 0.0:
		velocity.y = jump_velocity
		jump_buffer_timer = 0.0
		coyote_timer = 0.0

	move_and_slide()


func _update_timers(delta: float) -> void:
	coyote_timer = maxf(coyote_timer - delta, 0.0)
	jump_buffer_timer = maxf(jump_buffer_timer - delta, 0.0)
	dash_timer = maxf(dash_timer - delta, 0.0)
	dash_cooldown_timer = maxf(dash_cooldown_timer - delta, 0.0)
	invulnerability_timer = maxf(invulnerability_timer - delta, 0.0)
	if attack_timer > 0.0:
		attack_timer = maxf(attack_timer - delta, 0.0)
		if attack_timer <= 0.0:
			attack_area.set_deferred("monitoring", false)
			attack_arc.visible = false
	body_visual.modulate.a = 0.45 if invulnerability_timer > 0.0 and int(invulnerability_timer * 18.0) % 2 == 0 else 1.0


func _start_attack() -> void:
	AudioManager.play_sfx(1.2, -10.0)
	attack_timer = ATTACK_DURATION
	hit_targets.clear()
	attack_area.position.x = 34.0 * facing
	attack_area.set_deferred("monitoring", true)
	attack_arc.visible = true


func _start_dash() -> void:
	dash_timer = DASH_DURATION
	dash_cooldown_timer = DASH_COOLDOWN
	invulnerability_timer = maxf(invulnerability_timer, DASH_DURATION)


func take_damage(amount: int = 1, source_direction: Vector2 = Vector2.ZERO) -> bool:
	if GameManager.is_god_mode or invulnerability_timer > 0.0:
		return false
	if not health.take_damage(amount):
		return false
	AudioManager.play_sfx(0.7, -5.0)
	invulnerability_timer = 0.8
	velocity = Vector2(-source_direction.x * 260.0, -220.0)
	return true


func heal(amount: int) -> bool:
	return health.heal(amount)


func set_camera_limits(level_size: Vector2) -> void:
	var camera: Camera2D = $Camera2D
	camera.limit_left = 0
	camera.limit_top = 0
	camera.limit_right = int(level_size.x)
	camera.limit_bottom = int(level_size.y)


func _on_attack_area_area_entered(area: Area2D) -> void:
	var target := area.get_parent()
	var key := target.get_instance_id()
	if target.has_method("take_damage") and not hit_targets.has(key):
		hit_targets[key] = true
		target.take_damage(attack_damage, Vector2(facing, 0.0))


func _on_health_changed(current_health: int, maximum_health: int) -> void:
	health_changed.emit(current_health, maximum_health)


func _on_died() -> void:
	movement_enabled = false
	velocity = Vector2.ZERO
	died.emit()


func _on_movement_changed(enabled: bool) -> void:
	movement_enabled = enabled


func _on_god_mode_changed(_enabled: bool) -> void:
	body_visual.modulate = Color("a6ffcb") if GameManager.is_god_mode else Color.WHITE
