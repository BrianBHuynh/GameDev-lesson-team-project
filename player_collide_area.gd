extends Area2D

signal player_entered
signal player_exited

@export var enter_active : bool = true

func activate_enter():
	enter_active = true

func deactivate_enter():
	enter_active = false

var in_bounds : bool = false

func _on_area_entered(area):
	if enter_active == true:
		if area == GlobalVars.player.CollisionShape2D:
			player_entered.emit()
			in_bounds = true

func _on_area_exited(area):
	if area == GlobalVars.player.CollisionShape2D:
		player_exited.emit()
		in_bounds = false
