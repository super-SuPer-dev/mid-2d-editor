extends CharacterBody2D

@export var speed = 200
@export var jump_velocity: float = -400.0
@export var is_god_mode : bool = false

var in_ui : bool = false

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	GameManager.god_mode_changed.connect(func(mode): is_god_mode = mode) # for debuging via player node in editor!
	GameManager.disable_player_movement.connect(func(_m): in_ui = !in_ui)
	if is_god_mode: GameManager.toggle_god_mode(is_god_mode)


func hit():
	print("Hit!")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("run") and is_god_mode:
		speed = 800
	elif event.is_action_released("run") and is_god_mode:
		speed = 200
	elif event.is_action_pressed("god"):
		GameManager.toggle_god_mode()
		handle_god_mode()
	elif event.is_action_pressed("debug_key"):
		GameManager.toggle_debug_mode()
		
	elif event.is_action_pressed("interact") and current_interactable != null:
		if current_interactable.has_method("interact"):
			current_interactable.interact()
			
	elif event.is_action_pressed("attack") and !in_ui:
		$AnimationPlayer.play("attack")


func handle_god_mode() -> void:
	if is_god_mode:
		$CollisionShape2D.disabled = true
	elif !is_god_mode:
		$CollisionShape2D.disabled = false


func handle_movement(delta):
	if in_ui:
		handle_gravity(delta)
		velocity.x = move_toward(velocity.x, 0, speed)
		return
	if is_god_mode:
		var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if input_direction:
			velocity = input_direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.y = move_toward(velocity.y, 0, speed)
	else:
		handle_gravity(delta)
		handle_jump()
		
		var input_direction = Input.get_axis("move_left", "move_right")
		if input_direction:
			velocity.x = input_direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)


func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta


func handle_jump():
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

var current_interactable = null

func _on_interaction_area_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("interact"):
		current_interactable = area.get_parent()
		current_interactable.toggle_show_interact()


func _on_interaction_area_area_exited(area: Area2D) -> void:
	if area.get_parent() == current_interactable:
		current_interactable.toggle_show_interact()
		current_interactable = null


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Enemy"):
		area.get_parent().take_damage()
