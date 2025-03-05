extends CharacterBody2D
class_name Enemy

const SPEED = 50
const JUMP_VELOCITY = 5
var MAX_HEALTH = 999
var HEALTH = 999
var ATTACK = 5
var KILL_COOLDOWN = 10
var KILL_T : int = 0

var level = 1 #Default level is 1

signal enemy_defeated
@onready var HealthBar = $ProgressBar

func death(): 
	enemy_defeated.emit()
	self.queue_free()

func kill_player():
	if GlobalVars.player != null and position.distance_to(GlobalVars.player.position) < 20:
		GlobalVars.player.health = GlobalVars.player.health - 0.1
		
