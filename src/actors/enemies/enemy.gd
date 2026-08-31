class_name EnemyController
extends CharacterBody2D

signal defeated_event(enemy: EnemyController)
signal boss_phase_changed(current_phase: int, phase_count: int)

const GRAVITY := 1200.0
const PROJECTILE_SCENE := preload("res://scenes/gameplay/enemy_projectile.tscn")
var ORGANIC_HIT_VFX_TEXTURE: Texture2D
const ORGANIC_HIT_VFX_TEXTURE_PATH := "res://assets/vfx/damage/damage_organic_hit_normalized_v1.png"
var ARMORED_HIT_VFX_TEXTURE: Texture2D
const ARMORED_HIT_VFX_TEXTURE_PATH := "res://assets/vfx/damage/damage_armored_hit_normalized_v1.png"
var BOSS_CORE_HIT_VFX_TEXTURE: Texture2D
const BOSS_CORE_HIT_VFX_TEXTURE_PATH := "res://assets/vfx/damage/damage_boss_core_hit_normalized_v1.png"
var THORNLING_TEXTURE: Texture2D
const THORNLING_TEXTURE_PATH := "res://assets/enemies/standard/thornling.png"
var THORNLING_IDLE_TEXTURE: Texture2D
const THORNLING_IDLE_TEXTURE_PATH := "res://assets/enemies/standard/thornling/thornling_idle_strip_normalized_v2.png"
var THORNLING_RUN_TEXTURE: Texture2D
const THORNLING_RUN_TEXTURE_PATH := "res://assets/enemies/standard/thornling/thornling_run_strip_normalized_v2.png"
var THORNLING_ATTACK_TEXTURE: Texture2D
const THORNLING_ATTACK_TEXTURE_PATH := "res://assets/enemies/standard/thornling/thornling_attack_strip_normalized_v2.png"
var THORNLING_ATTACK_TELL_TEXTURE: Texture2D
const THORNLING_ATTACK_TELL_TEXTURE_PATH := "res://assets/enemies/standard/thornling/thornling_attack_tell_strip_normalized_v2.png"
var THORNLING_HURT_TEXTURE: Texture2D
const THORNLING_HURT_TEXTURE_PATH := "res://assets/enemies/standard/thornling/thornling_hurt_strip_normalized_v2.png"
var THORNLING_DEATH_TEXTURE: Texture2D
const THORNLING_DEATH_TEXTURE_PATH := "res://assets/enemies/standard/thornling/thornling_death_strip_normalized_v2.png"
var THORNLING_CONTACT_HIT_TEXTURE: Texture2D
const THORNLING_CONTACT_HIT_TEXTURE_PATH := "res://assets/vfx/damage/thornling_contact_hit_normalized_v2.png"
var SPITTER_TEXTURE: Texture2D
const SPITTER_TEXTURE_PATH := "res://assets/enemies/standard/spitter.png"
var SPITTER_IDLE_TEXTURE: Texture2D
const SPITTER_IDLE_TEXTURE_PATH := "res://assets/enemies/standard/spitter/spitter_idle_strip_normalized_v2.png"
var SPITTER_WALK_TEXTURE: Texture2D
const SPITTER_WALK_TEXTURE_PATH := "res://assets/enemies/standard/spitter/spitter_walk_strip_normalized_v2.png"
var SPITTER_SEED_BURST_TEXTURE: Texture2D
const SPITTER_SEED_BURST_TEXTURE_PATH := "res://assets/enemies/standard/spitter/spitter_seed_burst_strip_normalized_v2.png"
var SPITTER_PRESSURE_TELL_TEXTURE: Texture2D
const SPITTER_PRESSURE_TELL_TEXTURE_PATH := "res://assets/enemies/standard/spitter/spitter_pressure_tell_strip_normalized_v2.png"
var SPITTER_JUICE_LOB_TEXTURE: Texture2D
const SPITTER_JUICE_LOB_TEXTURE_PATH := "res://assets/enemies/standard/spitter/spitter_juice_lob_strip_normalized_v2.png"
var SPITTER_HURT_TEXTURE: Texture2D
const SPITTER_HURT_TEXTURE_PATH := "res://assets/enemies/standard/spitter/spitter_hurt_strip_normalized_v2.png"
var SPITTER_DEATH_TEXTURE: Texture2D
const SPITTER_DEATH_TEXTURE_PATH := "res://assets/enemies/standard/spitter/spitter_death_strip_normalized_v2.png"
var MAW_IDLE_TEXTURE: Texture2D
const MAW_IDLE_TEXTURE_PATH := "res://assets/enemies/standard/maw/maw_idle_strip_normalized_v2.png"
var MAW_MOVE_TEXTURE: Texture2D
const MAW_MOVE_TEXTURE_PATH := "res://assets/enemies/standard/maw/maw_move_strip_normalized_v2.png"
var MAW_ANTICIPATION_TEXTURE: Texture2D
const MAW_ANTICIPATION_TEXTURE_PATH := "res://assets/enemies/standard/maw/maw_anticipation_strip_normalized_v2.png"
var MAW_ATTACK_TEXTURE: Texture2D
const MAW_ATTACK_TEXTURE_PATH := "res://assets/enemies/standard/maw/maw_attack_strip_normalized_v2.png"
var MAW_HURT_TEXTURE: Texture2D
const MAW_HURT_TEXTURE_PATH := "res://assets/enemies/standard/maw/maw_hurt_strip_normalized_v2.png"
var MAW_DEATH_TEXTURE: Texture2D
const MAW_DEATH_TEXTURE_PATH := "res://assets/enemies/standard/maw/maw_death_strip_normalized_v2.png"
var CAPSULE_HUSK_IDLE_TEXTURE: Texture2D
const CAPSULE_HUSK_IDLE_TEXTURE_PATH := "res://assets/enemies/standard/capsule_husk/capsule_husk_idle_strip_normalized_v2.png"
var CAPSULE_HUSK_MOVE_TEXTURE: Texture2D
const CAPSULE_HUSK_MOVE_TEXTURE_PATH := "res://assets/enemies/standard/capsule_husk/capsule_husk_move_strip_normalized_v2.png"
var CAPSULE_HUSK_CHARGE_TELL_TEXTURE: Texture2D
const CAPSULE_HUSK_CHARGE_TELL_TEXTURE_PATH := "res://assets/enemies/standard/capsule_husk/capsule_husk_charge_tell_strip_normalized_v2.png"
var CAPSULE_HUSK_CHARGE_TEXTURE: Texture2D
const CAPSULE_HUSK_CHARGE_TEXTURE_PATH := "res://assets/enemies/standard/capsule_husk/capsule_husk_charge_strip_normalized_v2.png"
var CAPSULE_HUSK_CORE_ATTACK_TEXTURE: Texture2D
const CAPSULE_HUSK_CORE_ATTACK_TEXTURE_PATH := "res://assets/enemies/standard/capsule_husk/capsule_husk_core_attack_strip_normalized_v2.png"
var CAPSULE_HUSK_HURT_TEXTURE: Texture2D
const CAPSULE_HUSK_HURT_TEXTURE_PATH := "res://assets/enemies/standard/capsule_husk/capsule_husk_hurt_strip_normalized_v2.png"
var CAPSULE_HUSK_DEATH_TEXTURE: Texture2D
const CAPSULE_HUSK_DEATH_TEXTURE_PATH := "res://assets/enemies/standard/capsule_husk/capsule_husk_death_strip_normalized_v2.png"
var THORN_MATRIARCH_TEXTURE: Texture2D
const THORN_MATRIARCH_TEXTURE_PATH := "res://assets/enemies/bosses/thorn_matriarch.png"
var ROOT_SKITTER_IDLE_TEXTURE: Texture2D
const ROOT_SKITTER_IDLE_TEXTURE_PATH := "res://assets/enemies/standard/root_skitter/root_skitter_idle_strip_normalized_v2.png"
var ROOT_SKITTER_SCUTTLE_TEXTURE: Texture2D
const ROOT_SKITTER_SCUTTLE_TEXTURE_PATH := "res://assets/enemies/standard/root_skitter/root_skitter_scuttle_strip_normalized_v2.png"
var ROOT_SKITTER_BURROW_TELL_TEXTURE: Texture2D
const ROOT_SKITTER_BURROW_TELL_TEXTURE_PATH := "res://assets/enemies/standard/root_skitter/root_skitter_burrow_tell_strip_normalized_v2.png"
var ROOT_SKITTER_BURROW_TEXTURE: Texture2D
const ROOT_SKITTER_BURROW_TEXTURE_PATH := "res://assets/enemies/standard/root_skitter/root_skitter_burrow_strip_normalized_v2.png"
var ROOT_SKITTER_EMERGE_ATTACK_TEXTURE: Texture2D
const ROOT_SKITTER_EMERGE_ATTACK_TEXTURE_PATH := "res://assets/enemies/standard/root_skitter/root_skitter_emerge_attack_strip_normalized_v2.png"
var ROOT_SKITTER_HURT_TEXTURE: Texture2D
const ROOT_SKITTER_HURT_TEXTURE_PATH := "res://assets/enemies/standard/root_skitter/root_skitter_hurt_strip_normalized_v2.png"
var ROOT_SKITTER_DEATH_TEXTURE: Texture2D
const ROOT_SKITTER_DEATH_TEXTURE_PATH := "res://assets/enemies/standard/root_skitter/root_skitter_death_strip_normalized_v2.png"
var ROOT_HYDRA_IDLE_TEXTURE: Texture2D
const ROOT_HYDRA_IDLE_TEXTURE_PATH := "res://assets/enemies/bosses/root_hydra/root_hydra_idle_strip_normalized_v2.png"
var ROOT_HYDRA_EXPOSED_TEXTURE: Texture2D
const ROOT_HYDRA_EXPOSED_TEXTURE_PATH := "res://assets/enemies/bosses/root_hydra/root_hydra_idle_exposed_strip_normalized_v2.png"
var ROOT_HYDRA_CROSSFIRE_CAST_TEXTURE: Texture2D
const ROOT_HYDRA_CROSSFIRE_CAST_TEXTURE_PATH := "res://assets/enemies/bosses/root_hydra/root_hydra_crossfire_cast_strip_normalized_v2.png"
var ROOT_HYDRA_RADIAL_RING_CAST_TEXTURE: Texture2D
const ROOT_HYDRA_RADIAL_RING_CAST_TEXTURE_PATH := "res://assets/enemies/bosses/root_hydra/root_hydra_radial_ring_cast_strip_normalized_v2.png"
var ROOT_HYDRA_LANE_WALL_CAST_TEXTURE: Texture2D
const ROOT_HYDRA_LANE_WALL_CAST_TEXTURE_PATH := "res://assets/enemies/bosses/root_hydra/root_hydra_lane_wall_cast_strip_normalized_v2.png"
var ROOT_HYDRA_DEATH_TEXTURE: Texture2D
const ROOT_HYDRA_DEATH_TEXTURE_PATH := "res://assets/enemies/bosses/root_hydra/root_hydra_death_strip_normalized_v2.png"
var ROOT_HYDRA_HURT_TEXTURE: Texture2D
const ROOT_HYDRA_HURT_TEXTURE_PATH := "res://assets/enemies/bosses/root_hydra/root_hydra_hurt_strip_normalized_v2.png"
var EYE_WISP_HOVER_TEXTURE: Texture2D
const EYE_WISP_HOVER_TEXTURE_PATH := "res://assets/enemies/standard/eye_wisp/eye_wisp_hover_strip_normalized_v2.png"
var EYE_WISP_FLY_TEXTURE: Texture2D
const EYE_WISP_FLY_TEXTURE_PATH := "res://assets/enemies/standard/eye_wisp/eye_wisp_fly_strip_normalized_v2.png"
var EYE_WISP_AIM_TELL_TEXTURE: Texture2D
const EYE_WISP_AIM_TELL_TEXTURE_PATH := "res://assets/enemies/standard/eye_wisp/eye_wisp_aim_tell_strip_normalized_v2.png"
var EYE_WISP_SEED_BOLT_TEXTURE: Texture2D
const EYE_WISP_SEED_BOLT_TEXTURE_PATH := "res://assets/enemies/standard/eye_wisp/eye_wisp_seed_bolt_strip_normalized_v2.png"
var EYE_WISP_BEAM_ATTACK_TEXTURE: Texture2D
const EYE_WISP_BEAM_ATTACK_TEXTURE_PATH := "res://assets/enemies/standard/eye_wisp/eye_wisp_beam_attack_strip_normalized_v2.png"
var EYE_WISP_HURT_TEXTURE: Texture2D
const EYE_WISP_HURT_TEXTURE_PATH := "res://assets/enemies/standard/eye_wisp/eye_wisp_hurt_strip_normalized_v2.png"
var EYE_WISP_DEATH_TEXTURE: Texture2D
const EYE_WISP_DEATH_TEXTURE_PATH := "res://assets/enemies/standard/eye_wisp/eye_wisp_death_strip_normalized_v2.png"
var ROOT_CORE_EYE_SEALED_TEXTURE: Texture2D
const ROOT_CORE_EYE_SEALED_TEXTURE_PATH := "res://assets/enemies/bosses/root_core_eye/root_core_eye_idle_sealed_normalized_v2.png"
var ROOT_CORE_EYE_EXPOSED_TEXTURE: Texture2D
const ROOT_CORE_EYE_EXPOSED_TEXTURE_PATH := "res://assets/enemies/bosses/root_core_eye/root_core_eye_idle_exposed_normalized_v2.png"
var ROOT_CORE_EYE_SPIRAL_CAST_TEXTURE: Texture2D
const ROOT_CORE_EYE_SPIRAL_CAST_TEXTURE_PATH := "res://assets/enemies/bosses/root_core_eye/root_core_eye_spiral_cast_strip_normalized_v2.png"
var ROOT_CORE_EYE_AIMED_CAST_TEXTURE: Texture2D
const ROOT_CORE_EYE_AIMED_CAST_TEXTURE_PATH := "res://assets/enemies/bosses/root_core_eye/root_core_eye_aimed_seed_cast_strip_normalized_v2.png"
var ROOT_CORE_EYE_CURTAIN_CAST_TEXTURE: Texture2D
const ROOT_CORE_EYE_CURTAIN_CAST_TEXTURE_PATH := "res://assets/enemies/bosses/root_core_eye/root_core_eye_bract_curtain_cast_strip_normalized_v2.png"
var ROOT_CORE_EYE_DEATH_TEXTURE: Texture2D
const ROOT_CORE_EYE_DEATH_TEXTURE_PATH := "res://assets/enemies/bosses/root_core_eye/root_core_eye_death_strip_normalized_v2.png"
var ROOT_CORE_EYE_HURT_TEXTURE: Texture2D
const ROOT_CORE_EYE_HURT_TEXTURE_PATH := "res://assets/enemies/bosses/root_core_eye/root_core_eye_hurt_strip_normalized_v2.png"
var THORN_MATRIARCH_ARMORED_TEXTURE: Texture2D
const THORN_MATRIARCH_ARMORED_TEXTURE_PATH := "res://assets/enemies/bosses/thorn_matriarch/thorn_matriarch_idle_armored_strip_normalized_v2.png"
var THORN_MATRIARCH_EXPOSED_TEXTURE: Texture2D
const THORN_MATRIARCH_EXPOSED_TEXTURE_PATH := "res://assets/enemies/bosses/thorn_matriarch/thorn_matriarch_idle_exposed_strip_normalized_v2.png"
var THORN_MATRIARCH_DEATH_TEXTURE: Texture2D
const THORN_MATRIARCH_DEATH_TEXTURE_PATH := "res://assets/enemies/bosses/thorn_matriarch/thorn_matriarch_death_strip_normalized_v2.png"
var THORN_MATRIARCH_FAN_CAST_TEXTURE: Texture2D
const THORN_MATRIARCH_FAN_CAST_TEXTURE_PATH := "res://assets/enemies/bosses/thorn_matriarch/thorn_matriarch_fan_cast_strip_normalized_v2.png"
var THORN_MATRIARCH_MINE_CAST_TEXTURE: Texture2D
const THORN_MATRIARCH_MINE_CAST_TEXTURE_PATH := "res://assets/enemies/bosses/thorn_matriarch/thorn_matriarch_mine_cast_strip_normalized_v2.png"
var MAW_SOVEREIGN_ARMORED_TEXTURE: Texture2D
const MAW_SOVEREIGN_ARMORED_TEXTURE_PATH := "res://assets/enemies/bosses/maw_sovereign/maw_sovereign_idle_armored_strip_normalized_v2.png"
var MAW_SOVEREIGN_EXPOSED_TEXTURE: Texture2D
const MAW_SOVEREIGN_EXPOSED_TEXTURE_PATH := "res://assets/enemies/bosses/maw_sovereign/maw_sovereign_idle_exposed_strip_normalized_v2.png"
var MAW_SOVEREIGN_DEATH_TEXTURE: Texture2D
const MAW_SOVEREIGN_DEATH_TEXTURE_PATH := "res://assets/enemies/bosses/maw_sovereign/maw_sovereign_death_strip_normalized_v2.png"
var MAW_SOVEREIGN_SPORE_CAST_TEXTURE: Texture2D
const MAW_SOVEREIGN_SPORE_CAST_TEXTURE_PATH := "res://assets/enemies/bosses/maw_sovereign/maw_sovereign_spore_cast_strip_normalized_v2.png"
var MAW_SOVEREIGN_ROTATING_CAST_TEXTURE: Texture2D
const MAW_SOVEREIGN_ROTATING_CAST_TEXTURE_PATH := "res://assets/enemies/bosses/maw_sovereign/maw_sovereign_rotating_volley_cast_strip_normalized_v2.png"
var MAW_SOVEREIGN_AIMED_CAST_TEXTURE: Texture2D
const MAW_SOVEREIGN_AIMED_CAST_TEXTURE_PATH := "res://assets/enemies/bosses/maw_sovereign/maw_sovereign_aimed_volley_cast_strip_normalized_v2.png"
var POSSESSED_BANYAN_ARMORED_TEXTURE: Texture2D
const POSSESSED_BANYAN_ARMORED_TEXTURE_PATH := "res://assets/enemies/bosses/possessed_banyan/possessed_banyan_idle_armored_strip_normalized_v2.png"
var POSSESSED_BANYAN_EXPOSED_TEXTURE: Texture2D
const POSSESSED_BANYAN_EXPOSED_TEXTURE_PATH := "res://assets/enemies/bosses/possessed_banyan/possessed_banyan_idle_exposed_strip_normalized_v2.png"
var POSSESSED_BANYAN_DEATH_TEXTURE: Texture2D
const POSSESSED_BANYAN_DEATH_TEXTURE_PATH := "res://assets/enemies/bosses/possessed_banyan/possessed_banyan_death_strip_normalized_v2.png"
var POSSESSED_BANYAN_SEED_COLUMN_CAST_TEXTURE: Texture2D
const POSSESSED_BANYAN_SEED_COLUMN_CAST_TEXTURE_PATH := "res://assets/enemies/bosses/possessed_banyan/possessed_banyan_seed_column_cast_strip_normalized_v2.png"
var POSSESSED_BANYAN_DIAGONAL_CAST_TEXTURE: Texture2D
const POSSESSED_BANYAN_DIAGONAL_CAST_TEXTURE_PATH := "res://assets/enemies/bosses/possessed_banyan/possessed_banyan_diagonal_root_cast_strip_normalized_v2.png"

