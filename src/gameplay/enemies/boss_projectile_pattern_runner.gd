class_name BossProjectilePatternRunner
extends Node

signal telegraph_started(pattern_id: String)
signal pattern_started(pattern_id: String)
signal recovery_started(pattern_id: String)
signal phase_changed(current_phase: int, phase_count: int)

const PROJECTILE_SCENE := preload("res://scenes/gameplay/enemy_projectile.tscn")
const ROOT_CORE_EYE_LONGAN_PROJECTILE_TEXTURE_PATH := "res://assets/enemies/bosses/root_core_eye/root_core_eye_longan_seed_bullet_normalized_v2.png"
const THORN_HAIR_PROJECTILE_TEXTURE_PATH := "res://assets/enemies/bosses/thorn_matriarch/projectiles/hair_thorn_spin_strip_normalized_v2.png"
const THORN_LANE_PROJECTILE_TEXTURE_PATH := "res://assets/enemies/bosses/thorn_matriarch/projectiles/lane_thorn_emerge_strip_normalized_v2.png"
const MAW_SPORE_PROJECTILE_TEXTURE_PATH := "res://assets/enemies/bosses/maw_sovereign/projectiles/spore_pod_fall_strip_normalized_v2.png"
const MAW_SEED_PROJECTILE_TEXTURE_PATH := "res://assets/enemies/bosses/maw_sovereign/projectiles/seed_bullet_spin_strip_normalized_v2.png"
const BANYAN_SEED_PROJECTILE_TEXTURE_PATH := "res://assets/enemies/bosses/possessed_banyan/projectiles/jackfruit_seed_fall_strip_normalized_v2.png"
const BANYAN_ROOT_PROJECTILE_TEXTURE_PATH := "res://assets/enemies/bosses/possessed_banyan/projectiles/diagonal_root_line_strip_normalized_v2.png"
const HYDRA_WEDGE_PROJECTILE_TEXTURE_PATH := "res://assets/enemies/bosses/root_hydra/projectiles/root_hydra_nipa_wedge_bolt_normalized_v2.png"
const HYDRA_NUTRIENT_PROJECTILE_TEXTURE_PATH := "res://assets/enemies/bosses/root_hydra/projectiles/root_hydra_nutrient_ring_orb_normalized_v2.png"
const HYDRA_WATER_PROJECTILE_TEXTURE_PATH := "res://assets/enemies/bosses/root_hydra/projectiles/root_hydra_water_lane_eruption_normalized_v2.png"
const EYE_SPIRAL_PROJECTILE_TEXTURE_PATH := "res://assets/enemies/bosses/root_core_eye/projectiles/root_core_eye_spiral_seed_eye_orb_normalized_v2.png"
const EYE_PUPIL_PROJECTILE_TEXTURE_PATH := "res://assets/enemies/bosses/root_core_eye/projectiles/root_core_eye_pupil_lance_dart_normalized_v2.png"
const EYE_BRACT_PROJECTILE_TEXTURE_PATH := "res://assets/enemies/bosses/root_core_eye/projectiles/root_core_eye_bract_curtain_blade_normalized_v2.png"
const STATE_IDLE := &"idle"
const STATE_TELEGRAPH := &"telegraph"
const STATE_ACTIVE := &"active"
const STATE_RECOVERY := &"recovery"

var host: Node2D
var target: Node2D
var pattern_set_id: String = ""
var pattern_set: Dictionary = {}
var all_patterns: Array = []
var patterns: Array = []
var current_phase: int = 1
var phase_count: int = 1
var projectile_cap: int = 0
var projectile_damage: int = 1
var active: bool = false
var state: StringName = STATE_IDLE
var state_timer: float = 0.0
var emission_timer: float = 0.0
var pattern_index: int = -1
var emitted_count: int = 0
var current_pattern: Dictionary = {}
var active_projectiles: Array[EnemyProjectile] = []
var projectile_pool: Array[EnemyProjectile] = []
var all_projectiles: Array[EnemyProjectile] = []


func _load_projectile_texture(path: String) -> Texture2D:
	return GameManager.load_runtime_texture(path)


func configure(host_node: Node2D, configured_set_id: String, configured_damage: int) -> void:
	host = host_node
	pattern_set_id = configured_set_id
	pattern_set = BossPatternCatalog.get_pattern_set(pattern_set_id)
	all_patterns = pattern_set.get("patterns", [])
	phase_count = maxi(BossPatternCatalog.get_phase_count(pattern_set_id), 1)
	current_phase = 1
	_refresh_phase_patterns()
	projectile_cap = int(pattern_set.get("max_projectiles", 0))
	projectile_damage = maxi(configured_damage, 1)
	if pattern_set.is_empty():
		push_error("Boss projectile runner received an unknown pattern set: %s" % pattern_set_id)


