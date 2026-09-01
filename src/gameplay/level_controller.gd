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
const BIOME_PLATFORM_FRAME_SIZE := Vector2(724.0, 724.0)
const BIOME_PLATFORM_WORLD_SIZE := Vector2(100.0, 40.0)
const BIOME_PLATFORM_SCALE := BIOME_PLATFORM_WORLD_SIZE / BIOME_PLATFORM_FRAME_SIZE
# First opaque ground row in each three-frame biome strip. The generated
# textures include transparent headroom; aligning the texture rectangle
# instead of this painted row makes every collider-supported object float.
const BIOME_PLATFORM_CONTACT_ROWS: Dictionary = {
	"level_02": [141.0, 164.0, 139.0],
	"level_03": [139.0, 139.0, 139.0],
	"level_04": [128.0, 152.0, 122.0],
	"level_05": [137.0, 202.0, 137.0],
}

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
	_snap_characters_to_surfaces()
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
	var contact_rows: Array = BIOME_PLATFORM_CONTACT_ROWS.get(GameManager.current_level_id, [0.0, 0.0, 0.0])
	var frame_index := 0
	for child: Node in get_node("WorldGeometry").get_children():
		if not child.is_in_group("Platform"):
			continue
		var visual := child.get_node_or_null("Visual") as Sprite2D
		if visual == null:
			continue
		visual.texture = texture
		visual.hframes = 3
		visual.vframes = 1
		visual.frame = frame_index % 3
		visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		var parent_scale_y := maxf(absf((child as Node2D).scale.y), 0.001)
		visual.scale = Vector2(BIOME_PLATFORM_SCALE.x, BIOME_PLATFORM_SCALE.y / parent_scale_y)
		# Keep the authored 40 px wall depth while lifting the texture's
		# transparent headroom above the collider. The first painted terrain
		# row now lands exactly on the collision surface.
		var contact_row := float(contact_rows[frame_index % contact_rows.size()])
		var transparent_headroom_world := contact_row * BIOME_PLATFORM_SCALE.y
		visual.position = Vector2(
			0.0,
			-10.0 + (BIOME_PLATFORM_WORLD_SIZE.y * 0.5 - transparent_headroom_world) / parent_scale_y
		)
		frame_index += 1


func _snap_characters_to_surfaces() -> void:
	# Briefing dialogue pauses the scene immediately. Align authored characters
	# before that pause so they never appear suspended above their platforms.
	_snap_character_to_surface(player)
	for node: Node in get_node("Enemies").get_children():
		if not node is EnemyController:
			continue
		var enemy := node as EnemyController
		if enemy.enemy_type == "eye_wisp":
			continue
		_snap_character_to_surface(enemy)


func _snap_character_to_surface(character: CharacterBody2D) -> void:
	var character_collider := character.get_node_or_null("CollisionShape2D") as CollisionShape2D
	if character_collider == null or character_collider.shape == null:
		return
	var character_scale := character_collider.global_transform.get_scale().abs()
	var character_half_height := _shape_half_height(character_collider.shape) * character_scale.y
	var collider_offset_y := character_collider.global_position.y - character.global_position.y
	var support_y := INF
	for platform_node: Node in get_node("WorldGeometry").get_children():
		if not platform_node.is_in_group("Platform"):
			continue
		var platform_collider := platform_node.get_node_or_null("CollisionShape2D") as CollisionShape2D
		if platform_collider == null or not platform_collider.shape is RectangleShape2D:
			continue
		var platform_shape := platform_collider.shape as RectangleShape2D
		var platform_scale := platform_collider.global_transform.get_scale().abs()
		var half_width := platform_shape.size.x * platform_scale.x * 0.5
		var top_y := platform_collider.global_position.y - platform_shape.size.y * platform_scale.y * 0.5
		if absf(character.global_position.x - platform_collider.global_position.x) > half_width + 6.0:
			continue
		if top_y < character.global_position.y - 2.0:
			continue
		support_y = minf(support_y, top_y)
	if is_inf(support_y):
		return
	character.global_position.y = support_y - collider_offset_y - character_half_height
	character.velocity.y = 0.0


func _shape_half_height(shape: Shape2D) -> float:
	if shape is RectangleShape2D:
		return (shape as RectangleShape2D).size.y * 0.5
	if shape is CapsuleShape2D:
		return (shape as CapsuleShape2D).height * 0.5
	if shape is CircleShape2D:
		return (shape as CircleShape2D).radius
	return 0.0


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