@onready var visual: Sprite2D = $Visual
@onready var visual_accent: Sprite2D = $VisualAccent
@onready var hit_vfx: AnimatedSprite2D = $HitVfx
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
var boss_hurt_timer: float = 0.0
var base_visual_modulate: Color = Color.WHITE
var root_skitter_action: StringName = &"idle"
var root_skitter_frame_clock: float = 0.0
var root_skitter_attack_timer: float = 0.0
var root_skitter_hurt_timer: float = 0.0
var thornling_action: StringName = &"idle"
var thornling_frame_clock: float = 0.0
var thornling_attack_timer: float = 0.0
var thornling_hurt_timer: float = 0.0
var spitter_action: StringName = &"idle"
var spitter_frame_clock: float = 0.0
var spitter_attack_timer: float = 0.0
var spitter_hurt_timer: float = 0.0
var spitter_attack_variant: int = 1
var maw_action: StringName = &"idle"
var maw_frame_clock: float = 0.0
var maw_attack_timer: float = 0.0
var maw_hurt_timer: float = 0.0
var capsule_husk_action: StringName = &"idle"
var capsule_husk_frame_clock: float = 0.0
var capsule_husk_attack_timer: float = 0.0
var capsule_husk_hurt_timer: float = 0.0
var mixed_elite_frame_clock: float = 0.0
var mixed_elite_action: StringName = &"idle"
var root_hydra_frame_clock: float = 0.0
var root_hydra_visual_phase: int = 0
var root_hydra_action: StringName = &"idle"
var eye_wisp_frame_clock: float = 0.0
var eye_wisp_action: StringName = &"hover"
var eye_wisp_attack_timer: float = 0.0
var eye_wisp_hurt_timer: float = 0.0
var eye_wisp_attack_variant: int = 0
var root_core_eye_frame_clock: float = 0.0
var root_core_eye_visual_phase: int = 0
var root_core_eye_action: StringName = &"idle"
var thorn_matriarch_frame_clock: float = 0.0
var thorn_matriarch_visual_phase: int = 0
var thorn_matriarch_action: StringName = &"idle"
var maw_sovereign_frame_clock: float = 0.0
var maw_sovereign_visual_phase: int = 0
var maw_sovereign_action: StringName = &"idle"
var possessed_banyan_frame_clock: float = 0.0
var possessed_banyan_visual_phase: int = 0
var possessed_banyan_action: StringName = &"idle"
var _loaded_texture_type := ""


