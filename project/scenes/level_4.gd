extends Node2D

@export var end_wave : int = 4

func _ready():
	RoundManager.end_wave = end_wave
