extends Node2D

@export_file(".tscn") var new_scene : String

func change_scene():
	get_tree().change_scene_to_file(new_scene)
