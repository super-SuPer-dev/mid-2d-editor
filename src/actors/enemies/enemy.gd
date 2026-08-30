class_name EnemyController
extends CharacterBody2D

signal defeated_event(enemy: EnemyController)
signal boss_phase_changed(current_phase: int, phase_count: int)

const GRAVITY := 1200.0
const PROJECTILE_SCENE := preload("res://scenes/gameplay/enemy_projectile.tscn")
const THORNLING_TEXTURE := preload("res://assets/enemies/standard/thornling.png")
const THORNLING_IDLE_TEXTURE: Texture2D = preload("res://assets/enemies/standard/thornling/thornling_idle_strip_normalized_v2.png")
const THORNLING_RUN_TEXTURE: Texture2D = preload("res://assets/enemies/standard/thornling/thornling_run_strip_normalized_v2.png")
const SPITTER_TEXTURE := preload("res://assets/enemies/standard/spitter.png")
const SPITTER_IDLE_TEXTURE: Texture2D = preload("res://assets/enemies/standard/spitter/spitter_idle_strip_normalized_v2.png")
const SPITTER_WALK_TEXTURE: Texture2D = preload("res://assets/enemies/standard/spitter/spitter_walk_strip_normalized_v2.png")
const MAW_IDLE_TEXTURE: Texture2D = preload("res://assets/enemies/standard/maw/maw_idle_strip_normalized_v2.png")
const MAW_MOVE_TEXTURE: Texture2D = preload("res://assets/enemies/standard/maw/maw_move_strip_normalized_v2.png")
const CAPSULE_HUSK_IDLE_TEXTURE: Texture2D = preload("res://assets/enemies/standard/capsule_husk/capsule_husk_idle_strip_normalized_v2.png")
const CAPSULE_HUSK_MOVE_TEXTURE: Texture2D = preload("res://assets/enemies/standard/capsule_husk/capsule_husk_move_strip_normalized_v2.png")
const THORN_MATRIARCH_TEXTURE := preload("res://assets/enemies/bosses/thorn_matriarch.png")
const ROOT_SKITTER_IDLE_TEXTURE: Texture2D = preload("res://assets/enemies/standard/root_skitter/root_skitter_idle_strip_normalized_v2.png")
const ROOT_SKITTER_SCUTTLE_TEXTURE: Texture2D = preload("res://assets/enemies/standard/root_skitter/root_skitter_scuttle_strip_normalized_v2.png")
const ROOT_HYDRA_IDLE_TEXTURE: Texture2D = preload("res://assets/enemies/bosses/root_hydra/root_hydra_idle_strip_normalized_v2.png")
const ROOT_HYDRA_EXPOSED_TEXTURE: Texture2D = preload("res://assets/enemies/bosses/root_hydra/root_hydra_idle_exposed_strip_normalized_v2.png")
const EYE_WISP_HOVER_TEXTURE: Texture2D = preload("res://assets/enemies/standard/eye_wisp/eye_wisp_hover_strip_normalized_v2.png")
const EYE_WISP_FLY_TEXTURE: Texture2D = preload("res://assets/enemies/standard/eye_wisp/eye_wisp_fly_strip_normalized_v2.png")
const ROOT_CORE_EYE_SEALED_TEXTURE: Texture2D = preload("res://assets/enemies/bosses/root_core_eye/root_core_eye_idle_sealed_normalized_v2.png")
const ROOT_CORE_EYE_EXPOSED_TEXTURE: Texture2D = preload("res://assets/enemies/bosses/root_core_eye/root_core_eye_idle_exposed_normalized_v2.png")
const THORN_MATRIARCH_ARMORED_TEXTURE: Texture2D = preload("res://assets/enemies/bosses/thorn_matriarch/thorn_matriarch_idle_armored_strip_normalized_v2.png")
const THORN_MATRIARCH_EXPOSED_TEXTURE: Texture2D = preload("res://assets/enemies/bosses/thorn_matriarch/thorn_matriarch_idle_exposed_strip_normalized_v2.png")
const THORN_MATRIARCH_FAN_CAST_TEXTURE: Texture2D = preload("res://assets/enemies/bosses/thorn_matriarch/thorn_matriarch_fan_cast_strip_normalized_v2.png")
const THORN_MATRIARCH_MINE_CAST_TEXTURE: Texture2D = preload("res://assets/enemies/bosses/thorn_matriarch/thorn_matriarch_mine_cast_strip_normalized_v2.png")
const MAW_SOVEREIGN_ARMORED_TEXTURE: Texture2D = preload("res://assets/enemies/bosses/maw_sovereign/maw_sovereign_idle_armored_strip_normalized_v2.png")
const MAW_SOVEREIGN_EXPOSED_TEXTURE: Texture2D = preload("res://assets/enemies/bosses/maw_sovereign/maw_sovereign_idle_exposed_strip_normalized_v2.png")
const MAW_SOVEREIGN_SPORE_CAST_TEXTURE: Texture2D = preload("res://assets/enemies/bosses/maw_sovereign/maw_sovereign_spore_cast_strip_normalized_v2.png")
const MAW_SOVEREIGN_ROTATING_CAST_TEXTURE: Texture2D = preload("res://assets/enemies/bosses/maw_sovereign/maw_sovereign_rotating_volley_cast_strip_normalized_v2.png")
const MAW_SOVEREIGN_AIMED_CAST_TEXTURE: Texture2D = preload("res://assets/enemies/bosses/maw_sovereign/maw_sovereign_aimed_volley_cast_strip_normalized_v2.png")
const POSSESSED_BANYAN_ARMORED_TEXTURE: Texture2D = preload("res://assets/enemies/bosses/possessed_banyan/possessed_banyan_idle_armored_strip_normalized_v2.png")
const POSSESSED_BANYAN_EXPOSED_TEXTURE: Texture2D = preload("res://assets/enemies/bosses/possessed_banyan/possessed_banyan_idle_exposed_strip_normalized_v2.png")
const POSSESSED_BANYAN_SEED_COLUMN_CAST_TEXTURE: Texture2D = preload("res://assets/enemies/bosses/possessed_banyan/possessed_banyan_seed_column_cast_strip_normalized_v2.png")
const POSSESSED_BANYAN_DIAGONAL_CAST_TEXTURE: Texture2D = preload("res://assets/enemies/bosses/possessed_banyan/possessed_banyan_diagonal_root_cast_strip_normalized_v2.png")

