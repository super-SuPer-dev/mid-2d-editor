extends Node2D

@onready var hud: GameHUD = $HUD
@onready var player: PlayerController = $Player
@onready var portal: ExitPortal = $Portal

var level_data: Dictionary
var mission_ended: bool = false
var boss: EnemyController
var triggered_radio_count: int = 0


func _ready() -> void:
	if not GameManager.run_active:
		GameManager.start_level(GameManager.current_level_id)
	level_data = LevelCatalog.get_level(GameManager.current_level_id)
	RenderingServer.set_default_clear_color(level_data["background"])
	player.set_camera_limits(level_data["size"])
	player.died.connect(_on_player_died)
	hud.bind_player(player)
	portal.player_entered.connect(_on_portal_entered)
	GameManager.objective_changed.connect(_on_objective_changed)
	GameManager.mission_phase_changed.connect(_on_mission_phase_changed)
	GameManager.boss_requested.connect(_on_boss_requested)
	boss = _find_level_boss()
	if is_instance_valid(boss):
		boss.set_combat_active(GameManager.mission_phase == GameManager.PHASE_BOSS_ACTIVE)
	_on_objective_changed(GameManager.defeated_enemies, GameManager.required_enemies)
	_on_mission_phase_changed(GameManager.mission_phase)
	var briefing_id := str(level_data.get("briefing_sequence", ""))
	if not briefing_id.is_empty():
		StoryManager.request_sequence(briefing_id)


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
	if is_instance_valid(boss):
		boss.set_combat_active(true)
	var sequence_id := str(level_data.get("boss_sequence", ""))
	if not sequence_id.is_empty():
		StoryManager.request_sequence(sequence_id, true)


func _find_level_boss() -> EnemyController:
	for candidate in get_tree().get_nodes_in_group("Boss"):
		if candidate is EnemyController and is_ancestor_of(candidate):
			return candidate as EnemyController
	return null


func _on_player_died() -> void:
	if mission_ended:
		return
	mission_ended = true
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
