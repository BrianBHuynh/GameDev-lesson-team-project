extends Node2D

@export var end_wave : int = 2

func _ready():
	RoundManager.end_wave = end_wave
