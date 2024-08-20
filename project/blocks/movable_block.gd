extends RigidBody2D

@export var max_velocity: float = 30.0
@export var scale_amount: float = 1.0
	#set = set_scale_amount

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Node2D = $Node2D

func set_scale_amount(val: float):
	scale_amount = val
	if collision_shape_2d:
		collision_shape_2d.shape.size = collision_shape_2d.shape.size * scale_amount
		sprite_2d.scale = scale_amount * Vector2(1, 1)


func _ready() -> void:
	pass # Replace with function body.

#func _physics_process(delta: float) -> void:
		## Clamp the velocity
	#if linear_velocity.x > max_velocity:
		#linear_velocity.x = max_velocity
