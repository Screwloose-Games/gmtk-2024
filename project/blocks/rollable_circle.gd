extends RigidBody2D

@export var max_velocity: float = 30.0

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
		# Clamp the velocity
	if abs(linear_velocity.x) > max_velocity:
		#linear_velocity = linear_velocity.normalized() * max_velocity
		linear_velocity.x = max_velocity * sign(linear_velocity.x)
