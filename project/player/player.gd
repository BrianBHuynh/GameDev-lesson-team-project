extends CharacterBody2D
#Make this thing walk as a top down character instead of as a platformer character (aka no gravity, up down left right)
#Give them the ability to run
#Add inputs via the Input manager (project -> project settings -> input manager) for up down left right (WASD, maybe arrow keys and maybe 
var health = 10
var maxHealth = 10
const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var latestKey
func _ready() -> void:
	GlobalVars.player = self

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Up"):
		latestKey = "Up"
	if Input.is_action_just_pressed("Down"):
		latestKey = "Down"
	if Input.is_action_just_pressed("Left"):
		latestKey = "Left"
	if Input.is_action_just_pressed("Right"):
		latestKey = "Right"
	
	
		

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
	if Input.is_action_pressed("Down"):
		velocity.y = velocity.y +SPEED
	if Input.is_action_pressed("Left"):
		velocity.x = -SPEED
	if Input.is_action_pressed("Right"):
		velocity.x = velocity.x +SPEED
		
	if velocity.x == 0 and velocity.y == 0:
		if latestKey == "Up":
			$AnimatedSprite2D.play("idle_up")
		if latestKey == "Down":
			$AnimatedSprite2D.play("idle_down")
		if latestKey == "Right":
			$AnimatedSprite2D.play("idle_right")
		if latestKey == "Left":
			$AnimatedSprite2D.play("idle_left")
	else:
		if latestKey == "Up":
			$AnimatedSprite2D.play("walk_up")
		if latestKey == "Down":
			$AnimatedSprite2D.play("walk_down")
		if latestKey == "Right":
			$AnimatedSprite2D.play("walk_right")
		if latestKey == "Left":
			$AnimatedSprite2D.play("walk_left")
			
		
		
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	move_and_slide()
