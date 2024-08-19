extends CharacterBody2D

@export var player: CharacterBody2D
@export var speed: float = 200.0
func _physics_process(delta: float) -> void:
	return
	#var trajectory = move_toward(global_position, player.global_position, delta)
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	#move_and_collide()
