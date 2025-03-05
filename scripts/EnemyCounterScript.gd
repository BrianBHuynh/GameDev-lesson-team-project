extends Counter
class_name EnemyCounter

@export var enemy_parent : Node2D

func connect_enemies():
	value = 0
	for i in enemy_parent.get_children():
		if i.has_signal("enemy_defeated"):
			value += 1
			i.connect("enemy_defeated", decriment)

func _ready():
	connect_enemies()
