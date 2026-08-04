extends Control

@onready var up_label : Label = $MoveUpBtn/Label
@onready var left_label : Label = $MoveLeftBtn/Label
@onready var down_label : Label = $MoveDownBtn/Label
@onready var right_label : Label = $MoveRightBtn/Label

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up"):
		set_move_up_visual(up_label, true)
	elif event.is_action_released("move_up"):
		set_move_up_visual(up_label, false)
	
	elif event.is_action_pressed("move_left"):
		set_move_up_visual(left_label, true)
	elif event.is_action_released("move_left"):
		set_move_up_visual(left_label, false)
		
	elif event.is_action_pressed("move_down"):
		set_move_up_visual(down_label, true)
	elif event.is_action_released("move_down"):
		set_move_up_visual(down_label, false)
	
	elif event.is_action_pressed("move_right"):
		set_move_up_visual(right_label, true)
	elif event.is_action_released("move_right"):
		set_move_up_visual(right_label, false)


func set_move_up_visual(label: Label, is_pressed: bool) -> void:
	if is_pressed:
		label.modulate = Color()
	else:
		label.modulate = Color(1.0, 1.0, 1.0, 1.0)

# MoveUp Button
func _on_move_up_btn_button_down() -> void:
	set_move_up_visual(up_label, true)
	Input.action_press("move_up")

func _on_move_up_btn_button_up() -> void:
	set_move_up_visual(up_label, false)
	Input.action_release("move_up")

# MoveLeft Button
func _on_move_left_btn_button_down() -> void:
	set_move_up_visual(left_label, true)
	Input.action_press("move_left")

func _on_move_left_btn_button_up() -> void:
	set_move_up_visual(left_label, false)
	Input.action_release("move_left")

# MoveDown Button
func _on_move_down_btn_button_down() -> void:
	set_move_up_visual(down_label, true)
	Input.action_press("move_down")

func _on_move_down_btn_button_up() -> void:
	set_move_up_visual(down_label, false)
	Input.action_release("move_down")

# MoveRight Button
func _on_move_right_btn_button_down() -> void:
	set_move_up_visual(right_label, true)
	Input.action_press("move_right")

func _on_move_right_btn_button_up() -> void:
	set_move_up_visual(right_label, false)
	Input.action_release("move_right")
