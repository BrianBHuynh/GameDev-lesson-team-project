extends Node2D

var current_wave = 1
@export var chicken_scene: PackedScene
@export var cow_scene: PackedScene

var starting_nodes: int 
var enemies: Array = []
var current_nodes: int
var wave_spawn_ended
var spawnerList: Array = []


func _ready() -> void: 
	
	current_wave = 0
	GlobalVars.current_wave = current_wave
	starting_nodes = get_child_count()
	current_nodes = get_child_count()
	position_to_next_wave()
	
	pass

func _process(delta: float) -> void:
	if(enemies.is_empty()):
		print("Round Over")
		position_to_next_wave()

func position_to_next_wave():
	if current_nodes == starting_nodes:
		current_wave += 1
		for spawner in spawnerList:
			spawner.spawn_enemies()

func currentRound() -> void: 
	
	pass
	
func nextRound() -> void: 
	
	
	pass
