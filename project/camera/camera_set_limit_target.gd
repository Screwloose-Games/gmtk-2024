extends Node

@export var camera: PhantomCamera2D

var camera_limit_target: CollisionShape2D # = get_tree().get_first_node_in_group("CameraLimitCollision")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if camera == null:
		camera = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if camera_limit_target == null:
		camera_limit_target = get_tree().get_first_node_in_group("CameraLimitCollision")
		var camera_limit_path = camera_limit_target.get_path()
		camera.set_limit_target(camera_limit_path)
