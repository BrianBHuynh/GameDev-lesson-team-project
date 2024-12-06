extends Button

func _ready():
	visible = false

func _input(event):
	if Input.is_action_just_pressed("Menu"):
		visible = !visible

func _on_pressed():
	if visible == true:
		GlobalVars.player.global_position = Vector2.ZERO
