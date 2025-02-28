extends CharacterBody2D
class_name Enemy


const SPEED = 50
const JUMP_VELOCITY = 5
var MAX_HEALTH = 999
var HEALTH = 999
var ATTACK = 5
var KILL_COOLDOWN = 10
var kill_t : int = 0
signal enemy_defeated
@onready var HealthBar = $ProgressBar

func death(): 
	enemy_defeated.emit()
	self.queue_free()

func _physics_process(delta: float) -> void:	
	# Stops game from crashing bc the player is not dead
	if GlobalVars.player != null:
		var direction = position.direction_to(GlobalVars.player.position) 
		var distance = position.distance_to(GlobalVars.player.position)
	
		#kill_player()
		
		HealthBar.value = (HEALTH * 100) / MAX_HEALTH
		HealthBar.min_value
		# Add the gravity.
		if not is_on_floor():
			pass
		# Death o maidenless
		if HEALTH < 0: 
			death()
			
		if direction && SPEED == 0: 
			GlobalVars.player.heatlh = ATTACK - GlobalVars.player.health
		
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		
		if direction && distance > 15:
			velocity.x = direction.x * SPEED
			velocity.y = direction.y * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if GlobalVars.player.position.x < position.x:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
			
		# Animation for being idle and running depending on distance from player 
		if distance <= 15:
			$AnimatedSprite2D.play("idle")
		else: 
			$AnimatedSprite2D.play("run")
		move_and_slide()

func kill_player():
	if GlobalVars.player != null and position.distance_to(GlobalVars.player.position) < 20:
		GlobalVars.player.health = GlobalVars.player.health - 0.1