func _load_texture(path: String) -> Texture2D:
	return GameManager.load_runtime_texture(path)


func _load_named_texture(field_name: String, path: String) -> void:
	set(field_name, _load_texture(path))


func _load_textures_for_type(type_id: String) -> void:
	if _loaded_texture_type == type_id:
		return
	_load_named_texture("ORGANIC_HIT_VFX_TEXTURE", ORGANIC_HIT_VFX_TEXTURE_PATH)
	_load_named_texture("ARMORED_HIT_VFX_TEXTURE", ARMORED_HIT_VFX_TEXTURE_PATH)
	_load_named_texture("BOSS_CORE_HIT_VFX_TEXTURE", BOSS_CORE_HIT_VFX_TEXTURE_PATH)
	match type_id:
		"thornling":
			_load_named_texture("THORNLING_IDLE_TEXTURE", THORNLING_IDLE_TEXTURE_PATH)
			_load_named_texture("THORNLING_RUN_TEXTURE", THORNLING_RUN_TEXTURE_PATH)
			_load_named_texture("THORNLING_ATTACK_TEXTURE", THORNLING_ATTACK_TEXTURE_PATH)
			_load_named_texture("THORNLING_ATTACK_TELL_TEXTURE", THORNLING_ATTACK_TELL_TEXTURE_PATH)
			_load_named_texture("THORNLING_HURT_TEXTURE", THORNLING_HURT_TEXTURE_PATH)
			_load_named_texture("THORNLING_DEATH_TEXTURE", THORNLING_DEATH_TEXTURE_PATH)
			_load_named_texture("THORNLING_CONTACT_HIT_TEXTURE", THORNLING_CONTACT_HIT_TEXTURE_PATH)
		"spitter", "marsh_spitter":
			_load_named_texture("SPITTER_IDLE_TEXTURE", SPITTER_IDLE_TEXTURE_PATH)
			_load_named_texture("SPITTER_WALK_TEXTURE", SPITTER_WALK_TEXTURE_PATH)
			_load_named_texture("SPITTER_SEED_BURST_TEXTURE", SPITTER_SEED_BURST_TEXTURE_PATH)
			_load_named_texture("SPITTER_PRESSURE_TELL_TEXTURE", SPITTER_PRESSURE_TELL_TEXTURE_PATH)
			_load_named_texture("SPITTER_JUICE_LOB_TEXTURE", SPITTER_JUICE_LOB_TEXTURE_PATH)
			_load_named_texture("SPITTER_HURT_TEXTURE", SPITTER_HURT_TEXTURE_PATH)
			_load_named_texture("SPITTER_DEATH_TEXTURE", SPITTER_DEATH_TEXTURE_PATH)
		"maw":
			_load_named_texture("MAW_IDLE_TEXTURE", MAW_IDLE_TEXTURE_PATH)
			_load_named_texture("MAW_MOVE_TEXTURE", MAW_MOVE_TEXTURE_PATH)
			_load_named_texture("MAW_ANTICIPATION_TEXTURE", MAW_ANTICIPATION_TEXTURE_PATH)
			_load_named_texture("MAW_ATTACK_TEXTURE", MAW_ATTACK_TEXTURE_PATH)
			_load_named_texture("MAW_HURT_TEXTURE", MAW_HURT_TEXTURE_PATH)
			_load_named_texture("MAW_DEATH_TEXTURE", MAW_DEATH_TEXTURE_PATH)
		"root_skitter":
			_load_named_texture("ROOT_SKITTER_IDLE_TEXTURE", ROOT_SKITTER_IDLE_TEXTURE_PATH)
			_load_named_texture("ROOT_SKITTER_SCUTTLE_TEXTURE", ROOT_SKITTER_SCUTTLE_TEXTURE_PATH)
			_load_named_texture("ROOT_SKITTER_BURROW_TELL_TEXTURE", ROOT_SKITTER_BURROW_TELL_TEXTURE_PATH)
			_load_named_texture("ROOT_SKITTER_BURROW_TEXTURE", ROOT_SKITTER_BURROW_TEXTURE_PATH)
			_load_named_texture("ROOT_SKITTER_EMERGE_ATTACK_TEXTURE", ROOT_SKITTER_EMERGE_ATTACK_TEXTURE_PATH)
			_load_named_texture("ROOT_SKITTER_HURT_TEXTURE", ROOT_SKITTER_HURT_TEXTURE_PATH)
			_load_named_texture("ROOT_SKITTER_DEATH_TEXTURE", ROOT_SKITTER_DEATH_TEXTURE_PATH)
		"capsule_husk_elite", "mixed_elite":
			_load_named_texture("CAPSULE_HUSK_IDLE_TEXTURE", CAPSULE_HUSK_IDLE_TEXTURE_PATH)
			_load_named_texture("CAPSULE_HUSK_MOVE_TEXTURE", CAPSULE_HUSK_MOVE_TEXTURE_PATH)
			_load_named_texture("CAPSULE_HUSK_CHARGE_TELL_TEXTURE", CAPSULE_HUSK_CHARGE_TELL_TEXTURE_PATH)
			_load_named_texture("CAPSULE_HUSK_CHARGE_TEXTURE", CAPSULE_HUSK_CHARGE_TEXTURE_PATH)
			_load_named_texture("CAPSULE_HUSK_CORE_ATTACK_TEXTURE", CAPSULE_HUSK_CORE_ATTACK_TEXTURE_PATH)
			_load_named_texture("CAPSULE_HUSK_HURT_TEXTURE", CAPSULE_HUSK_HURT_TEXTURE_PATH)
			_load_named_texture("CAPSULE_HUSK_DEATH_TEXTURE", CAPSULE_HUSK_DEATH_TEXTURE_PATH)
			if type_id == "mixed_elite":
				_load_named_texture("EYE_WISP_HOVER_TEXTURE", EYE_WISP_HOVER_TEXTURE_PATH)
		"eye_wisp":
			_load_named_texture("EYE_WISP_HOVER_TEXTURE", EYE_WISP_HOVER_TEXTURE_PATH)
			_load_named_texture("EYE_WISP_FLY_TEXTURE", EYE_WISP_FLY_TEXTURE_PATH)
			_load_named_texture("EYE_WISP_AIM_TELL_TEXTURE", EYE_WISP_AIM_TELL_TEXTURE_PATH)
			_load_named_texture("EYE_WISP_SEED_BOLT_TEXTURE", EYE_WISP_SEED_BOLT_TEXTURE_PATH)
			_load_named_texture("EYE_WISP_BEAM_ATTACK_TEXTURE", EYE_WISP_BEAM_ATTACK_TEXTURE_PATH)
			_load_named_texture("EYE_WISP_HURT_TEXTURE", EYE_WISP_HURT_TEXTURE_PATH)
			_load_named_texture("EYE_WISP_DEATH_TEXTURE", EYE_WISP_DEATH_TEXTURE_PATH)
		"root_hydra_boss":
			_load_named_texture("ROOT_HYDRA_IDLE_TEXTURE", ROOT_HYDRA_IDLE_TEXTURE_PATH)
			_load_named_texture("ROOT_HYDRA_EXPOSED_TEXTURE", ROOT_HYDRA_EXPOSED_TEXTURE_PATH)
			_load_named_texture("ROOT_HYDRA_CROSSFIRE_CAST_TEXTURE", ROOT_HYDRA_CROSSFIRE_CAST_TEXTURE_PATH)
			_load_named_texture("ROOT_HYDRA_RADIAL_RING_CAST_TEXTURE", ROOT_HYDRA_RADIAL_RING_CAST_TEXTURE_PATH)
			_load_named_texture("ROOT_HYDRA_LANE_WALL_CAST_TEXTURE", ROOT_HYDRA_LANE_WALL_CAST_TEXTURE_PATH)
			_load_named_texture("ROOT_HYDRA_DEATH_TEXTURE", ROOT_HYDRA_DEATH_TEXTURE_PATH)
			_load_named_texture("ROOT_HYDRA_HURT_TEXTURE", ROOT_HYDRA_HURT_TEXTURE_PATH)
		"root_core_eye_boss":
			_load_named_texture("ROOT_CORE_EYE_SEALED_TEXTURE", ROOT_CORE_EYE_SEALED_TEXTURE_PATH)
			_load_named_texture("ROOT_CORE_EYE_EXPOSED_TEXTURE", ROOT_CORE_EYE_EXPOSED_TEXTURE_PATH)
			_load_named_texture("ROOT_CORE_EYE_SPIRAL_CAST_TEXTURE", ROOT_CORE_EYE_SPIRAL_CAST_TEXTURE_PATH)
			_load_named_texture("ROOT_CORE_EYE_AIMED_CAST_TEXTURE", ROOT_CORE_EYE_AIMED_CAST_TEXTURE_PATH)
			_load_named_texture("ROOT_CORE_EYE_CURTAIN_CAST_TEXTURE", ROOT_CORE_EYE_CURTAIN_CAST_TEXTURE_PATH)
			_load_named_texture("ROOT_CORE_EYE_DEATH_TEXTURE", ROOT_CORE_EYE_DEATH_TEXTURE_PATH)
			_load_named_texture("ROOT_CORE_EYE_HURT_TEXTURE", ROOT_CORE_EYE_HURT_TEXTURE_PATH)
		"thorn_matriarch_boss":
			_load_named_texture("THORN_MATRIARCH_ARMORED_TEXTURE", THORN_MATRIARCH_ARMORED_TEXTURE_PATH)
			_load_named_texture("THORN_MATRIARCH_EXPOSED_TEXTURE", THORN_MATRIARCH_EXPOSED_TEXTURE_PATH)
			_load_named_texture("THORN_MATRIARCH_DEATH_TEXTURE", THORN_MATRIARCH_DEATH_TEXTURE_PATH)
			_load_named_texture("THORN_MATRIARCH_FAN_CAST_TEXTURE", THORN_MATRIARCH_FAN_CAST_TEXTURE_PATH)
			_load_named_texture("THORN_MATRIARCH_MINE_CAST_TEXTURE", THORN_MATRIARCH_MINE_CAST_TEXTURE_PATH)
		"maw_sovereign_boss":
			_load_named_texture("MAW_SOVEREIGN_ARMORED_TEXTURE", MAW_SOVEREIGN_ARMORED_TEXTURE_PATH)
			_load_named_texture("MAW_SOVEREIGN_EXPOSED_TEXTURE", MAW_SOVEREIGN_EXPOSED_TEXTURE_PATH)
			_load_named_texture("MAW_SOVEREIGN_DEATH_TEXTURE", MAW_SOVEREIGN_DEATH_TEXTURE_PATH)
			_load_named_texture("MAW_SOVEREIGN_SPORE_CAST_TEXTURE", MAW_SOVEREIGN_SPORE_CAST_TEXTURE_PATH)
			_load_named_texture("MAW_SOVEREIGN_ROTATING_CAST_TEXTURE", MAW_SOVEREIGN_ROTATING_CAST_TEXTURE_PATH)
			_load_named_texture("MAW_SOVEREIGN_AIMED_CAST_TEXTURE", MAW_SOVEREIGN_AIMED_CAST_TEXTURE_PATH)
		"banyan_boss":
			_load_named_texture("POSSESSED_BANYAN_ARMORED_TEXTURE", POSSESSED_BANYAN_ARMORED_TEXTURE_PATH)
			_load_named_texture("POSSESSED_BANYAN_EXPOSED_TEXTURE", POSSESSED_BANYAN_EXPOSED_TEXTURE_PATH)
			_load_named_texture("POSSESSED_BANYAN_DEATH_TEXTURE", POSSESSED_BANYAN_DEATH_TEXTURE_PATH)
			_load_named_texture("POSSESSED_BANYAN_SEED_COLUMN_CAST_TEXTURE", POSSESSED_BANYAN_SEED_COLUMN_CAST_TEXTURE_PATH)
			_load_named_texture("POSSESSED_BANYAN_DIAGONAL_CAST_TEXTURE", POSSESSED_BANYAN_DIAGONAL_CAST_TEXTURE_PATH)
	_loaded_texture_type = type_id


