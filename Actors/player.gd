extends CharacterBody2D

@export var speed = 200
@export var jump_velocity: float = -400.0
@export var is_god_mode : bool = false

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	GameManager.god_mode_changed.connect(func(mode): is_god_mode = mode) # for debuging via player node in editor!
	if is_god_mode: GameManager.toggle_god_mode(is_god_mode)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("run") and is_god_mode:
		speed = 800
		#GameManager.debug("Run!")
	elif event.is_action_released("run") and is_god_mode:
		speed = 200
	elif event.is_action_pressed("god"):
		GameManager.toggle_god_mode()
		handle_god_mode()
	elif event.is_action_pressed("debug_key"):
		GameManager.toggle_debug_mode()


func handle_god_mode() -> void:
	if is_god_mode:
		$CollisionShape2D.disabled = true
	elif !is_god_mode:
		$CollisionShape2D.disabled = false


func handle_movement(delta):
	if is_god_mode:
		var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if input_direction:
			velocity = input_direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.y = move_toward(velocity.y, 0, speed)
	else:
		handle_jump(delta)
		var input_direction = Input.get_axis("move_left", "move_right")
		if input_direction:
			velocity.x = input_direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)


func handle_jump(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = jump_velocity


func flip_spite2d():
	if velocity.x < 0:
		$Icon.flip_h = true
	elif velocity.x > 0:
		$Icon.flip_h = false


func _physics_process(delta):
	handle_movement(delta)
	move_and_slide()
	flip_spite2d()
