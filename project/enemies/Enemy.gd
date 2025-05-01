extends CharacterBody2D
class_name Enemy

var SPEED = 50
var JUMP_VELOCITY = 5
var MAX_HEALTH = 100
var HEALTH = 100
var ATTACK = 1
var KILL_COOLDOWN = 10
var KILL_T : int = 0
var enemies_ALIVE: Array; 

var level = 1 #Default level is 1

signal enemy_defeated
@onready var HealthBar = $ProgressBar

func _ready() -> void:
	RoundManager.enemies.append(self)

func death():
	#print("before" + str(RoundManager.enemies)) 
	RoundManager.enemies.erase(self)
	enemy_defeated.emit()
	#print(RoundManager.enemies)
	self.queue_free()
	

func kill_player():
	if GlobalVars.player != null and position.distance_to(GlobalVars.player.position) < 20:
		GlobalVars.player.health = GlobalVars.player.health - 0.1
