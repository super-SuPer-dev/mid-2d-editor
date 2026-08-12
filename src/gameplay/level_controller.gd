extends Node2D

@onready var hud: GameHUD = $HUD
@onready var player: PlayerController = $Player
@onready var portal: ExitPortal = $Portal

var level_data: Dictionary
var mission_ended: bool = false


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
	_on_objective_changed(GameManager.defeated_enemies, GameManager.required_enemies)


func _on_objective_changed(_defeated: int, _required: int) -> void:
	if is_instance_valid(portal):
		portal.set_active(GameManager.is_objective_complete())


func _on_player_died() -> void:
	if mission_ended:
		return
	mission_ended = true
	GameManager.finish_run(false)
	hud.show_game_over()


func _on_portal_entered() -> void:
	if mission_ended or not GameManager.is_objective_complete():
		return
	mission_ended = true
	SaveManager.complete_level(GameManager.current_level_id, GameManager.coin)
	GameManager.finish_run(true)
	var campaign_complete := str(level_data.get("next_level", "")).is_empty()
	hud.show_level_complete(campaign_complete)
