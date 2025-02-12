extends Node2D
class_name TargetedNode2D

@export var target_node_path : NodePath
var target_node : Node2D

func _ready():
	if target_node_path != null:
		target_node = get_node(target_node_path)
	else:
		target_node = self
