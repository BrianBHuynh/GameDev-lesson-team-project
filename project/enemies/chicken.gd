extends Enemy
class_name Chicken 
#Make this thing walk towards the player and and follow them around
#Give them the ability to run for small periods of time (stamina mechanic?)
#Give them a health value that can be decremented and will destroy them when < 0.0
#Animate it!

func _physics_process(delta: float) -> void:	
	# Stops game from crashing bc the player is not dead
	super(delta)

func kill_player():
	if GlobalVars.player != null and position.distance_to(GlobalVars.player.position) < 20:
		GlobalVars.player.health = GlobalVars.player.health - 0.1