func configure(type_id: String) -> void:
	enemy_type = type_id
	_load_textures_for_type(enemy_type)
	is_boss = enemy_type.ends_with("_boss")
	visual_accent.visible = false
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
			visual.texture = SPITTER_IDLE_TEXTURE
			visual.hframes = 4
			visual.vframes = 1
			visual.frame = 0
			visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			visual.modulate = Color("6fabc0")
			visual.scale = Vector2(0.045, 0.045)
			visual.position = Vector2(0.0, -18.0)
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
			visual.texture = CAPSULE_HUSK_IDLE_TEXTURE
			visual.hframes = 4
			visual.vframes = 1
			visual.frame = 0
			visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			visual.modulate = Color("d09562")
			visual.scale = Vector2(0.06, 0.06)
			visual.position = Vector2(0.0, -18.0)
			visual_accent.texture = EYE_WISP_HOVER_TEXTURE
			visual_accent.hframes = 4
			visual_accent.vframes = 1
			visual_accent.frame = 0
			visual_accent.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			visual_accent.modulate = Color("8ce7f6")
			visual_accent.scale = Vector2(0.032, 0.032)
			visual_accent.position = Vector2(0.0, -30.0)
			visual_accent.visible = true
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
	_setup_hit_vfx()
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
	spitter_attack_timer = maxf(spitter_attack_timer - delta, 0.0)
	spitter_hurt_timer = maxf(spitter_hurt_timer - delta, 0.0)
	eye_wisp_attack_timer = maxf(eye_wisp_attack_timer - delta, 0.0)
	eye_wisp_hurt_timer = maxf(eye_wisp_hurt_timer - delta, 0.0)
	thornling_attack_timer = maxf(thornling_attack_timer - delta, 0.0)
	thornling_hurt_timer = maxf(thornling_hurt_timer - delta, 0.0)
	maw_attack_timer = maxf(maw_attack_timer - delta, 0.0)
	maw_hurt_timer = maxf(maw_hurt_timer - delta, 0.0)
	capsule_husk_attack_timer = maxf(capsule_husk_attack_timer - delta, 0.0)
	capsule_husk_hurt_timer = maxf(capsule_husk_hurt_timer - delta, 0.0)
	root_skitter_attack_timer = maxf(root_skitter_attack_timer - delta, 0.0)
	root_skitter_hurt_timer = maxf(root_skitter_hurt_timer - delta, 0.0)
	boss_hurt_timer = maxf(boss_hurt_timer - delta, 0.0)
	velocity.y += GRAVITY * delta
	if is_instance_valid(target):
		var offset := target.global_position - global_position
		if absf(offset.x) < detection_range and absf(offset.y) < 180.0:
			facing = signf(offset.x)
			if pattern_attack_locked:
				velocity.x = 0.0
			elif enemy_type == "spitter" or enemy_type == "marsh_spitter":
				velocity.x = 0.0
				if shoot_cooldown <= 0.0:
					_shoot(offset.normalized())
			elif enemy_type == "eye_wisp":
				velocity.x = facing * move_speed * 0.45
				if shoot_cooldown <= 0.0:
					_shoot(offset.normalized())
			else:
				velocity.x = facing * move_speed
			if offset.length() < 58.0 and attack_cooldown <= 0.0:
				target.take_damage(contact_damage, Vector2(facing, 0.0))
				attack_cooldown = 0.9
				if enemy_type == "thornling":
					thornling_attack_timer = 0.35
					thornling_action = &"attack"
					thornling_frame_clock = 0.0
					visual.texture = THORNLING_ATTACK_TEXTURE
					visual.hframes = 4
					visual.vframes = 1
					visual.frame = 0
				elif enemy_type == "maw":
					maw_attack_timer = 0.4
					maw_action = &"anticipation"
					maw_frame_clock = 0.0
				elif enemy_type == "capsule_husk_elite" or enemy_type == "mixed_elite":
					capsule_husk_attack_timer = 0.45
					capsule_husk_action = &"charge_tell"
					capsule_husk_frame_clock = 0.0
				elif enemy_type == "root_skitter":
					root_skitter_attack_timer = 0.5
					root_skitter_action = &"burrow_tell"
					root_skitter_frame_clock = 0.0
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
	var next_action: StringName = &"hurt" if thornling_hurt_timer > 0.0 else (&"attack" if thornling_attack_timer > 0.0 else (&"run" if is_on_floor() and absf(velocity.x) > 8.0 else &"idle"))
	var desired_texture: Texture2D = THORNLING_IDLE_TEXTURE
	match next_action:
		&"hurt":
			desired_texture = THORNLING_HURT_TEXTURE
		&"attack":
			desired_texture = THORNLING_ATTACK_TELL_TEXTURE if thornling_attack_timer > 0.22 else THORNLING_ATTACK_TEXTURE
		&"run":
			desired_texture = THORNLING_RUN_TEXTURE
	if next_action != thornling_action or visual.texture != desired_texture:
		thornling_action = next_action
		thornling_frame_clock = 0.0
		visual.texture = desired_texture
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	var frame_rate := 8.0 if next_action == &"attack" or next_action == &"hurt" else (7.0 if next_action == &"run" else 4.0)
	thornling_frame_clock = fmod(thornling_frame_clock + delta * frame_rate, 4.0)
	visual.frame = int(thornling_frame_clock)


