extends CharacterBody2D
#Make this thing walk as a top down character instead of as a platformer character (aka no gravity, up down left right)
#Give them the ability to run
#Add inputs via the Input manager (project -> project settings -> input manager) for up down left right (WASD, maybe arrow keys and maybe 
var health = 10
var maxHealth = 10
var SPEED = 100.0
var stamina = 100.0
var stamRest = false
const JUMP_VELOCITY = -400.0
var save_dictionary : Dictionary
var latestKey
func _ready() -> void:
	save_dictionary = await Saves.get_save_dictionary()
	GlobalVars.player = self
	
	#Setup
	global_position.x = save_dictionary.get_or_add("player_pose_x", 0)
	global_position.y = save_dictionary.get_or_add("player_pose_y", 0)
	print_debug("Loaded player at: " + str(global_position))

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Up"):
		latestKey = "Up"
	elif Input.is_action_just_pressed("Down"):
		latestKey = "Down"
	elif Input.is_action_just_pressed("Left"):
		latestKey = "Left"
	elif Input.is_action_just_pressed("Right"):
		latestKey = "Right"
	#Start of the Sprint && Stamina stuff
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
	
	$StaminaBar.value = stamina
	#End of the Sprint && Stamina stuff

	$ProgressBar.value = health * 100 / maxHealth
	
	if health < 0:
		queue_free()
		health = health - 1
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
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	move_and_slide()

	#Store pose in dictionary
	
	save_dictionary["player_pose_x"] = global_position.x
	save_dictionary["player_pose_y"] = global_position.y
