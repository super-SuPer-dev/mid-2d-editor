extends CharacterBody2D

@export var HP : int = 5

@onready var hp_bar = $Node2D/ProgressBar

func _ready() -> void:
	hp_bar.max_value = HP
	hp_bar.value = HP

func take_damage(value = null):
	if value == null: value = 1
	if (HP - value) <= 0:
		queue_free()
	HP -= value
	hp_bar.value = HP
	print(HP)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
