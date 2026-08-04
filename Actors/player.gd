extends CharacterBody2D

@export var speed = 200
@export var god_mode : bool = false

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("run") and god_check():
		speed = 800
	elif event.is_action_released("run") and god_check():
		speed = 200
	elif event.is_action_pressed("god"):
		god_mode = !god_mode
		god_check()

func _ready() -> void:
	god_check()

func god_check() -> bool:
	if god_mode:
		$CollisionShape2D.disabled = true
	elif !god_mode:
		$CollisionShape2D.disabled = false
	return god_mode

func _physics_process(_delta):
	get_input()
	move_and_slide()
	if velocity.x < 0:
		$Icon.flip_h = true
	elif velocity.x > 0:
		$Icon.flip_h = false