func _update_spitter_animation(delta: float) -> void:
	if enemy_type != "spitter" and enemy_type != "marsh_spitter":
		return
	var cast_action: StringName = &"seed_burst" if spitter_attack_variant == 0 else &"juice_lob"
	var next_action: StringName = &"hurt" if spitter_hurt_timer > 0.0 else (&"pressure_tell" if spitter_attack_timer > 0.35 else (cast_action if spitter_attack_timer > 0.0 else (&"walk" if is_on_floor() and absf(velocity.x) > 8.0 else &"idle")))
	var desired_texture: Texture2D = SPITTER_IDLE_TEXTURE
	match next_action:
		&"hurt":
			desired_texture = SPITTER_HURT_TEXTURE
		&"pressure_tell":
			desired_texture = SPITTER_PRESSURE_TELL_TEXTURE
		&"seed_burst":
			desired_texture = SPITTER_SEED_BURST_TEXTURE
		&"juice_lob":
			desired_texture = SPITTER_JUICE_LOB_TEXTURE
		&"walk":
			desired_texture = SPITTER_WALK_TEXTURE
	if next_action != spitter_action or visual.texture != desired_texture:
		spitter_action = next_action
		spitter_frame_clock = 0.0
		visual.texture = desired_texture
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	var frame_rate := 8.0 if next_action == &"seed_burst" or next_action == &"juice_lob" or next_action == &"pressure_tell" or next_action == &"hurt" else (7.0 if next_action == &"walk" else 4.0)
	spitter_frame_clock = fmod(spitter_frame_clock + delta * frame_rate, 4.0)
	visual.frame = int(spitter_frame_clock)


