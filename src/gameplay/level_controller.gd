extends Node2D

const BIOME_HAZARD_TEXTURE_PATHS: Dictionary = {
	"level_02": "res://assets/world/level_02_mutated_forest/hazards/mangosteen_spore_vent_normalized_v1.png",
	"level_03": "res://assets/world/level_03_capsule_07/hazards/santol_seed_piston_normalized_v1.png",
	"level_04": "res://assets/world/level_04_root_marsh/hazards/nutrient_root_eruption_normalized_v2.png",
	"level_05": "res://assets/world/level_05_alien_eye_nexus/hazards/sensory_platform_collapse_normalized_v2.png"
}
const BIOME_PLATFORM_TEXTURE_PATHS: Dictionary = {
	"level_02": "res://assets/world/level_02_mutated_forest/tiles/forest_ground_straight_v1.png",
	"level_03": "res://assets/world/level_03_capsule_07/tiles/capsule_ground_straight_v1.png",
	"level_04": "res://assets/world/level_04_root_marsh/tiles/marsh_ground_straight_v2.png",
	"level_05": "res://assets/world/level_05_alien_eye_nexus/tiles/nexus_ground_straight_v2.png"
}
const BIOME_PLATFORM_SCALE := Vector2(0.13812155, 0.045)

@onready var hud: GameHUD = $HUD
@onready var player: PlayerController = $Player
@onready var portal: ExitPortal = $Portal

var level_data: Dictionary
var mission_ended: bool = false
var boss: EnemyController
var triggered_radio_count: int = 0
var pending_boss_sequence_id: String = ""


func _ready() -> void:
	if not GameManager.run_active:
		GameManager.start_level(GameManager.current_level_id)
	level_data = LevelCatalog.get_level(GameManager.current_level_id)
	AudioManager.play_music(StringName(GameManager.current_level_id))
	_configure_biome_hazards()
	_configure_biome_platforms()
	RenderingServer.set_default_clear_color(level_data["background"])
	player.set_camera_limits(level_data["size"])
	player.died.connect(_on_player_died)
	hud.bind_player(player)
	portal.player_entered.connect(_on_portal_entered)
	GameManager.objective_changed.connect(_on_objective_changed)
	GameManager.mission_phase_changed.connect(_on_mission_phase_changed)
	GameManager.boss_requested.connect(_on_boss_requested)
	StoryManager.sequence_completed.connect(_on_sequence_completed)
	boss = _find_level_boss()
	if is_instance_valid(boss):
		boss.set_combat_active(GameManager.mission_phase == GameManager.PHASE_BOSS_ACTIVE)
	_on_objective_changed(GameManager.defeated_enemies, GameManager.required_enemies)
	_on_mission_phase_changed(GameManager.mission_phase)
	var briefing_id := str(level_data.get("briefing_sequence", ""))
	if not briefing_id.is_empty():
		StoryManager.request_sequence(briefing_id)


func _configure_biome_hazards() -> void:
	var hazard_path := str(BIOME_HAZARD_TEXTURE_PATHS.get(GameManager.current_level_id, ""))
	var texture := GameManager.load_runtime_texture(hazard_path) if not hazard_path.is_empty() else null
	if texture == null:
		return
	for child: Node in get_node("WorldGeometry").get_children():
		if child is DamageHazard:
			(child as DamageHazard).set_animation_texture(texture, 4, 8.0)


func _configure_biome_platforms() -> void:
	var platform_path := str(BIOME_PLATFORM_TEXTURE_PATHS.get(GameManager.current_level_id, ""))
	var texture := GameManager.load_runtime_texture(platform_path) if not platform_path.is_empty() else null
	if texture == null:
		return
	var frame_index := 0
	for child: Node in get_node("WorldGeometry").get_children():
		if not child.is_in_group("Platform"):
			continue
		var visual := child.get_node_or_null("Visual") as Sprite2D
		if visual == null:
			continue
		visual.material = null
		visual.texture = texture
		visual.hframes = 3
		visual.vframes = 1
		visual.frame = frame_index % 3
		visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		visual.scale = BIOME_PLATFORM_SCALE
		visual.position = Vector2.ZERO
		frame_index += 1


func _on_objective_changed(defeated: int, required: int) -> void:
	if is_instance_valid(portal):
		portal.set_active(GameManager.can_extract())
	if required <= 0 or GameManager.mission_phase != GameManager.PHASE_CLEAR_THREATS:
		return
	var sequences: Array = level_data.get("radio_sequences", [])
	var thresholds := [maxi(1, ceili(required * 0.25)), maxi(1, ceili(required * 0.5)), maxi(1, ceili(required * 0.75))]
	while triggered_radio_count < mini(sequences.size(), thresholds.size()) and defeated >= thresholds[triggered_radio_count]:
		StoryManager.request_sequence(str(sequences[triggered_radio_count]))
		triggered_radio_count += 1


func _on_mission_phase_changed(phase: StringName) -> void:
	if is_instance_valid(portal):
		portal.set_active(phase == GameManager.PHASE_EXTRACTION)


func _on_boss_requested(_boss_id: String, _boss_name_key: String) -> void:
	AudioManager.play_music(&"boss_nexus" if GameManager.current_level_id == "level_05" else &"boss_organic")
	if is_instance_valid(boss):
		boss.set_combat_active(false)
		GameManager.update_boss_health(boss.health.current_health, boss.health.max_health)
		GameManager.update_boss_phase(boss.boss_phase, boss.boss_phase_count)
	var sequence_id := str(level_data.get("boss_sequence", ""))
	if sequence_id.is_empty() or not StoryManager.request_sequence(sequence_id, true):
		_activate_boss_combat()
		return
	pending_boss_sequence_id = sequence_id


func _on_sequence_completed(completed_sequence_id: String) -> void:
	if pending_boss_sequence_id.is_empty() or completed_sequence_id != pending_boss_sequence_id:
		return
	pending_boss_sequence_id = ""
	_activate_boss_combat()


func _activate_boss_combat() -> void:
	if GameManager.mission_phase == GameManager.PHASE_BOSS_ACTIVE and is_instance_valid(boss):
		boss.set_combat_active(true)


func _find_level_boss() -> EnemyController:
	for candidate in get_tree().get_nodes_in_group("Boss"):
		if candidate is EnemyController and is_ancestor_of(candidate):
			return candidate as EnemyController
	return null


func _on_player_died() -> void:
	if mission_ended:
		return
	mission_ended = true
	pending_boss_sequence_id = ""
	if is_instance_valid(boss):
		boss.set_combat_active(false)
	GameManager.finish_run(false)
	hud.show_game_over()


func _on_portal_entered() -> void:
	if mission_ended or not GameManager.can_extract():
		return
	mission_ended = true
	SaveManager.complete_level(GameManager.current_level_id, GameManager.coin)
	GameManager.finish_run(true)
	var campaign_complete := str(level_data.get("next_level", "")).is_empty()
	hud.show_level_complete(campaign_complete)