@onready var visual: Sprite2D = $Visual
@onready var health: HealthComponent = $HealthComponent
@onready var health_bar: ProgressBar = $HealthBar
@onready var pattern_runner: BossProjectilePatternRunner = $BossProjectilePatternRunner

@export_enum("thornling", "spitter", "maw", "root_skitter", "marsh_spitter", "eye_wisp", "capsule_husk_elite", "mixed_elite", "thorn_matriarch_boss", "maw_sovereign_boss", "banyan_boss", "root_hydra_boss", "root_core_eye_boss") var enemy_type: String = "thornling"
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
var root_skitter_action: StringName = &"idle"
var root_skitter_frame_clock: float = 0.0
var thornling_action: StringName = &"idle"
var thornling_frame_clock: float = 0.0
var spitter_action: StringName = &"idle"
var spitter_frame_clock: float = 0.0
var maw_action: StringName = &"idle"
var maw_frame_clock: float = 0.0
var capsule_husk_action: StringName = &"idle"
var capsule_husk_frame_clock: float = 0.0
var root_hydra_frame_clock: float = 0.0
var root_hydra_visual_phase: int = 0
var eye_wisp_frame_clock: float = 0.0
var eye_wisp_action: StringName = &"hover"
var root_core_eye_frame_clock: float = 0.0
var root_core_eye_visual_phase: int = 0
var thorn_matriarch_frame_clock: float = 0.0
var thorn_matriarch_visual_phase: int = 0
var thorn_matriarch_action: StringName = &"idle"
var maw_sovereign_frame_clock: float = 0.0
var maw_sovereign_visual_phase: int = 0
var maw_sovereign_action: StringName = &"idle"
var possessed_banyan_frame_clock: float = 0.0
var possessed_banyan_visual_phase: int = 0
var possessed_banyan_action: StringName = &"idle"


