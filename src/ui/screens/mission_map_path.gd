extends Control

const MAP_POINTS := [
	Vector2(0.15, 0.56),
	Vector2(0.31, 0.42),
	Vector2(0.55, 0.42),
	Vector2(0.70, 0.62),
	Vector2(0.88, 0.52),
]

var unlocked_count: int = 1


func _ready() -> void:
	resized.connect(queue_redraw)
	queue_redraw()


func set_unlocked_count(value: int) -> void:
	unlocked_count = value
	queue_redraw()


func _draw() -> void:
	for segment in range(MAP_POINTS.size() - 1):
		var start: Vector2 = MAP_POINTS[segment] * size
		var finish: Vector2 = MAP_POINTS[segment + 1] * size
		var color := Color("e8d89a") if segment < unlocked_count - 1 else Color("71694e")
		for dot in range(1, 12):
			var point := start.lerp(finish, float(dot) / 12.0)
			draw_circle(point, 3.5, Color(0.08, 0.07, 0.04, 0.65))
			draw_circle(point, 2.4, color)
