class_name CrystalPickup
extends Area2D

var time_alive: float = 0.0


func _process(delta: float) -> void:
	time_alive += delta
	rotation = sin(time_alive * 2.5) * 0.12
	position.y += sin(time_alive * 4.0) * 4.0 * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		AudioManager.play_named_sfx(&"pickup_sample", 1.0, -12.0)
		GameManager.add_coin(1)
		queue_free()
