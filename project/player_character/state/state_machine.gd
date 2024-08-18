extends Node
class_name StateMachine

var state: State

@export var starting_state: State
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if state:
		state.update(delta)
