extends Node2D

@export var damage : int = 2
var velocity : Vector2
const PHYSICS_FRAMES_PER_SECOND : int = 60

func _physics_process(delta: float) -> void:
	global_position += velocity / PHYSICS_FRAMES_PER_SECOND

func _on_bullet_area_body_entered(body):
	if body is Enemy:
		body.HEALTH = body.HEALTH - damage
		queue_free()
