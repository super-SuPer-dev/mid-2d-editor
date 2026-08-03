extends Node

func LoadScene(Scene: String):
	get_tree().change_scene_to_file(Scene)
