extends CharacterBody2D
class_name Player

#Make this thing walk as a top down character instead of as a platformer character (aka no gravity, up down left right)
#Give them the ability to run
#Add inputs via the Input manager (project -> project settings -> input manager) for up down left right (WASD, maybe arrow keys and maybe 
var health = 25
var maxHealth = 25
var damage = 100
var attackable = true
var inRange: Array = []
var SPEED = 100.0
var stamina = 100.0
var stamRest = false
var rf = -1
var max_rf = 20
const JUMP_VELOCITY = -400.0
var save_dictionary : Dictionary
var latestKey
var arrayLeft = []
var arrayRight = []
var arrayUp = []
var arrayDown = []

func _ready() -> void:
	save_dictionary = await Saves.get_save_dictionary()
	GlobalVars.player = self
	print(health)
	print(GlobalVars.player.health)
	
	#Setup
	#global_position.x = save_dictionary.get_or_add("player_pose_x", 0)
	#global_position.y = save_dictionary.get_or_add("player_pose_y", 0)
	print_debug("Loaded player at: " + str(global_position))

func _physics_process(delta: float) -> void:
	if attackable == true and Input.is_action_pressed("attack"):
		attackable = false
		for enemies in inRange:
			enemies.HEALTH = enemies.HEALTH-damage
			print("Attacking")
		print("on cooldown")
		await get_tree().create_timer(2.0).timeout
		attackable = true
		print("off cooldown")
			
	if Input.is_action_just_pressed("Up"):
		latestKey = "Up"
	elif Input.is_action_just_pressed("Down"):
		latestKey = "Down"
	elif Input.is_action_just_pressed("Left"):
		latestKey = "Left"
	elif Input.is_action_just_pressed("Right"):
		latestKey = "Right"
#region Sprint, Dodge, and Stamina stuff

	if Input.is_action_pressed("Sprint") && !stamRest && stamina >= 0: #no infinite sprint
		SPEED = 150.0 #1.5 times the speed of the plc
		stamina = stamina - 2 #reduce stamina so plc can't sprint infinitely
	else: #handles release of SHIFT key
		SPEED = 100.0 #bring speed back to walking pace for plc
		if stamina <= 100: #don't go over 100
			stamina = stamina + 0.5 #increase by 2 so there is no infinite sprint capability,
							  	  #and so plc has to rest somewhat before they can sprint again
	
	if stamina < 5: #if plc sprints till almost no stamina left then force plc to only walk or stay still till
		stamRest = true #stamina is full again
	elif stamina >= 90:
		stamRest = false #handles case of stamina being full enough again, then allows plc to sprint again

	if Input.is_action_just_pressed("Dodge") && !stamRest && stamina > 30 && rf == -1 && !Input.is_action_pressed("Sprint"):
		rf = 0
		stamina = 30
	
	if rf > -1 && rf < max_rf && !stamRest && stamina > 30:
		rf += 1
		if(velocity.x < 0):
			$AnimatedSprite2D.rotate(-0.5)
		elif(velocity.x > 0):
			$AnimatedSprite2D.rotate(0.5)
		elif(velocity.y > 0 || velocity.y < 0):
			$AnimatedSprite2D.scale.y = cos(rf * 0.5)
		SPEED = 300
	elif rf >= max_rf:
		rf = -1
		$AnimatedSprite2D.rotation = 0
		$AnimatedSprite2D.scale.y = 1
		SPEED = 100
	$StaminaBar.value = stamina
#endregion

	$ProgressBar.value = health * 100 / maxHealth
	
	if health <= 0:
		for enemies in RoundManager.enemies:
			enemies.queue_free()
		RoundManager.reset()
		
		get_tree().change_scene_to_file("res://project/scenes/deathScreen.tscn")
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	velocity.y = 0
	velocity.x = 0
	
	if Input.is_action_pressed("Up"):
		velocity.y = -SPEED
	elif Input.is_action_pressed("Down"):
		velocity.y = velocity.y +SPEED
	if Input.is_action_pressed("Left"):
		velocity.x = -SPEED
	elif Input.is_action_pressed("Right"):
		velocity.x = velocity.x +SPEED
		
	
	if velocity.x == 0 and velocity.y == 0:
		if latestKey == "Up":
			$AnimatedSprite2D.play("idle_up")
		elif latestKey == "Down":
			$AnimatedSprite2D.play("idle_down")
		elif latestKey == "Right":
			$AnimatedSprite2D.play("idle_right")
		elif latestKey == "Left":
			$AnimatedSprite2D.play("idle_left")
			
	if velocity.x > 0: #Handles the case of plc pressing Up/Down
		$AnimatedSprite2D.play("walk_right") #&& Right buttons at the same time and plays the walk_right animation
	if velocity.x < 0: #Handles the case of plc pressing Up/Down
		$AnimatedSprite2D.play("walk_left") #&& Left buttons at the same time and plays the walk_left animation
	if velocity.x == 0 && velocity.y > 0: #Handles plc walking up
		$AnimatedSprite2D.play("walk_down")
	elif velocity.x == 0 && velocity.y < 0: #Handles plc walking down
		$AnimatedSprite2D.play("walk_up")
		
	velocity = velocity.normalized()*SPEED
	
	$Label.text = "Round " + str(RoundManager.current_wave)
  
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	move_and_slide()

	#Store pose in dictionary
	
	save_dictionary["player_pose_x"] = global_position.x
	save_dictionary["player_pose_y"] = global_position.y
	




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		print("CHICKEN")
		inRange.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	inRange.erase(body)

func on_right(body: Node2D) -> void:
	print("ON RIGHT")
	arrayRight.append(body)

func on_left(body: Node2D) -> void:
	print("ON LEFT")
	arrayLeft.append(body)

func on_up(body: Node2D) -> void:
	print("ON UP")
	arrayUp.append(body)

func on_down(body: Node2D) -> void:
	print("ON DOWN")
	arrayDown.append(body)


func on_left_exited(body: Node2D) -> void:
	arrayLeft.erase(body)


func on_right_exited(body: Node2D) -> void:
	arrayRight.erase(body)


func on_down_exited(body: Node2D) -> void:
	arrayDown.erase(body)


func on_up_exited(body: Node2D) -> void:
	arrayUp.erase(body)