func configure(type_id: String) -> void:
	enemy_type = type_id
	is_boss = enemy_type.ends_with("_boss")
	if is_boss:
		add_to_group("Boss")
	match enemy_type:
		"thornling":
			move_speed = 85.0
			health.max_health = 3
			visual.texture = THORNLING_IDLE_TEXTURE
			visual.hframes = 4
			visual.vframes = 1
			visual.frame = 0
			visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			visual.modulate = Color.WHITE
			visual.scale = Vector2(0.06, 0.06)
			# The normalized strip uses a 740 px foot baseline in an 800 px cell.
			visual.position = Vector2(0.0, -18.0)
		"spitter":
			move_speed = 35.0
			health.max_health = 5
			contact_damage = 2
			visual.texture = SPITTER_IDLE_TEXTURE
			visual.hframes = 4
			visual.vframes = 1
			visual.frame = 0
			visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			visual.modulate = Color.WHITE
			visual.scale = Vector2(0.06, 0.06)
			# The normalized strip uses a 740 px foot baseline in an 800 px cell.
			visual.position = Vector2(0.0, -18.0)
		"maw":
			move_speed = 70.0
			health.max_health = 8
			contact_damage = 2
			visual.texture = MAW_IDLE_TEXTURE
			visual.hframes = 4
			visual.vframes = 1
			visual.frame = 0
			visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			visual.modulate = Color.WHITE
			visual.scale = Vector2(0.06, 0.06)
			# The normalized strip uses a 740 px foot baseline in an 800 px cell.
			visual.position = Vector2(0.0, -18.0)
			scale = Vector2(1.25, 1.25)
		"root_skitter":
			move_speed = 110.0
			health.max_health = 4
			visual.texture = ROOT_SKITTER_IDLE_TEXTURE
			visual.hframes = 4
			visual.vframes = 1
			visual.frame = 0
			visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			visual.modulate = Color.WHITE
			visual.scale = Vector2(0.05, 0.05)
			# The normalized strip uses a 740 px foot baseline in an 800 px cell.
			visual.position = Vector2(0.0, -17.0)
		"marsh_spitter":
			move_speed = 28.0
			health.max_health = 6
			contact_damage = 2
			visual.modulate = Color("6fabc0")
			visual.scale = Vector2(0.045, 0.045)
		"eye_wisp":
			move_speed = 95.0
			health.max_health = 5
			contact_damage = 2
			detection_range = 560.0
			visual.texture = EYE_WISP_HOVER_TEXTURE
			visual.hframes = 4
			visual.vframes = 1
			visual.frame = 0
			visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			visual.modulate = Color.WHITE
			visual.scale = Vector2(0.045, 0.045)
			visual.position = Vector2(0.0, -16.0)
		"capsule_husk_elite":
			move_speed = 58.0
			health.max_health = 12
			contact_damage = 3
			visual.texture = CAPSULE_HUSK_IDLE_TEXTURE
			visual.hframes = 4
			visual.vframes = 1
			visual.frame = 0
			visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			visual.modulate = Color.WHITE
			visual.scale = Vector2(0.06, 0.06)
			# The normalized strip uses a 740 px foot baseline in an 800 px cell.
			visual.position = Vector2(0.0, -18.0)
			scale = Vector2(1.35, 1.35)
		"mixed_elite":
			move_speed = 82.0
			health.max_health = 14
			contact_damage = 3
			detection_range = 600.0
			visual.modulate = Color("d09562")
			scale = Vector2(1.45, 1.45)
		"banyan_boss":
			move_speed = 105.0
			health.max_health = 24
			contact_damage = 2
			detection_range = 700.0
			visual.texture = POSSESSED_BANYAN_ARMORED_TEXTURE
			visual.hframes = 4
			visual.vframes = 1
			visual.frame = 0
			visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			visual.modulate = Color.WHITE
			visual.scale = Vector2(0.10, 0.10)
			# The normalized strip uses an 840 px foot baseline in a 900 px cell.
			visual.position = Vector2(0.0, -39.0)
			scale = Vector2(1.8, 1.8)
		"root_hydra_boss":
			move_speed = 58.0
			health.max_health = 40
			contact_damage = 3
			detection_range = 820.0
			visual.texture = ROOT_HYDRA_IDLE_TEXTURE
			visual.hframes = 4
			visual.vframes = 1
			visual.frame = 0
			visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			visual.modulate = Color.WHITE
			visual.scale = Vector2(0.12, 0.12)
			# The 1000 x 900 body cell is bottom-aligned to the 840 px baseline.
			visual.position = Vector2(0.0, -105.0)
			scale = Vector2(2.25, 2.25)
		"root_core_eye_boss":
			move_speed = 48.0
			health.max_health = 48
			contact_damage = 4
			detection_range = 900.0
			visual.texture = ROOT_CORE_EYE_SEALED_TEXTURE
			visual.hframes = 4
			visual.vframes = 1
			visual.frame = 0
			visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			visual.modulate = Color.WHITE
			visual.scale = Vector2(0.10, 0.10)
			# The 1000 x 900 body cell is bottom-aligned to the 840 px baseline.
			visual.position = Vector2(0.0, -105.0)
			scale = Vector2(2.5, 2.5)
		"thorn_matriarch_boss":
			move_speed = 82.0
			health.max_health = 28
			contact_damage = 2
			detection_range = 760.0
			visual.texture = THORN_MATRIARCH_ARMORED_TEXTURE
			visual.hframes = 4
			visual.vframes = 1
			visual.frame = 0
			visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			visual.modulate = Color.WHITE
			visual.scale = Vector2(0.10, 0.10)
			# The normalized strip uses an 840 px foot baseline in a 900 px cell.
			visual.position = Vector2(0.0, -39.0)
			scale = Vector2(1.9, 1.9)
		"maw_sovereign_boss":
			move_speed = 64.0
			health.max_health = 34
			contact_damage = 3
			detection_range = 780.0
			visual.texture = MAW_SOVEREIGN_ARMORED_TEXTURE
			visual.hframes = 4
			visual.vframes = 1
			visual.frame = 0
			visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			visual.modulate = Color.WHITE
			visual.scale = Vector2(0.10, 0.10)
			# The normalized strip uses an 840 px foot baseline in a 900 px cell.
			visual.position = Vector2(0.0, -39.0)
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
	_update_root_skitter_animation(delta)
	_update_thornling_animation(delta)
	_update_spitter_animation(delta)
	_update_maw_animation(delta)
	_update_capsule_husk_animation(delta)
	_update_root_hydra_animation(delta)
	_update_eye_wisp_animation(delta)
	_update_root_core_eye_animation(delta)
	_update_thorn_matriarch_animation(delta)
	_update_maw_sovereign_animation(delta)
	_update_possessed_banyan_animation(delta)


