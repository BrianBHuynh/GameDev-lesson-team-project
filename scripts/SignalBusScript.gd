extends Node2D
class_name SignalManager

@export var active : bool = true

signal group_signal

func emit_group_signal():
	if active == true:
		group_signal.emit()