func _update_maw_animation(delta: float) -> void:
	if enemy_type != "maw":
		return
	var next_action: StringName = &"hurt" if maw_hurt_timer > 0.0 else (&"anticipation" if maw_attack_timer > 0.24 else (&"attack" if maw_attack_timer > 0.0 else (&"move" if is_on_floor() and absf(velocity.x) > 8.0 else &"idle")))
	var desired_texture: Texture2D = MAW_IDLE_TEXTURE
	match next_action:
		&"hurt":
			desired_texture = MAW_HURT_TEXTURE
		&"anticipation":
			desired_texture = MAW_ANTICIPATION_TEXTURE
		&"attack":
			desired_texture = MAW_ATTACK_TEXTURE
		&"move":
			desired_texture = MAW_MOVE_TEXTURE
	if next_action != maw_action or visual.texture != desired_texture:
		maw_action = next_action
		maw_frame_clock = 0.0
		visual.texture = desired_texture
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	var frame_rate := 7.0 if next_action == &"anticipation" or next_action == &"attack" or next_action == &"hurt" else (6.0 if next_action == &"move" else 3.5)
	maw_frame_clock = fmod(maw_frame_clock + delta * frame_rate, 4.0)
	visual.frame = int(maw_frame_clock)


func _update_capsule_husk_animation(delta: float) -> void:
	if enemy_type != "capsule_husk_elite" and enemy_type != "mixed_elite":
		return
	var next_action: StringName = &"hurt" if capsule_husk_hurt_timer > 0.0 else (&"charge_tell" if capsule_husk_attack_timer > 0.28 else (&"core_attack" if capsule_husk_attack_timer > 0.0 else (&"move" if is_on_floor() and absf(velocity.x) > 8.0 else &"idle")))
	var desired_texture: Texture2D = CAPSULE_HUSK_IDLE_TEXTURE
	match next_action:
		&"hurt":
			desired_texture = CAPSULE_HUSK_HURT_TEXTURE
		&"charge_tell":
			desired_texture = CAPSULE_HUSK_CHARGE_TELL_TEXTURE
		&"core_attack":
			desired_texture = CAPSULE_HUSK_CORE_ATTACK_TEXTURE
		&"move":
			desired_texture = CAPSULE_HUSK_MOVE_TEXTURE
	if next_action != capsule_husk_action or visual.texture != desired_texture:
		capsule_husk_action = next_action
		capsule_husk_frame_clock = 0.0
		visual.texture = desired_texture
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	var frame_rate := 7.0 if next_action == &"charge_tell" or next_action == &"core_attack" or next_action == &"hurt" else (5.5 if next_action == &"move" else 3.5)
	capsule_husk_frame_clock = fmod(capsule_husk_frame_clock + delta * frame_rate, 4.0)
	visual.frame = int(capsule_husk_frame_clock)
	if enemy_type == "mixed_elite" and visual_accent.visible:
		mixed_elite_action = next_action
		mixed_elite_frame_clock = capsule_husk_frame_clock
		visual_accent.frame = visual.frame


