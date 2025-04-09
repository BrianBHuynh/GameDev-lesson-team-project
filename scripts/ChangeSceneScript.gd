extends Node2D
class_name SceneChanger

@export_file(".tscn") var change_scene : String

func set_scene_to_change_to(new_scene : String):
	change_scene = new_scene

func switch_to_scene():
	RoundManager.reset()
	get_tree().change_scene_to_file(change_scene)
