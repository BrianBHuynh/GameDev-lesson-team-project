extends Button

var save_dictionary : Dictionary

func _ready():
	visible = false

func _input(event):
	if Input.is_action_just_pressed("Menu"):
		visible = !visible

func _on_pressed():
	if visible == true:
		if Saves.is_node_ready():
			Saves.save_game()