func _update_thornling_animation(delta: float) -> void:
	if enemy_type != "thornling":
		return
	var next_action: StringName = &"run" if is_on_floor() and absf(velocity.x) > 8.0 else &"idle"
	if next_action != thornling_action:
		thornling_action = next_action
		thornling_frame_clock = 0.0
		visual.texture = THORNLING_RUN_TEXTURE if next_action == &"run" else THORNLING_IDLE_TEXTURE
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	var frame_rate := 7.0 if next_action == &"run" else 4.0
	thornling_frame_clock = fmod(thornling_frame_clock + delta * frame_rate, 4.0)
	visual.frame = int(thornling_frame_clock)


func _update_spitter_animation(delta: float) -> void:
	if enemy_type != "spitter":
		return
	var next_action: StringName = &"walk" if is_on_floor() and absf(velocity.x) > 8.0 else &"idle"
	if next_action != spitter_action:
		spitter_action = next_action
		spitter_frame_clock = 0.0
		visual.texture = SPITTER_WALK_TEXTURE if next_action == &"walk" else SPITTER_IDLE_TEXTURE
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	var frame_rate := 7.0 if next_action == &"walk" else 4.0
	spitter_frame_clock = fmod(spitter_frame_clock + delta * frame_rate, 4.0)
	visual.frame = int(spitter_frame_clock)


func _update_maw_animation(delta: float) -> void:
	if enemy_type != "maw":
		return
	var next_action: StringName = &"move" if is_on_floor() and absf(velocity.x) > 8.0 else &"idle"
	if next_action != maw_action:
		maw_action = next_action
		maw_frame_clock = 0.0
		visual.texture = MAW_MOVE_TEXTURE if next_action == &"move" else MAW_IDLE_TEXTURE
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	var frame_rate := 6.0 if next_action == &"move" else 3.5
	maw_frame_clock = fmod(maw_frame_clock + delta * frame_rate, 4.0)
	visual.frame = int(maw_frame_clock)