func _update_root_skitter_animation(delta: float) -> void:
	if enemy_type != "root_skitter":
		return
	var next_action: StringName = &"hurt" if root_skitter_hurt_timer > 0.0 else (&"burrow_tell" if root_skitter_attack_timer > 0.34 else (&"burrow" if root_skitter_attack_timer > 0.2 else (&"emerge_attack" if root_skitter_attack_timer > 0.0 else (&"scuttle" if is_on_floor() and absf(velocity.x) > 8.0 else &"idle"))))
	var desired_texture: Texture2D = ROOT_SKITTER_IDLE_TEXTURE
	match next_action:
		&"hurt":
			desired_texture = ROOT_SKITTER_HURT_TEXTURE
		&"burrow_tell":
			desired_texture = ROOT_SKITTER_BURROW_TELL_TEXTURE
		&"burrow":
			desired_texture = ROOT_SKITTER_BURROW_TEXTURE
		&"emerge_attack":
			desired_texture = ROOT_SKITTER_EMERGE_ATTACK_TEXTURE
		&"scuttle":
			desired_texture = ROOT_SKITTER_SCUTTLE_TEXTURE
	if next_action != root_skitter_action or visual.texture != desired_texture:
		root_skitter_action = next_action
		root_skitter_frame_clock = 0.0
		visual.texture = desired_texture
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	var frame_rate := 8.0 if next_action == &"scuttle" or next_action == &"burrow_tell" or next_action == &"burrow" or next_action == &"emerge_attack" or next_action == &"hurt" else 5.5
	root_skitter_frame_clock = fmod(root_skitter_frame_clock + delta * frame_rate, 4.0)
	visual.frame = int(root_skitter_frame_clock)


func _update_root_hydra_animation(delta: float) -> void:
	if enemy_type != "root_hydra_boss":
		return
	var desired_texture: Texture2D = ROOT_HYDRA_EXPOSED_TEXTURE if boss_phase >= 2 else ROOT_HYDRA_IDLE_TEXTURE
	if boss_hurt_timer > 0.0 and root_hydra_action == &"idle":
		desired_texture = ROOT_HYDRA_HURT_TEXTURE
	else:
		match root_hydra_action:
			&"crossfire_cast":
				desired_texture = ROOT_HYDRA_CROSSFIRE_CAST_TEXTURE
			&"radial_ring_cast":
				desired_texture = ROOT_HYDRA_RADIAL_RING_CAST_TEXTURE
			&"lane_wall_cast":
				desired_texture = ROOT_HYDRA_LANE_WALL_CAST_TEXTURE
	if root_hydra_visual_phase != boss_phase or visual.texture != desired_texture:
		root_hydra_visual_phase = boss_phase
		visual.texture = desired_texture
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	var frame_rate := 8.0 if boss_hurt_timer > 0.0 or root_hydra_action != &"idle" else 3.0
	root_hydra_frame_clock = fmod(root_hydra_frame_clock + delta * frame_rate, 4.0)
	visual.frame = int(root_hydra_frame_clock)


func _update_eye_wisp_animation(delta: float) -> void:
	if enemy_type != "eye_wisp":
		return
	var attack_action: StringName = &"seed_bolt" if eye_wisp_attack_variant == 0 else &"beam_attack"
	var next_action: StringName = &"hurt" if eye_wisp_hurt_timer > 0.0 else (&"aim_tell" if eye_wisp_attack_timer > 0.38 else (attack_action if eye_wisp_attack_timer > 0.0 else (&"fly" if absf(velocity.x) > 8.0 else &"hover")))
	var desired_texture: Texture2D = EYE_WISP_HOVER_TEXTURE
	match next_action:
		&"hurt":
			desired_texture = EYE_WISP_HURT_TEXTURE
		&"aim_tell":
			desired_texture = EYE_WISP_AIM_TELL_TEXTURE
		&"seed_bolt":
			desired_texture = EYE_WISP_SEED_BOLT_TEXTURE
		&"beam_attack":
			desired_texture = EYE_WISP_BEAM_ATTACK_TEXTURE
		&"fly":
			desired_texture = EYE_WISP_FLY_TEXTURE
	if next_action != eye_wisp_action or visual.texture != desired_texture:
		eye_wisp_action = next_action
		eye_wisp_frame_clock = 0.0
		visual.texture = desired_texture
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	var frame_rate := 8.0 if next_action == &"aim_tell" or next_action == &"seed_bolt" or next_action == &"beam_attack" or next_action == &"hurt" else (7.0 if next_action == &"fly" else 4.5)
	eye_wisp_frame_clock = fmod(eye_wisp_frame_clock + delta * frame_rate, 4.0)
	visual.frame = int(eye_wisp_frame_clock)


func _update_root_core_eye_animation(delta: float) -> void:
	if enemy_type != "root_core_eye_boss":
		return
	var desired_texture: Texture2D = ROOT_CORE_EYE_EXPOSED_TEXTURE if boss_phase >= 2 else ROOT_CORE_EYE_SEALED_TEXTURE
	if boss_hurt_timer > 0.0 and root_core_eye_action == &"idle":
		desired_texture = ROOT_CORE_EYE_HURT_TEXTURE
	else:
		match root_core_eye_action:
			&"spiral_cast":
				desired_texture = ROOT_CORE_EYE_SPIRAL_CAST_TEXTURE
			&"aimed_cast":
				desired_texture = ROOT_CORE_EYE_AIMED_CAST_TEXTURE
			&"curtain_cast":
				desired_texture = ROOT_CORE_EYE_CURTAIN_CAST_TEXTURE
	if root_core_eye_visual_phase != boss_phase or visual.texture != desired_texture:
		root_core_eye_visual_phase = boss_phase
		visual.texture = desired_texture
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	var frame_rate := 8.0 if boss_hurt_timer > 0.0 or root_core_eye_action != &"idle" else 3.0
	root_core_eye_frame_clock = fmod(root_core_eye_frame_clock + delta * frame_rate, 4.0)
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
	if enemy_type == "spitter" or enemy_type == "marsh_spitter":
		spitter_attack_timer = 0.5
		spitter_attack_variant = 1 - spitter_attack_variant
		spitter_action = &"seed_burst" if spitter_attack_variant == 0 else &"juice_lob"
		spitter_frame_clock = 0.0
		visual.texture = SPITTER_SEED_BURST_TEXTURE if spitter_attack_variant == 0 else SPITTER_JUICE_LOB_TEXTURE
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	elif enemy_type == "eye_wisp":
		eye_wisp_attack_timer = 0.65
		eye_wisp_attack_variant = 1 - eye_wisp_attack_variant
		eye_wisp_action = &"aim_tell"
		eye_wisp_frame_clock = 0.0
		visual.texture = EYE_WISP_AIM_TELL_TEXTURE
		visual.hframes = 4
		visual.vframes = 1
		visual.frame = 0
	var projectile := PROJECTILE_SCENE.instantiate() as EnemyProjectile
	projectile.direction = direction
	projectile.damage = contact_damage
	get_tree().current_scene.add_child(projectile)
	if enemy_type == "eye_wisp":
		projectile.visual.texture = EYE_WISP_SEED_BOLT_TEXTURE if eye_wisp_attack_variant == 0 else EYE_WISP_BEAM_ATTACK_TEXTURE
		projectile.visual.hframes = 4
		projectile.visual.vframes = 1
		projectile.visual.scale = Vector2.ONE * 0.009
	projectile.global_position = global_position + Vector2(facing * 28.0, -8.0)


