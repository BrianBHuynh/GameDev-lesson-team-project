extends Node2D
var shootable = true
var delay = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	look_at(get_global_mouse_position())
	if(delay < 15):
		delay = delay + 1
	if Input.is_action_just_pressed("attack"):
		process_attacking_delay()

func shoot():
	# Create a new instance of the Mob scene.
	var mob: Node2D = load("res://project/bullets/bullet.tscn").instantiate()
	get_tree().root.add_child(mob)
	mob.global_position = $muzzle.global_position
	mob.global_rotation = self.global_position.angle_to_point(get_global_mouse_position())
	mob.velocity = Vector2(50, 50) * self.global_position.direction_to(get_global_mouse_position())

func process_attacking_delay():
	if(shootable == true):
		shootable = false
		shoot()
	else:
		if delay >= 1.5:
			delay = 0
			shootable = true
