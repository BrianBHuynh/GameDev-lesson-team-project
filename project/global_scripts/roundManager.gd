extends Node2D

var current_wave = 1
var end_wave = -1
@export var chicken_scene: PackedScene
@export var cow_scene: PackedScene

var starting_nodes: int 
var enemies: Array = []
var current_nodes: int
var wave_spawn_ended
var spawnerList: Array = []
var sceneTeleportList : Array = []


func _ready() -> void: 
	
	current_wave = 1
	GlobalVars.current_wave = current_wave
	starting_nodes = get_child_count()
	current_nodes = get_child_count()
	position_to_next_wave()

func reset() -> void:
	enemies = []
	spawnerList = []

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
			for i in sceneTeleportList:
				if i != null:
					i.activate()

func currentRound() -> void: 
	
	pass
	
func nextRound() -> void: 
	
	
	pass
