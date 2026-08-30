class_name EncounterGate
extends Node2D

signal encounter_started(encounter_id: String)
signal encounter_cleared(encounter_id: String)

@export var encounter_id: String = ""
@export var enemy_paths: Array[NodePath] = []
@export var trigger_offset := Vector2(-320.0, 70.0)
@export var trigger_size := Vector2(640.0, 500.0)
@export var barrier_size := Vector2(18.0, 420.0)
@export var barrier_color := Color("ef8f62")

@onready var trigger: Area2D = $Trigger
@onready var trigger_shape: CollisionShape2D = $Trigger/CollisionShape2D
@onready var barrier: StaticBody2D = $Barrier
@onready var barrier_shape: CollisionShape2D = $Barrier/CollisionShape2D

var assigned_enemies: Array[EnemyController] = []
var started := false
var cleared := false


func _ready() -> void:
	var trigger_rectangle := RectangleShape2D.new()
	trigger_rectangle.size = trigger_size
	trigger_shape.shape = trigger_rectangle
	trigger.position = trigger_offset
	trigger.collision_layer = 0
	trigger.collision_mask = 2
	var barrier_rectangle := RectangleShape2D.new()
	barrier_rectangle.size = barrier_size
	barrier_shape.shape = barrier_rectangle
	trigger.body_entered.connect(_on_trigger_body_entered)
	call_deferred("_initialize_encounter")
	queue_redraw()


func _initialize_encounter() -> void:
	for enemy_path in enemy_paths:
		var enemy := get_node_or_null(enemy_path) as EnemyController
		if enemy == null:
			push_error("Encounter %s cannot resolve enemy path %s." % [encounter_id, enemy_path])
			continue
		assigned_enemies.append(enemy)
		enemy.defeated_event.connect(_on_enemy_defeated)
		enemy.set_combat_active(false)


func start_encounter() -> void:
	if started or cleared:
		return
	started = true
	trigger.set_deferred("monitoring", false)
	for enemy in assigned_enemies:
		if is_instance_valid(enemy) and not enemy.defeated:
			enemy.set_combat_active(true)
	encounter_started.emit(encounter_id)
	queue_redraw()


func _on_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		start_encounter()


func _on_enemy_defeated(_enemy: EnemyController) -> void:
	if not started:
		return
	for enemy in assigned_enemies:
		if is_instance_valid(enemy) and not enemy.defeated:
			return
	_clear_encounter()


func _clear_encounter() -> void:
	if cleared:
		return
	cleared = true
	barrier_shape.set_deferred("disabled", true)
	encounter_cleared.emit(encounter_id)
	queue_redraw()


func _draw() -> void:
	if cleared:
		return
	var half_height := barrier_size.y * 0.5
	for offset in [-6.0, 0.0, 6.0]:
		var alpha := 0.28 if not is_zero_approx(offset) else 0.9
		var color := Color(barrier_color, alpha)
		draw_line(Vector2(offset, -half_height), Vector2(offset, half_height), color, 3.0)
	for y in range(int(-half_height), int(half_height) + 1, 34):
		draw_circle(Vector2.ZERO + Vector2(0.0, float(y)), 4.0, barrier_color)