func _update_capsule_husk_animation(delta: float) -> void:
	if enemy_type != "capsule_husk_elite":
		return
	var next_action: StringName = &"move" if is_on_floor() and absf(velocity.x) > 8.0 else &"idle"
	if next_action != capsule_husk_action:
		capsule_husk_action = next_action
		capsule_husk_frame_clock = 0.0
		visual.texture = CAPSULE_HUSK_MOVE_TEXTURE if next_action == &"move" else CAPSULE_HUSK_IDLE_TEXTURE
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	var frame_rate := 5.5 if next_action == &"move" else 3.5
	capsule_husk_frame_clock = fmod(capsule_husk_frame_clock + delta * frame_rate, 4.0)
	visual.frame = int(capsule_husk_frame_clock)


func _update_root_skitter_animation(delta: float) -> void:
	if enemy_type != "root_skitter":
		return
	var next_action: StringName = &"scuttle" if is_on_floor() and absf(velocity.x) > 8.0 else &"idle"
	if next_action != root_skitter_action:
		root_skitter_action = next_action
		root_skitter_frame_clock = 0.0
		visual.texture = ROOT_SKITTER_SCUTTLE_TEXTURE if next_action == &"scuttle" else ROOT_SKITTER_IDLE_TEXTURE
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	var frame_rate := 8.0 if next_action == &"scuttle" else 5.5
	root_skitter_frame_clock = fmod(root_skitter_frame_clock + delta * frame_rate, 4.0)
	visual.frame = int(root_skitter_frame_clock)


func _update_root_hydra_animation(delta: float) -> void:
	if enemy_type != "root_hydra_boss":
		return
	if root_hydra_visual_phase != boss_phase:
		root_hydra_visual_phase = boss_phase
		visual.texture = ROOT_HYDRA_EXPOSED_TEXTURE if boss_phase >= 2 else ROOT_HYDRA_IDLE_TEXTURE
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	root_hydra_frame_clock = fmod(root_hydra_frame_clock + delta * 3.0, 4.0)
	visual.frame = int(root_hydra_frame_clock)


func _update_eye_wisp_animation(delta: float) -> void:
	if enemy_type != "eye_wisp":
		return
	var next_action: StringName = &"fly" if absf(velocity.x) > 8.0 else &"hover"
	if next_action != eye_wisp_action:
		eye_wisp_action = next_action
		eye_wisp_frame_clock = 0.0
		visual.texture = EYE_WISP_FLY_TEXTURE if next_action == &"fly" else EYE_WISP_HOVER_TEXTURE
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	var frame_rate := 7.0 if next_action == &"fly" else 4.5
	eye_wisp_frame_clock = fmod(eye_wisp_frame_clock + delta * frame_rate, 4.0)
	visual.frame = int(eye_wisp_frame_clock)


func _update_root_core_eye_animation(delta: float) -> void:
	if enemy_type != "root_core_eye_boss":
		return
	if root_core_eye_visual_phase != boss_phase:
		root_core_eye_visual_phase = boss_phase
		visual.texture = ROOT_CORE_EYE_EXPOSED_TEXTURE if boss_phase >= 2 else ROOT_CORE_EYE_SEALED_TEXTURE
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	root_core_eye_frame_clock = fmod(root_core_eye_frame_clock + delta * 3.0, 4.0)
	visual.frame = int(root_core_eye_frame_clock)


func _update_thorn_matriarch_animation(delta: float) -> void:
	if enemy_type != "thorn_matriarch_boss":
		return
	var desired_texture: Texture2D = THORN_MATRIARCH_EXPOSED_TEXTURE if boss_phase >= 2 else THORN_MATRIARCH_ARMORED_TEXTURE
	if thorn_matriarch_action == &"fan_cast":
		desired_texture = THORN_MATRIARCH_FAN_CAST_TEXTURE
	elif thorn_matriarch_action == &"mine_cast":
		desired_texture = THORN_MATRIARCH_MINE_CAST_TEXTURE
	if thorn_matriarch_visual_phase != boss_phase or visual.texture != desired_texture:
		thorn_matriarch_visual_phase = boss_phase
		visual.texture = desired_texture
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	var frame_rate := 8.0 if thorn_matriarch_action != &"idle" else 3.0
	thorn_matriarch_frame_clock = fmod(thorn_matriarch_frame_clock + delta * frame_rate, 4.0)
	visual.frame = int(thorn_matriarch_frame_clock)


