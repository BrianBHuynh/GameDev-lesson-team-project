extends Node2D

@export var target_node_path : NodePath
var target_node : Node2D

static var teleport_active : bool = false

func _ready():
	target_node = get_node(target_node_path)

func teleport():
	if teleport_active == false:
		teleport_active = true
		
		GlobalVars.main_ui.screen_flash(Color.TRANSPARENT, Color.WHITE, 0.25)
		await GlobalVars.main_ui.screen_flash_finished
		
		GlobalVars.player.global_position = target_node.global_position
		
		GlobalVars.main_ui.screen_flash(Color.WHITE, Color.TRANSPARENT, 0.25)
		await GlobalVars.main_ui.screen_flash_finished
		
		teleport_active = false
