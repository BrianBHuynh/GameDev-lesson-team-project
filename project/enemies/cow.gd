extends Enemy
class_name Cow

# Make this similar to the Chicken, but instead, have it charge at the player.

var charging = false
var timer = Timer.new()

func _physics_process(_delta: float) -> void:
	cow_movement()

func charge():
	charging = true
	var tween = create_tween()
	
	var distance = global_position.distance_to(GlobalVars.player.global_position)
	var direction = global_position.direction_to(GlobalVars.player.global_position)
	
	var playerx = distance * direction + GlobalVars.player.global_position
	tween.tween_property(self, "position", playerx, 0.5)
	
	await get_tree().create_timer(3.0).timeout
	print("Cow Charging")
	charging = false
	
func cow_movement():
	move_and_slide()
	if GlobalVars.player != null:
		var direction = global_position.direction_to(GlobalVars.player.global_position) 
		var distance = global_position.distance_to(GlobalVars.player.global_position)
	
		kill_player()
		
		HealthBar.value = (HEALTH * 100.0) / MAX_HEALTH
		# Add the gravity.
		if not is_on_floor():
			pass
		# Death o maidenless
		if HEALTH <= 0: 
			death()
		
		# Ayo - what is this?
		if charging == false and distance < 50:
				charge()
		if distance < 15:
			GlobalVars.player.health = GlobalVars.player.health - ATTACK
		
		#Move to Player
		if direction && distance > 15:
			velocity.x = direction.x * (SPEED / 4.0)
			velocity.y = direction.y * (SPEED / 4.0)
		else:
			velocity.x = move_toward(velocity.x, 0, (SPEED / 4.0))
		
		if GlobalVars.player.global_position.x < global_position.x:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
			
		# Animation for being idle and running depending on distance from player 
		move_and_slide()
		
