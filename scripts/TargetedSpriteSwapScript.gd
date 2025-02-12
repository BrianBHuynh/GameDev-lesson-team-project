extends TargetedNode2D
class_name TargetedSpriteSwaper

@export var new_sprite : Texture
var start_sprite

func _ready():
	super()
	start_sprite = target_node.texture

func apply_new_sprite():
	target_node.texture = new_sprite
	
func apply_start_sprite():
	target_node.texture = start_sprite
