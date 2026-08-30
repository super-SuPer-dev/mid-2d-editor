class_name BossPatternCatalog
extends RefCounted

## Data contract for platformer-readable projectile phases. Runtime pattern
## emitters consume these records; exact angles and spawn positions remain
## encounter data so patterns can be tuned without changing their safety rules.
const REQUIRED_CLEANUP_EVENTS := ["phase_change", "boss_defeat", "player_retry", "scene_exit"]
const MIN_SAFE_LANE_WIDTH := 56.0

static var PATTERN_SETS: Dictionary = {
	"thorn_matriarch_tutorial": {
		"max_projectiles": 18,
		"patterns": [
			_pattern("thorn_fan_three_way", 1, "fan", 3, 3.0, 1.0, 220.0, 76.0),
			_pattern("thorn_alternating_lanes", 2, "lane_wall", 8, 3.5, 1.1, 180.0, 88.0),
		],
	},
	"maw_sovereign_spore": {
		"max_projectiles": 32,
		"patterns": [
			_pattern("maw_spore_rain", 1, "arc_rain", 12, 4.0, 0.9, 190.0, 64.0),
			_pattern("maw_rotating_five_way", 2, "rotating_fan", 20, 4.5, 1.0, 210.0, 64.0),
			_pattern("maw_aimed_seed_burst", 3, "aimed_burst", 9, 3.0, 0.9, 250.0, 72.0),
		],
	},
	"possessed_banyan_control": {
		"max_projectiles": 36,
		"patterns": [
			_pattern("banyan_seed_columns", 1, "vertical_columns", 16, 4.0, 1.0, 210.0, 64.0),
			_pattern("banyan_diagonal_roots", 2, "diagonal_lines", 18, 4.5, 1.0, 200.0, 64.0),
		],
	},
	"root_hydra_crossfire": {
		"max_projectiles": 48,
		"patterns": [
			_pattern("hydra_head_crossfire", 1, "crossfire", 24, 4.5, 0.9, 230.0, 64.0),
			_pattern("hydra_offset_rings", 2, "radial_rings", 32, 5.0, 1.0, 190.0, 64.0),
			_pattern("hydra_water_lane_walls", 3, "lane_wall", 28, 4.0, 1.1, 210.0, 72.0),
		],
	},
	"root_core_eye_final": {
		"max_projectiles": 64,
		"patterns": [
			_pattern("eye_rotating_spirals", 1, "spiral", 48, 5.0, 0.8, 210.0, 64.0),
			_pattern("eye_aimed_rings", 2, "aimed_rings", 36, 4.0, 0.9, 240.0, 64.0),
			_pattern("eye_alternating_curtains", 3, "bullet_curtain", 56, 5.5, 1.0, 220.0, 72.0),
		],
	},
}


static func _pattern(
	pattern_id: String,
	phase: int,
	formation: String,
	projectile_count: int,
	active_duration: float,
	recovery_duration: float,
	projectile_speed: float,
	safe_lane_width: float
) -> Dictionary:
	return {
		"pattern_id": pattern_id,
		"phase": phase,
		"formation": formation,
		"telegraph_duration": 0.65,
		"active_duration": active_duration,
		"recovery_duration": recovery_duration,
		"projectile_count": projectile_count,
		"projectile_speed": projectile_speed,
		"projectile_lifetime": 4.0,
		"safe_lane_width": safe_lane_width,
		"cleanup_events": REQUIRED_CLEANUP_EVENTS,
	}


static func get_pattern_set(set_id: String) -> Dictionary:
	return PATTERN_SETS.get(set_id, {}).duplicate(true)


static func get_phase_count(set_id: String) -> int:
	var phase_count := 0
	for pattern: Dictionary in get_pattern_set(set_id).get("patterns", []):
		phase_count = maxi(phase_count, int(pattern.get("phase", 0)))
	return phase_count


static func validate_pattern_set(set_id: String) -> Array[String]:
	var errors: Array[String] = []
	var pattern_set := get_pattern_set(set_id)
	if pattern_set.is_empty():
		errors.append("Unknown boss pattern set: %s" % set_id)
		return errors
	var cap := int(pattern_set.get("max_projectiles", 0))
	if cap <= 0:
		errors.append("%s has an invalid projectile cap." % set_id)
	var pattern_ids: Dictionary = {}
	var phase_ids: Dictionary = {}
	var patterns: Array = pattern_set.get("patterns", [])
	if patterns.is_empty():
		errors.append("%s has no patterns." % set_id)
	for pattern: Dictionary in patterns:
		var phase := int(pattern.get("phase", 0))
		if phase <= 0:
			errors.append("%s has a pattern without a valid phase." % set_id)
		else:
			phase_ids[phase] = true
		var pattern_id := str(pattern.get("pattern_id", ""))
		if pattern_id.is_empty() or pattern_ids.has(pattern_id):
			errors.append("%s has a missing or duplicate pattern ID: %s" % [set_id, pattern_id])
		pattern_ids[pattern_id] = true
		if float(pattern.get("telegraph_duration", 0.0)) <= 0.0:
			errors.append("%s/%s has no telegraph." % [set_id, pattern_id])
		var active_duration := float(pattern.get("active_duration", 0.0))
		if active_duration < 3.0 or active_duration > 6.0:
			errors.append("%s/%s active duration is outside 3–6 seconds." % [set_id, pattern_id])
		if float(pattern.get("recovery_duration", 0.0)) < 0.75:
			errors.append("%s/%s recovery is shorter than 0.75 seconds." % [set_id, pattern_id])
		if int(pattern.get("projectile_count", 0)) <= 0 or int(pattern.get("projectile_count", 0)) > cap:
			errors.append("%s/%s violates its projectile cap." % [set_id, pattern_id])
		if float(pattern.get("projectile_speed", 0.0)) <= 0.0 or float(pattern.get("projectile_lifetime", 0.0)) <= 0.0:
			errors.append("%s/%s has invalid projectile motion." % [set_id, pattern_id])
		if float(pattern.get("safe_lane_width", 0.0)) < MIN_SAFE_LANE_WIDTH:
			errors.append("%s/%s has an undersized safe lane." % [set_id, pattern_id])
		for cleanup_event: String in REQUIRED_CLEANUP_EVENTS:
			if cleanup_event not in pattern.get("cleanup_events", []):
				errors.append("%s/%s does not clean up on %s." % [set_id, pattern_id, cleanup_event])
	for phase in range(1, get_phase_count(set_id) + 1):
		if not phase_ids.has(phase):
			errors.append("%s is missing contiguous phase %d." % [set_id, phase])
	return errors
