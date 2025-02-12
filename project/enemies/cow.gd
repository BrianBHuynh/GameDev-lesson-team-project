extends Enemy
class_name Cow

# Make this similar to the Chicken, but instead, have it charge at the player.

var charging = false
var timer = Timer.new()

func death():
	self.free()

func _physics_process(delta: float) -> void:
	# Stops game from crashing bc the player is not dead
	if GlobalVars.player != null:
		
		var direction = position.direction_to(GlobalVars.player.position) 
		var distance = position.distance_to(GlobalVars.player.position)
		
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
		
		
		if GlobalVars.player.position.x < position.x:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		
		if position.distance_to(GlobalVars.player.position) < 50 and not charging:
			charge()

func kill_player():
	if GlobalVars.player != null and position.distance_to(GlobalVars.player.position) < 20:
		GlobalVars.player.health = GlobalVars.player.health - 0.5
		
func charge():
	charging = true
	var tween = create_tween()
	
	var distance = position.distance_to(GlobalVars.player.position)
	var direction = position.direction_to(GlobalVars.player.position)
	
	var playerx = distance * direction
	tween.tween_property($AnimatedSprite2D, "position", playerx, 0.5)
	
	await get_tree().create_timer(3.0).timeout
	print("Cow Charging")
	charging = false
