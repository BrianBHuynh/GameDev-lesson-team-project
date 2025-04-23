extends Node2D

@export var end_wave : int = 3

func _ready():
	RoundManager.end_wave = end_wave
