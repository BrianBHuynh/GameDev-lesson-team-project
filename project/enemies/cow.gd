extends Enemy
class_name Cow

# Make this similar to the Chicken, but instead, have it charge at the player.

var charging = false
var timer = Timer.new()

func _physics_process(delta: float) -> void:
	# Stops game from crashing bc the player is not dead
	if GlobalVars.player.global_position.distance_to(global_position) < 20:
		death()
	cow_movement()
		
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
	
func cow_movement():
	move_and_slide()