func set_phase(next_phase: int) -> bool:
	var resolved_phase := clampi(next_phase, 1, phase_count)
	if resolved_phase == current_phase:
		return false
	current_phase = resolved_phase
	pattern_index = -1
	current_pattern = {}
	_refresh_phase_patterns()
	cleanup_projectiles()
	AudioManager.play_named_sfx(&"boss_phase", 1.0, -10.0)
	phase_changed.emit(current_phase, phase_count)
	if active:
		_begin_next_pattern()
	return true


func _refresh_phase_patterns() -> void:
	patterns.clear()
	for pattern: Dictionary in all_patterns:
		if int(pattern.get("phase", 1)) == current_phase:
			patterns.append(pattern)


func set_active(enabled: bool) -> void:
	if active == enabled:
		return
	active = enabled
	set_process(active)
	if active:
		target = get_tree().get_first_node_in_group("Player") as Node2D
		_begin_next_pattern()
	else:
		state = STATE_IDLE
		state_timer = 0.0
		cleanup_projectiles()


func _process(delta: float) -> void:
	if not active or not is_instance_valid(host):
		return
	if not is_instance_valid(target):
		target = get_tree().get_first_node_in_group("Player") as Node2D
	state_timer -= delta
	match state:
		STATE_TELEGRAPH:
			if state_timer <= 0.0:
				_begin_active_pattern()
		STATE_ACTIVE:
			emission_timer -= delta
			while emission_timer <= 0.0 and emitted_count < int(current_pattern.get("projectile_count", 0)):
				_emit_projectile(emitted_count)
				emitted_count += 1
				emission_timer += _emission_interval()
			if state_timer <= 0.0:
				_begin_recovery()
		STATE_RECOVERY:
			if state_timer <= 0.0:
				_begin_next_pattern()


func _begin_next_pattern() -> void:
	if patterns.is_empty():
		state = STATE_IDLE
		return
	cleanup_projectiles()
	pattern_index = (pattern_index + 1) % patterns.size()
	current_pattern = patterns[pattern_index]
	emitted_count = 0
	state = STATE_TELEGRAPH
	state_timer = float(current_pattern.get("telegraph_duration", 0.65))
	AudioManager.play_named_sfx(&"boss_telegraph", 1.0, -13.0)
	telegraph_started.emit(str(current_pattern.get("pattern_id", "")))


func _begin_active_pattern() -> void:
	state = STATE_ACTIVE
	state_timer = float(current_pattern.get("active_duration", 3.0))
	emission_timer = 0.0
	pattern_started.emit(str(current_pattern.get("pattern_id", "")))


func _begin_recovery() -> void:
	cleanup_projectiles()
	state = STATE_RECOVERY
	state_timer = float(current_pattern.get("recovery_duration", 0.75))
	recovery_started.emit(str(current_pattern.get("pattern_id", "")))


func _emission_interval() -> float:
	var count := maxi(int(current_pattern.get("projectile_count", 1)), 1)
	return float(current_pattern.get("active_duration", 3.0)) / count


func _emit_projectile(sequence_index: int) -> void:
	if not is_instance_valid(target) or active_projectiles.size() >= projectile_cap:
		return
	var projectile := _acquire_projectile()
	if projectile == null:
		return
	var origin := host.global_position + Vector2(0.0, -18.0)
	var aim := (target.global_position - origin).normalized()
	var formation := str(current_pattern.get("formation", "aimed_burst"))
	var direction := aim
	match formation:
		"fan":
			var fan_step := sequence_index % 3
			direction = aim.rotated(lerpf(-0.34, 0.34, fan_step / 2.0))
		"lane_wall":
			var lane := sequence_index % 4
			origin.y = target.global_position.y - 108.0 + lane * 72.0
			direction = Vector2(signf(target.global_position.x - host.global_position.x), 0.0)
		"arc_rain", "vertical_columns":
			origin = Vector2(target.global_position.x - 192.0 + (sequence_index % 7) * 64.0, target.global_position.y - 310.0)
			direction = Vector2(0.08 * float((sequence_index % 3) - 1), 1.0).normalized()
		"rotating_fan", "spiral":
			direction = Vector2.RIGHT.rotated(sequence_index * TAU / 10.0)
		"diagonal_lines", "crossfire":
			var side := -1.0 if sequence_index % 2 == 0 else 1.0
			origin = target.global_position + Vector2(side * 260.0, -240.0)
			direction = Vector2(-side, 0.82).normalized()
		"radial_rings", "aimed_rings":
			direction = Vector2.RIGHT.rotated(sequence_index * TAU / 12.0)
		"bullet_curtain":
			origin = Vector2(target.global_position.x - 224.0 + (sequence_index % 8) * 64.0, target.global_position.y - 300.0)
			direction = Vector2.DOWN
		_:
			direction = aim.rotated(lerpf(-0.18, 0.18, float(sequence_index % 3) / 2.0))
	var presentation := _get_projectile_presentation(str(current_pattern.get("pattern_id", "")))
	var projectile_texture: Texture2D = presentation.get("texture", null) as Texture2D
	var visual_frame_count := int(presentation.get("frame_count", 1))
	var visual_scale := float(presentation.get("scale", 0.014))
	if projectile_texture == null and host is EnemyController and host.enemy_type == "root_core_eye_boss":
		projectile_texture = _load_projectile_texture(ROOT_CORE_EYE_LONGAN_PROJECTILE_TEXTURE_PATH)
		visual_frame_count = 4
		visual_scale = 0.027
	projectile.activate(
		origin,
		direction,
		float(current_pattern.get("projectile_speed", 220.0)),
		projectile_damage,
		float(current_pattern.get("projectile_lifetime", 4.0)),
		projectile_texture,
		visual_frame_count,
		visual_scale
	)
	AudioManager.play_named_sfx(&"boss_projectile", 1.0, -18.0)
	projectile.add_to_group("BossProjectile")
	active_projectiles.append(projectile)


