extends Node2D

@export var bullet : PackedScene

func _on_player_collide_area_player_entered():
	GlobalVars.player.set_bullet_type(bullet)
	queue_free()
