extends Enemy
class_name CreepyChicken 
#Make this thing walk towards the player and and follow them around
#Give them the ability to run for small periods of time (stamina mechanic?)
#Give them a health value that can be decremented and will destroy them when < 0.0
#Animate it!

func _physics_process(delta: float) -> void:	
	chicken_movement()

func chicken_movement():
	# Stops game from crashing bc the player is not dead
	if GlobalVars.player != null:
		var direction = global_position.direction_to(GlobalVars.player.global_position) 
		var distance = global_position.distance_to(GlobalVars.player.global_position)
	
		kill_player()
		
		HealthBar.value = (HEALTH * 100) / MAX_HEALTH
		HealthBar.min_value
		# Add the gravity.
		if not is_on_floor():
			pass
		# Death o maidenless
		if HEALTH <= 0: 
			death()
		
		# Ayo - what is this?
		if distance < 15: 
			GlobalVars.player.health = GlobalVars.player.health - ATTACK
		
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
		
		if GlobalVars.player.global_position.x < global_position.x:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
			
		# Animation for being idle and running depending on distance from player 
		if distance <= 15:
			$AnimatedSprite2D.play("idle")
		else: 
			$AnimatedSprite2D.play("run")
		move_and_slide()
