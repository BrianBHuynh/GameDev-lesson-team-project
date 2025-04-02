extends Node2D

@onready var scene_changer = $SceneChanger
@onready var activation_signal = $ActivationSignalManager

@export_file(".tscn") var teleport_scene : String

func _ready():
	scene_changer.set_scene_to_change_to(teleport_scene)
	RoundManager.sceneTeleportList.append(self)

func activate():
	activation_signal.emit_group_signal()