func _update_maw_sovereign_animation(delta: float) -> void:
	if enemy_type != "maw_sovereign_boss":
		return
	var desired_texture: Texture2D = MAW_SOVEREIGN_EXPOSED_TEXTURE if boss_phase >= 2 else MAW_SOVEREIGN_ARMORED_TEXTURE
	match maw_sovereign_action:
		&"spore_cast":
			desired_texture = MAW_SOVEREIGN_SPORE_CAST_TEXTURE
		&"rotating_cast":
			desired_texture = MAW_SOVEREIGN_ROTATING_CAST_TEXTURE
		&"aimed_cast":
			desired_texture = MAW_SOVEREIGN_AIMED_CAST_TEXTURE
	if maw_sovereign_visual_phase != boss_phase or visual.texture != desired_texture:
		maw_sovereign_visual_phase = boss_phase
		visual.texture = desired_texture
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	var frame_rate := 8.0 if maw_sovereign_action != &"idle" else 3.0
	maw_sovereign_frame_clock = fmod(maw_sovereign_frame_clock + delta * frame_rate, 4.0)
	visual.frame = int(maw_sovereign_frame_clock)


func _update_possessed_banyan_animation(delta: float) -> void:
	if enemy_type != "banyan_boss":
		return
	var desired_texture: Texture2D = POSSESSED_BANYAN_EXPOSED_TEXTURE if boss_phase >= 2 else POSSESSED_BANYAN_ARMORED_TEXTURE
	if possessed_banyan_action == &"seed_column_cast":
		desired_texture = POSSESSED_BANYAN_SEED_COLUMN_CAST_TEXTURE
	elif possessed_banyan_action == &"diagonal_cast":
		desired_texture = POSSESSED_BANYAN_DIAGONAL_CAST_TEXTURE
	if possessed_banyan_visual_phase != boss_phase or visual.texture != desired_texture:
		possessed_banyan_visual_phase = boss_phase
		visual.texture = desired_texture
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	var frame_rate := 8.0 if possessed_banyan_action != &"idle" else 3.0
	possessed_banyan_frame_clock = fmod(possessed_banyan_frame_clock + delta * frame_rate, 4.0)
	visual.frame = int(possessed_banyan_frame_clock)


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
	if enemy_type == "root_core_eye_boss":
		_update_root_core_eye_animation(0.0)
	if enemy_type == "thorn_matriarch_boss":
		_update_thorn_matriarch_animation(0.0)
	if enemy_type == "maw_sovereign_boss":
		_update_maw_sovereign_animation(0.0)
	if enemy_type == "banyan_boss":
		_update_possessed_banyan_animation(0.0)
	if enemy_type == "root_hydra_boss":
		_update_root_hydra_animation(0.0)


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


func _on_pattern_telegraph_started(pattern_id: String) -> void:
	pattern_attack_locked = true
	velocity.x = 0.0
	if enemy_type == "thorn_matriarch_boss":
		thorn_matriarch_action = &"fan_cast" if pattern_id == "thorn_fan_three_way" else &"mine_cast"
	if enemy_type == "maw_sovereign_boss":
		match pattern_id:
			"maw_spore_rain":
				maw_sovereign_action = &"spore_cast"
			"maw_rotating_five_way":
				maw_sovereign_action = &"rotating_cast"
			_:
				maw_sovereign_action = &"aimed_cast"
	if enemy_type == "banyan_boss":
		possessed_banyan_action = &"seed_column_cast" if pattern_id == "banyan_seed_columns" else &"diagonal_cast"
	visual.modulate = Color(1.35, 1.1, 0.72, 1.0)


func _on_pattern_started(_pattern_id: String) -> void:
	pattern_attack_locked = true
	visual.modulate = base_visual_modulate


func _on_pattern_recovery_started(_pattern_id: String) -> void:
	pattern_attack_locked = false
	if enemy_type == "thorn_matriarch_boss":
		thorn_matriarch_action = &"idle"
	if enemy_type == "maw_sovereign_boss":
		maw_sovereign_action = &"idle"
	if enemy_type == "banyan_boss":
		possessed_banyan_action = &"idle"
	visual.modulate = base_visual_modulate.darkened(0.18)
