extends Enemy
class_name Chicken 
#Make this thing walk towards the player and and follow them around
#Give them the ability to run for small periods of time (stamina mechanic?)
#Give them a health value that can be decremented and will destroy them when < 0.0
#Animate it!
var Activated = false
var ActivatedSummon = false
var attacking = false

func _ready() -> void: 
	super._ready()
	HEALTH = 200
	ATTACK = 10

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
		if distance < 20 && not attacking: 
			$AnimatedSprite2D.play("attack")
			GlobalVars.player.health = GlobalVars.player.health - ATTACK
			attacking = true
			await get_tree().create_timer(2).timeout
			attacking = false
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		
	
		
		if GlobalVars.player.global_position.x < global_position.x:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		
		
		# Animation for being idle and running depending on distance from player
		#print("Distance = " + str(distance))
		#print("activated = " + str(Activated))
		if distance >= 100 && !Activated and !attacking:
			$AnimatedSprite2D.play("idle")
			velocity = Vector2(0, 0)
		elif !Activated and !attacking: 
			$AnimatedSprite2D.play("summon_1")
			velocity = Vector2(0, 0)
			await get_tree().create_timer(3).timeout
			Activated = true
			
		elif Activated and !attacking:
			$AnimatedSprite2D.play("run")
			velocity.x = direction.x * SPEED
			velocity.y = direction.y * SPEED
		move_and_slide()
