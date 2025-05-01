extends Node2D
var shootable = true
var delay = 0

@export var bullet : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	look_at(get_global_mouse_position())
	if(delay > 0):
		delay -= 1
	if Input.is_action_pressed("attack") && delay <= 0:
		shoot()
	if $muzzle.global_position.x < GlobalVars.player.global_position.x:
		scale.y = -1
	else:
		scale.y = 1

func shoot():
	# Create a new instance of the Mob scene.
	var mob : Node2D = bullet.instantiate()
	get_tree().root.add_child(mob)
	mob.global_position = $muzzle.global_position
	mob.global_rotation = self.global_position.angle_to_point(get_global_mouse_position())
	mob.velocity = Vector2(200, 200) * self.global_position.direction_to(get_global_mouse_position())
	delay = 18
