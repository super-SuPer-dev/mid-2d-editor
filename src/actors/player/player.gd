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
const RUN_ACCELERATION := 1800.0
const GROUND_DECELERATION := 2400.0
const AIR_CONTROL_FACTOR := 0.72
const JUMP_RELEASE_FACTOR := 0.52
const VISUAL_Y_SPEED := 48.0
const IDLE_VISUAL_Y := -12.0
const RUN_VISUAL_Y := -9.0
const CUTTER_SWING_TEXTURE: Texture2D = preload("res://assets/vfx/cutter/cutter_swing_arc_normalized_v1.png")
const PLAYER_HIT_TEXTURE: Texture2D = preload("res://assets/vfx/damage/damage_player_hit_normalized_v1.png")
const STATUS_CONTAMINATION_TEXTURE: Texture2D = preload("res://assets/vfx/damage/status_root_contamination_normalized_v1.png")

@onready var body_visual: AnimatedSprite2D = $BodyVisual
@onready var attack_vfx: AnimatedSprite2D = $AttackVfx
@onready var status_vfx: AnimatedSprite2D = $StatusVfx
@onready var player_hit_vfx: AnimatedSprite2D = $PlayerHitVfx
@onready var camera: Camera2D = $Camera2D
@onready var attack_area: Area2D = $AttackArea
@onready var attack_shape: CollisionShape2D = $AttackArea/CollisionShape2D
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
var dash_cooldown_duration: float = DASH_COOLDOWN
var attack_timer: float = 0.0
var invulnerability_timer: float = 0.0
var hit_targets: Dictionary = {}
var idle_visual_y: float = IDLE_VISUAL_Y
var run_visual_y: float = RUN_VISUAL_Y
var character_id: String = CharacterCatalog.DEFAULT_CHARACTER
var mastery_rank: int = 0
var recovery_sample_count: int = 0


func _ready() -> void:
	character_id = CharacterCatalog.resolve_character_id(GameManager.selected_character_id)
	mastery_rank = SaveManager.get_mastery_rank(character_id)
	var character := CharacterCatalog.get_character(character_id)
	move_speed = float(character["move_speed"])
	jump_velocity = float(character["jump_velocity"])
	attack_damage = int(character["attack_damage"])
	dash_speed = float(character["dash_speed"])
	idle_visual_y = float(character.get("idle_visual_y", IDLE_VISUAL_Y))
	run_visual_y = float(character.get("run_visual_y", RUN_VISUAL_Y))
	_setup_character_animations(character["art_texture"], float(character.get("frame_inset", CharacterCatalog.FRAME_INSET)))
	_setup_cutter_vfx()
	_setup_damage_vfx()
	attack_damage += SaveManager.get_upgrade_level("blade")
	var engine_level := SaveManager.get_upgrade_level("engine")
	move_speed *= 1.0 + engine_level * 0.05
	dash_speed *= 1.0 + engine_level * 0.04
	health.max_health = int(character["max_health"]) + SaveManager.get_upgrade_level("armor")
	_apply_passive()
	health.reset()
	health.health_changed.connect(_on_health_changed)
	health.died.connect(_on_died)
	GameManager.player_movement_changed.connect(_on_movement_changed)
	GameManager.god_mode_changed.connect(_on_god_mode_changed)
	GameManager.currency_changed.connect(_on_currency_changed)
	_on_health_changed(health.current_health, health.max_health)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up"):
		jump_buffer_timer = JUMP_BUFFER_TIME
	elif event.is_action_released("move_up") and velocity.y < -80.0:
		velocity.y *= JUMP_RELEASE_FACTOR
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
		var target_speed := direction * move_speed
		var acceleration := GROUND_DECELERATION if is_zero_approx(direction) else RUN_ACCELERATION
		if not is_on_floor():
			acceleration *= AIR_CONTROL_FACTOR
		velocity.x = move_toward(velocity.x, target_speed, acceleration * delta)
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
	_update_character_animation(delta)


func _setup_character_animations(texture: Texture2D, frame_inset: float) -> void:
	var frames := SpriteFrames.new()
	frames.remove_animation(&"default")
	var animations := {&"idle": 0, &"run": 1, &"attack": 2, &"dash": 3}
	var animation_speeds := {&"idle": 6.0, &"run": 10.0, &"attack": 16.0, &"dash": 16.0}
	for animation: StringName in animations:
		frames.add_animation(animation)
		frames.set_animation_speed(animation, animation_speeds[animation])
		frames.set_animation_loop(animation, animation == &"idle" or animation == &"run")
		for column in range(4):
			var frame := CharacterCatalog.get_sprite_frame(texture, column, animations[animation], frame_inset)
			frames.add_frame(animation, frame)
	body_visual.sprite_frames = frames
	body_visual.play(&"idle")