func _get_projectile_presentation(pattern_id: String) -> Dictionary:
	var visual_id := str(current_pattern.get("projectile_visual_id", ""))
	var visual_scale := float(current_pattern.get("projectile_visual_scale", 0.014))
	var texture: Texture2D = null
	match visual_id:
		"thorn_hair_spin":
			texture = _load_projectile_texture(THORN_HAIR_PROJECTILE_TEXTURE_PATH)
		"thorn_lane_emerge":
			texture = _load_projectile_texture(THORN_LANE_PROJECTILE_TEXTURE_PATH)
		"maw_spore_pod":
			texture = _load_projectile_texture(MAW_SPORE_PROJECTILE_TEXTURE_PATH)
		"maw_seed_spin":
			texture = _load_projectile_texture(MAW_SEED_PROJECTILE_TEXTURE_PATH)
		"banyan_seed_fall":
			texture = _load_projectile_texture(BANYAN_SEED_PROJECTILE_TEXTURE_PATH)
		"banyan_diagonal_root":
			texture = _load_projectile_texture(BANYAN_ROOT_PROJECTILE_TEXTURE_PATH)
		"hydra_wedge_bolt":
			texture = _load_projectile_texture(HYDRA_WEDGE_PROJECTILE_TEXTURE_PATH)
		"hydra_nutrient_orb":
			texture = _load_projectile_texture(HYDRA_NUTRIENT_PROJECTILE_TEXTURE_PATH)
		"hydra_water_eruption":
			texture = _load_projectile_texture(HYDRA_WATER_PROJECTILE_TEXTURE_PATH)
		"eye_spiral_orb":
			texture = _load_projectile_texture(EYE_SPIRAL_PROJECTILE_TEXTURE_PATH)
		"eye_pupil_dart":
			texture = _load_projectile_texture(EYE_PUPIL_PROJECTILE_TEXTURE_PATH)
		"eye_bract_blade":
			texture = _load_projectile_texture(EYE_BRACT_PROJECTILE_TEXTURE_PATH)
	return {"texture": texture, "frame_count": 4 if texture != null else 1, "scale": visual_scale}


func _acquire_projectile() -> EnemyProjectile:
	_prune_projectile_arrays()
	var projectile: EnemyProjectile
	if not projectile_pool.is_empty():
		projectile = projectile_pool.pop_back()
	else:
		projectile = PROJECTILE_SCENE.instantiate() as EnemyProjectile
		projectile.recyclable = true
		projectile.retired.connect(_on_projectile_retired)
		get_tree().current_scene.add_child(projectile)
		all_projectiles.append(projectile)
	return projectile


func _on_projectile_retired(projectile: EnemyProjectile) -> void:
	active_projectiles.erase(projectile)
	projectile.remove_from_group("BossProjectile")
	if is_instance_valid(projectile) and projectile not in projectile_pool:
		projectile_pool.append(projectile)


func cleanup_projectiles() -> void:
	for projectile: EnemyProjectile in active_projectiles.duplicate():
		if is_instance_valid(projectile):
			projectile.retire_now()
	active_projectiles.clear()


func dispose_projectiles() -> void:
	active = false
	state = STATE_IDLE
	for projectile: EnemyProjectile in all_projectiles:
		if is_instance_valid(projectile):
			projectile.queue_free()
	active_projectiles.clear()
	projectile_pool.clear()
	all_projectiles.clear()


func get_active_projectile_count() -> int:
	_prune_projectile_arrays()
	return active_projectiles.size()


func _prune_projectile_arrays() -> void:
	active_projectiles = active_projectiles.filter(func(projectile: EnemyProjectile) -> bool: return is_instance_valid(projectile))
	projectile_pool = projectile_pool.filter(func(projectile: EnemyProjectile) -> bool: return is_instance_valid(projectile))
	all_projectiles = all_projectiles.filter(func(projectile: EnemyProjectile) -> bool: return is_instance_valid(projectile))
