class_name EnemyController
extends CharacterBody2D

signal defeated_event(enemy: EnemyController)
signal boss_phase_changed(current_phase: int, phase_count: int)

const GRAVITY := 1200.0
const PROJECTILE_SCENE := preload("res://scenes/gameplay/enemy_projectile.tscn")
const THORNLING_TEXTURE := preload("res://assets/enemies/standard/thornling.png")
const SPITTER_TEXTURE := preload("res://assets/enemies/standard/spitter.png")
const THORN_MATRIARCH_TEXTURE := preload("res://assets/enemies/bosses/thorn_matriarch.png")

@onready var visual: Sprite2D = $Visual
@onready var health: HealthComponent = $HealthComponent
@onready var health_bar: ProgressBar = $HealthBar
@onready var pattern_runner: BossProjectilePatternRunner = $BossProjectilePatternRunner

@export_enum("thornling", "spitter", "maw", "thorn_matriarch_boss", "maw_sovereign_boss", "banyan_boss", "root_hydra_boss", "root_core_eye_boss") var enemy_type: String = "thornling"
var target: PlayerController
var move_speed: float = 85.0
var contact_damage: int = 1
var detection_range: float = 430.0
var attack_cooldown: float = 0.0
var shoot_cooldown: float = 0.0
var facing: float = -1.0
var defeated: bool = false
var is_boss: bool = false
var combat_active: bool = true
var pattern_attack_locked: bool = false
var boss_phase: int = 1
var boss_phase_count: int = 1
var base_visual_modulate: Color = Color.WHITE


func configure(type_id: String) -> void:
	enemy_type = type_id
	is_boss = enemy_type.ends_with("_boss")
	if is_boss:
		add_to_group("Boss")
	match enemy_type:
		"thornling":
			move_speed = 85.0
			health.max_health = 3
			visual.texture = THORNLING_TEXTURE
			visual.modulate = Color.WHITE
			visual.scale = Vector2(0.035, 0.035)
			visual.position = Vector2(0.0, 1.5)
		"spitter":
			move_speed = 35.0
			health.max_health = 5
			contact_damage = 2
			visual.texture = SPITTER_TEXTURE
			visual.modulate = Color.WHITE
			visual.scale = Vector2(0.04, 0.04)
			visual.position = Vector2(0.0, -1.5)
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
		"thorn_matriarch_boss":
			move_speed = 82.0
			health.max_health = 28
			contact_damage = 2
			detection_range = 760.0
			visual.modulate = Color("bd6b72")
			visual.texture = THORN_MATRIARCH_TEXTURE
			visual.modulate = Color.WHITE
			visual.scale = Vector2(0.055, 0.055)
			# The source has transparent lower padding; offset the visible root baseline
			# to the floor while the compact collision body remains stable.
			visual.position = Vector2(0.0, -3.0)
			scale = Vector2(1.9, 1.9)
		"maw_sovereign_boss":
			move_speed = 64.0
			health.max_health = 34
			contact_damage = 3
			detection_range = 780.0
			visual.modulate = Color("8f617d")
			scale = Vector2(2.0, 2.0)
		_:
			health.max_health = 3
			visual.modulate = Color.WHITE
	health.reset()


func _ready() -> void:
	configure(enemy_type)
	base_visual_modulate = visual.modulate
	if is_boss:
		pattern_runner.configure(self, _get_boss_pattern_set_id(), contact_damage)
		boss_phase = 1
		boss_phase_count = pattern_runner.phase_count
		pattern_runner.telegraph_started.connect(_on_pattern_telegraph_started)
		pattern_runner.pattern_started.connect(_on_pattern_started)
		pattern_runner.recovery_started.connect(_on_pattern_recovery_started)
		pattern_runner.set_active(combat_active)
	health.health_changed.connect(_on_health_changed)
	health.died.connect(_on_died)
	call_deferred("_find_target")
	_on_health_changed(health.current_health, health.max_health)


func _find_target() -> void:
	target = get_tree().get_first_node_in_group("Player") as PlayerController


func _physics_process(delta: float) -> void:
	if not combat_active:
		return
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
			if pattern_attack_locked:
				velocity.x = 0.0
			elif enemy_type == "spitter":
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
	if is_boss:
		_update_boss_phase(current_health, maximum_health)
		GameManager.update_boss_health(current_health, maximum_health)


func _update_boss_phase(current_health: int, maximum_health: int) -> void:
	if current_health <= 0 or maximum_health <= 0:
		return
	var damage_fraction := float(maximum_health - current_health) / float(maximum_health)
	var next_phase := clampi(floori(damage_fraction * boss_phase_count) + 1, 1, boss_phase_count)
	if next_phase <= boss_phase:
		return
	boss_phase = next_phase
	pattern_runner.set_phase(boss_phase)
	boss_phase_changed.emit(boss_phase, boss_phase_count)
	GameManager.update_boss_phase(boss_phase, boss_phase_count)


func _on_died() -> void:
	if defeated:
		return
	defeated = true
	defeated_event.emit(self)
	pattern_runner.dispose_projectiles()
	AudioManager.play_sfx(0.55 if is_boss else 0.85, -8.0)
	if is_boss:
		GameManager.register_boss_defeated()
	else:
		GameManager.register_enemy_defeated()
	queue_free()


func set_combat_active(active: bool) -> void:
	if defeated:
		return
	combat_active = active
	if is_boss:
		pattern_runner.set_active(active)
	visible = active
	process_mode = Node.PROCESS_MODE_INHERIT if active else Node.PROCESS_MODE_DISABLED
	$CollisionShape2D.set_deferred("disabled", not active)
	$HurtBox/CollisionShape2D.set_deferred("disabled", not active)
	if active:
		GameManager.update_boss_health(health.current_health, health.max_health)
		GameManager.update_boss_phase(boss_phase, boss_phase_count)


func _get_boss_pattern_set_id() -> String:
	match enemy_type:
		"thorn_matriarch_boss":
			return "thorn_matriarch_tutorial"
		"maw_sovereign_boss":
			return "maw_sovereign_spore"
		"banyan_boss":
			return "possessed_banyan_control"
		"root_hydra_boss":
			return "root_hydra_crossfire"
		"root_core_eye_boss":
			return "root_core_eye_final"
	return ""


func _on_pattern_telegraph_started(_pattern_id: String) -> void:
	pattern_attack_locked = true
	velocity.x = 0.0
	visual.modulate = Color(1.35, 1.1, 0.72, 1.0)


func _on_pattern_started(_pattern_id: String) -> void:
	pattern_attack_locked = true
	visual.modulate = base_visual_modulate


func _on_pattern_recovery_started(_pattern_id: String) -> void:
	pattern_attack_locked = false
	visual.modulate = base_visual_modulate.darkened(0.18)