func _update_character_animation(delta: float) -> void:
	var desired: StringName = &"idle"
	if dash_timer > 0.0:
		desired = &"dash"
	elif attack_timer > 0.0:
		desired = &"attack"
	elif absf(velocity.x) > 10.0 and is_on_floor():
		desired = &"run"
	var target_visual_y := run_visual_y if desired == &"run" else idle_visual_y
	body_visual.position.y = move_toward(body_visual.position.y, target_visual_y, VISUAL_Y_SPEED * delta)
	body_visual.speed_scale = clampf(absf(velocity.x) / maxf(move_speed, 1.0), 0.85, 1.15) if desired == &"run" else 1.0
	if body_visual.animation != desired:
		body_visual.play(desired)


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
	body_visual.modulate.a = 0.45 if invulnerability_timer > 0.0 and int(invulnerability_timer * 18.0) % 2 == 0 else 1.0


func _start_attack() -> void:
	AudioManager.play_named_sfx(&"cutter_swing", 1.0, -10.0)
	attack_timer = ATTACK_DURATION
	hit_targets.clear()
	attack_area.position.x = 34.0 * facing
	attack_vfx.position.x = 34.0 * facing
	attack_vfx.flip_h = facing < 0.0
	attack_vfx.visible = true
	attack_vfx.play(&"swing")
	attack_area.set_deferred("monitoring", true)


func _setup_cutter_vfx() -> void:
	var frames := SpriteFrames.new()
	frames.remove_animation(&"default")
	frames.add_animation(&"swing")
	frames.set_animation_speed(&"swing", 18.0)
	frames.set_animation_loop(&"swing", false)
	for column in range(4):
		var frame := AtlasTexture.new()
		frame.atlas = CUTTER_SWING_TEXTURE
		frame.region = Rect2(Vector2(column * 800.0, 0.0), Vector2(800.0, 800.0))
		frame.filter_clip = true
		frames.add_frame(&"swing", frame)
	attack_vfx.sprite_frames = frames
	attack_vfx.animation_finished.connect(_on_attack_vfx_finished)


func _on_attack_vfx_finished() -> void:
	attack_vfx.visible = false


func _start_dash() -> void:
	AudioManager.play_named_sfx(&"dash", 1.0, -10.0)
	dash_timer = DASH_DURATION
	dash_cooldown_timer = dash_cooldown_duration
	invulnerability_timer = maxf(invulnerability_timer, DASH_DURATION)


func take_damage(amount: int = 1, source_direction: Vector2 = Vector2.ZERO) -> bool:
	if GameManager.is_god_mode or invulnerability_timer > 0.0:
		return false
	var resolved_amount := amount
	if character_id == "t800":
		resolved_amount = maxi(amount - int(CharacterCatalog.get_passive_strength(character_id, mastery_rank)), 1)
	if not health.take_damage(resolved_amount):
		return false
	AudioManager.play_named_sfx(&"player_hurt", 1.0, -5.0)
	player_hit_vfx.visible = true
	player_hit_vfx.play(&"hit")
	invulnerability_timer = 0.8
	velocity = Vector2(-source_direction.x * 260.0, -220.0)
	return true


func show_status_vfx() -> void:
	status_vfx.visible = true
	status_vfx.play(&"contamination")


func _setup_damage_vfx() -> void:
	_setup_effect_animation(player_hit_vfx, &"hit", PLAYER_HIT_TEXTURE, 16.0, false)
	player_hit_vfx.animation_finished.connect(_on_player_hit_vfx_finished)
	_setup_effect_animation(status_vfx, &"contamination", STATUS_CONTAMINATION_TEXTURE, 8.0, true)
	status_vfx.animation_finished.connect(_on_status_vfx_finished)


func _setup_effect_animation(effect: AnimatedSprite2D, animation_name: StringName, texture: Texture2D, fps: float, loops: bool) -> void:
	var frames := SpriteFrames.new()
	frames.remove_animation(&"default")
	frames.add_animation(animation_name)
	frames.set_animation_speed(animation_name, fps)
	frames.set_animation_loop(animation_name, loops)
	for column in range(4):
		var frame := AtlasTexture.new()
		frame.atlas = texture
		frame.region = Rect2(Vector2(column * 800.0, 0.0), Vector2(800.0, 800.0))
		frame.filter_clip = true
		frames.add_frame(animation_name, frame)
	effect.sprite_frames = frames


func _on_player_hit_vfx_finished() -> void:
	player_hit_vfx.visible = false


func _on_status_vfx_finished() -> void:
	status_vfx.visible = false


func heal(amount: int) -> bool:
	return health.heal(amount)


func set_camera_limits(level_size: Vector2) -> void:
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


func _apply_passive() -> void:
	var strength := CharacterCatalog.get_passive_strength(character_id, mastery_rank)
	match character_id:
		"rin":
			dash_cooldown_duration = DASH_COOLDOWN * (1.0 - strength)
		"khem":
			var shape := attack_shape.shape.duplicate() as RectangleShape2D
			shape.size.x *= 1.0 + strength
			attack_shape.shape = shape
			attack_area.position.x *= 1.0 + strength * 0.35


func _on_currency_changed(_current_amount: int, change: int) -> void:
	if character_id != "tonkla" or change <= 0:
		return
	recovery_sample_count += change
	var required := int(CharacterCatalog.get_passive_strength(character_id, mastery_rank))
	while recovery_sample_count >= required:
		recovery_sample_count -= required
		heal(1)
