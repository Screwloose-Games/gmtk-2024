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

func change_state(new_state: State, data: Dictionary = {}, force: bool = false):
	if state != null and new_state != null and force == true:
		state.exit_state()
		state = new_state
		state.enter_state(data)
	elif new_state == null and not state == null:
		state.exit_state()
		state = new_state
	elif state and state != new_state:
		state.exit_state()
		state = new_state
		state.enter_state(data)
	elif not state and new_state:
		state = new_state
		state.enter_state(data)
	#elif JSON.stringify(data) != JSON.stringify(prev_data) and new_state == state:
