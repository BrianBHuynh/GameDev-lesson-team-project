extends Node2D

var current_wave = 1
var end_wave = -1
var level_cleared : bool = false
@export var chicken_scene: PackedScene
@export var cow_scene: PackedScene

var starting_nodes: int 
var enemies: Array = []
var current_nodes: int
var wave_spawn_ended
var spawnerList: Array = []
var sceneTeleportList : Array = []

signal wave_changed

func _ready() -> void: 
	
	current_wave = 1
	GlobalVars.current_wave = current_wave
	starting_nodes = get_child_count()
	current_nodes = get_child_count()
	position_to_next_wave()

func reset() -> void:
	enemies = []
	spawnerList = []
	level_cleared = false

func _process(delta: float) -> void:
	if(enemies.is_empty() && spawnerList.size() > 0):
		print("Round Over")
		position_to_next_wave()

func position_to_next_wave():
	if end_wave >= 0:
		if current_wave < end_wave:
			#Next Wave
			if current_nodes == starting_nodes:
				current_wave += 1
				for i in current_wave:
					for spawner in spawnerList:
						spawner.spawn_enemies()
					for j in 5:
						await get_tree().process_frame
		else:
			#Finish
			level_cleared = true
			for i in sceneTeleportList:
				if i != null:
					i.activate()
		wave_changed.emit()

func currentRound() -> void: 
	
	pass
	
func nextRound() -> void: 
	
	
	pass
