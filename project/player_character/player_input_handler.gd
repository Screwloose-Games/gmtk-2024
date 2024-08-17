extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_body()
	pass


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	return input_direction

func update_body():
	var input_direction = get_input()
