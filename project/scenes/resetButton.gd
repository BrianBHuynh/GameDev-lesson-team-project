extends Button


func _on_pressed() -> void:
	
	get_tree().change_scene_to_file("res://project/scenes/main.tscn")
	RoundManager.current_wave = 1
