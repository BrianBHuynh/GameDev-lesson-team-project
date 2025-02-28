extends Node2D
class_name Counter

@export var value : int
@export var target_value : int

signal value_incremented
signal value_decrimented
signal value_changed
signal target_value_reached

func increment(inc_amount = 1):
	value += inc_amount
	value_incremented.emit()
	value_changed.emit()
	if value == target_value:
		target_value_reached.emit()

func decriment(dec_amount = 1):
	value -= dec_amount
	value_decrimented.emit()
	value_changed.emit()
	if value == target_value:
		target_value_reached.emit()
