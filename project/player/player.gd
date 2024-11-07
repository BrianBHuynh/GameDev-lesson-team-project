extends CharacterBody2D
#Make this thing walk as a top down character instead of as a platformer character (aka no gravity, up down left right)
#Give them the ability to run
#Add inputs via the Input manager (project -> project settings -> input manager) for up down left right (WASD, maybe arrow keys and maybe 

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	GlobalVars.player = self

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		pass

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
