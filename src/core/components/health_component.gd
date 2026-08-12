class_name HealthComponent
extends Node

signal health_changed(current_health: int, maximum_health: int)
signal damaged(amount: int)
signal healed(amount: int)
signal died

@export_range(1, 100000, 1) var max_health: int = 5

var current_health: int


func _ready() -> void:
	current_health = max_health
	health_changed.emit(current_health, max_health)


func take_damage(amount: int) -> bool:
	if amount <= 0 or is_dead():
		return false

	var previous_health := current_health
	current_health = maxi(current_health - amount, 0)
	var applied_damage := previous_health - current_health
	damaged.emit(applied_damage)
	health_changed.emit(current_health, max_health)

	if is_dead():
		died.emit()
	return true


func heal(amount: int) -> bool:
	if amount <= 0 or is_dead() or current_health == max_health:
		return false

	var previous_health := current_health
	current_health = mini(current_health + amount, max_health)
	healed.emit(current_health - previous_health)
	health_changed.emit(current_health, max_health)
	return true


func reset() -> void:
	current_health = max_health
	health_changed.emit(current_health, max_health)


func is_dead() -> bool:
	return current_health <= 0
