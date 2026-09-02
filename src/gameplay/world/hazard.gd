class_name DamageHazard
extends Area2D

@export var damage: int = 2

@onready var _visual: Sprite2D = $Visual

var _animation_clock: float = 0.0
var _animation_fps: float = 0.0


func set_size(size: Vector2) -> void:
	var shape := RectangleShape2D.new()
	shape.size = size
	$CollisionShape2D.shape = shape
	_visual.scale = Vector2(size.x / 64.0, size.y / 20.0)


func set_animation_texture(texture: Texture2D, frame_count: int = 4, fps: float = 8.0) -> void:
	_visual.texture = texture
	_visual.hframes = maxi(frame_count, 1)
	_visual.vframes = 1
	_visual.frame = 0
	_visual.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	_visual.scale = Vector2(0.08, 0.08)
	_animation_clock = 0.0
	_animation_fps = fps


func _process(delta: float) -> void:
	if _animation_fps <= 0.0 or _visual.hframes <= 1:
		return
	_animation_clock = fmod(_animation_clock + delta * _animation_fps, float(_visual.hframes))
	_visual.frame = int(_animation_clock)


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		AudioManager.play_named_sfx(&"hazard_hit", 1.0, -14.0)
		body.take_damage(damage, Vector2(0.0, -1.0))
		if body.has_method("show_status_vfx"):
			body.show_status_vfx()
