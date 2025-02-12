extends Node2D

@export var start_color : Color = Color(0,0,0,0)
@export var target_color : Color = Color(0,0,0,1)
@export var fade_time : float = 0.5

signal fade_finished

func screen_fade():
	GlobalVars.main_ui.screen_flash(start_color, target_color, fade_time)
	
	await get_tree().create_timer(fade_time, false).timeout
	
	fade_finished.emit()
