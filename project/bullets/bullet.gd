extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	move_and_slide()

func _on_area_2d_body_entered(body: Enemy) -> void:
		body.HEALTH = body.HEALTH - 50
		queue_free()
