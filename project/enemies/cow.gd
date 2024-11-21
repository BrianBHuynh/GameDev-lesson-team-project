extends CharacterBody2D

# Make this similar to the Chicken, but instead, have it charge at the player.
var SPEED = 50
const JUMP_VELOCITY = 5
var MAX_HEALTH = 999
var HEALTH = 999
var ATTACK = 5
var charging = false

@onready var HealthBar = $ProgressBar

func death():
	self.free()

func _physics_process(delta: float) -> void:
	# Stops game from crashing bc the player is not dead
	if GlobalVars.player != null:
		
		var direction = position.direction_to(GlobalVars.player.position) 
		var distance = position.distance_to(GlobalVars.player.position)
	
		charge(direction)
		
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
		$AnimatedSprite2D.play("move_right")
		move_and_slide()

func kill_player():
	if GlobalVars.player != null and position.distance_to(GlobalVars.player.position) < 20:
		GlobalVars.player.health = GlobalVars.player.health - 0.5
		
func charge(direction):
	charging = true
	if GlobalVars.player != null and position.distance_to(GlobalVars.player.position) < 30:
		direction = position.direction_to(GlobalVars.player.position)
		SPEED = 100
		kill_player()
