extends Area2D

signal player_entered
signal player_exited

var in_bounds : bool = false

func _on_area_entered(area):
	if area == GlobalVars.player.hitbox:
		player_entered.emit()
		in_bounds = true

func _on_area_exited(area):
	if area == GlobalVars.player.hitbox:
		player_exited.emit()
		in_bounds = false
