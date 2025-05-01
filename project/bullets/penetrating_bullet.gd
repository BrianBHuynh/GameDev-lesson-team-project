extends Node2D

@export var damage : int = 10
var velocity : Vector2
const PHYSICS_FRAMES_PER_SECOND : int = 60

func _physics_process(_delta: float) -> void:
	global_position += velocity / PHYSICS_FRAMES_PER_SECOND

func _on_bullet_area_body_entered(body):
	if body is Enemy:
		body.HEALTH = body.HEALTH - damage
		await get_tree().create_timer(.25).timeout
		queue_free()
