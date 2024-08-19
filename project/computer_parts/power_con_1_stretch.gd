@tool
extends NinePatchRect

@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D

@onready var collision_width: float = size.x
@onready var collision_x_middle: float = collision_width / 2
@onready var sprite_x_middle: float = size.x / 2 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var new_collision_shape = collision_shape_2d.duplicate(0)
	var new_collision_shape_shape = collision_shape_2d.shape.duplicate(0)
	new_collision_shape.shape = new_collision_shape_shape
	collision_x_middle = collision_width / 2
	new_collision_shape.shape.size.x = collision_width
	new_collision_shape.position.x = sprite_x_middle
	collision_shape_2d.replace_by(new_collision_shape)
	#collision_shape_2d.shape.size.x = collision_width
	#collision_shape_2d.global_position.x = sprite_x_middle
	#collision_shape_2d.global_position = 
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