func take_damage(amount: int = 1, source_direction: Vector2 = Vector2.ZERO) -> bool:
	var applied := health.take_damage(amount)
	if applied:
		AudioManager.play_named_sfx(&"enemy_hit", 1.0, -9.0)
		if enemy_type == "thornling":
			thornling_hurt_timer = 0.2
			thornling_action = &"hurt"
			thornling_frame_clock = 0.0
		elif enemy_type == "spitter" or enemy_type == "marsh_spitter":
			spitter_hurt_timer = 0.2
			spitter_action = &"hurt"
			spitter_frame_clock = 0.0
		elif enemy_type == "maw":
			maw_hurt_timer = 0.2
			maw_action = &"hurt"
			maw_frame_clock = 0.0
		elif enemy_type == "capsule_husk_elite" or enemy_type == "mixed_elite":
			capsule_husk_hurt_timer = 0.2
			capsule_husk_action = &"hurt"
			capsule_husk_frame_clock = 0.0
		elif enemy_type == "root_skitter":
			root_skitter_hurt_timer = 0.2
			root_skitter_action = &"hurt"
			root_skitter_frame_clock = 0.0
		elif enemy_type == "eye_wisp":
			eye_wisp_hurt_timer = 0.2
			eye_wisp_action = &"hurt"
			eye_wisp_frame_clock = 0.0
		elif enemy_type == "root_hydra_boss":
			boss_hurt_timer = 0.2
			root_hydra_frame_clock = 0.0
			if str(pattern_runner.state) != "telegraph":
				root_hydra_action = &"idle"
		elif enemy_type == "root_core_eye_boss":
			boss_hurt_timer = 0.2
			root_core_eye_frame_clock = 0.0
			if str(pattern_runner.state) != "telegraph":
				root_core_eye_action = &"idle"
		velocity = Vector2(source_direction.x * 180.0, -120.0)
		hit_vfx.visible = true
		hit_vfx.play(&"contact")
	return applied


func _setup_hit_vfx() -> void:
	var hit_texture: Texture2D = THORNLING_CONTACT_HIT_TEXTURE if enemy_type == "thornling" else ORGANIC_HIT_VFX_TEXTURE
	if is_boss:
		hit_texture = BOSS_CORE_HIT_VFX_TEXTURE if enemy_type == "root_core_eye_boss" else ARMORED_HIT_VFX_TEXTURE
	var frames := SpriteFrames.new()
	frames.remove_animation(&"default")
	frames.add_animation(&"contact")
	frames.set_animation_speed(&"contact", 16.0)
	frames.set_animation_loop(&"contact", false)
	for column in range(4):
		var frame := AtlasTexture.new()
		frame.atlas = hit_texture
		frame.region = Rect2(Vector2(column * 800.0, 0.0), Vector2(800.0, 800.0))
		frame.filter_clip = true
		frames.add_frame(&"contact", frame)
	hit_vfx.sprite_frames = frames
	hit_vfx.animation_finished.connect(_on_hit_vfx_finished)


func _on_hit_vfx_finished() -> void:
	hit_vfx.visible = false


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
	AudioManager.play_named_sfx(&"boss_defeat" if is_boss else &"enemy_hit", 1.0 if is_boss else 0.85, -8.0)
	if is_boss:
		GameManager.register_boss_defeated()
	else:
		GameManager.register_enemy_defeated()
	var death_texture: Texture2D = _get_standard_death_texture()
	if death_texture != null:
		visual.texture = death_texture
		visual.hframes = _get_death_frame_count()
		visual.vframes = 1
		visual.frame = 0
		visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		velocity = Vector2.ZERO
		set_physics_process(false)
		$CollisionShape2D.set_deferred("disabled", true)
		$HurtBox/CollisionShape2D.set_deferred("disabled", true)
		get_tree().create_timer(0.32).timeout.connect(queue_free)
		return
	queue_free()


func _get_standard_death_texture() -> Texture2D:
	match enemy_type:
		"thornling":
			return THORNLING_DEATH_TEXTURE
		"spitter", "marsh_spitter":
			return SPITTER_DEATH_TEXTURE
		"maw":
			return MAW_DEATH_TEXTURE
		"root_skitter":
			return ROOT_SKITTER_DEATH_TEXTURE
		"eye_wisp":
			return EYE_WISP_DEATH_TEXTURE
		"capsule_husk_elite", "mixed_elite":
			return CAPSULE_HUSK_DEATH_TEXTURE
		"thorn_matriarch_boss":
			return THORN_MATRIARCH_DEATH_TEXTURE
		"maw_sovereign_boss":
			return MAW_SOVEREIGN_DEATH_TEXTURE
		"banyan_boss":
			return POSSESSED_BANYAN_DEATH_TEXTURE
		"root_hydra_boss":
			return ROOT_HYDRA_DEATH_TEXTURE
		"root_core_eye_boss":
			return ROOT_CORE_EYE_DEATH_TEXTURE
	return null


func _get_death_frame_count() -> int:
	return 3 if enemy_type == "maw_sovereign_boss" or enemy_type == "banyan_boss" else 4


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
	# A phase transition owns the next telegraph presentation. Clear any
	# lingering damage-priority timer so the new cast is visible immediately.
	boss_hurt_timer = 0.0
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
	if enemy_type == "root_hydra_boss":
		match pattern_id:
			"hydra_head_crossfire":
				root_hydra_action = &"crossfire_cast"
			"hydra_offset_rings":
				root_hydra_action = &"radial_ring_cast"
			_:
				root_hydra_action = &"lane_wall_cast"
	if enemy_type == "root_core_eye_boss":
		match pattern_id:
			"eye_rotating_spirals":
				root_core_eye_action = &"spiral_cast"
			"eye_aimed_rings":
				root_core_eye_action = &"aimed_cast"
			_:
				root_core_eye_action = &"curtain_cast"
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
	if enemy_type == "root_hydra_boss":
		root_hydra_action = &"idle"
	if enemy_type == "root_core_eye_boss":
		root_core_eye_action = &"idle"
	visual.modulate = base_visual_modulate.darkened(0.18)
