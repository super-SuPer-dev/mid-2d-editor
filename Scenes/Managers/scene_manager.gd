extends CanvasLayer


func load_scene(_scene: String):
	pass


func load_scene_without_transition(scene: String):
	get_tree().change_scene_to_file(scene)
