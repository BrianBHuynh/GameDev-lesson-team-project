
extends Node2D

@export var chicken_scene: PackedScene
@export var cow_scene: PackedScene 
var EnemyLinks: Array = ["res://project/enemies/cow.tscn", "res://project/enemies/chicken.tscn","res://project/enemies/dino.tscn"]

func _ready() -> void: 
	
	RoundManager.spawnerList.append(self)
	print(RoundManager.spawnerList)
	await get_tree().process_frame
	spawn_enemies()

func spawn_enemies() -> void:
	var enemy: CharacterBody2D = load(EnemyLinks.pick_random()).instantiate()
	get_tree().root.add_child(enemy)
	enemy.global_position = global_position
	
	
