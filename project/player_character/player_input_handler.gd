extends Node

@onready var state_machine: StateMachine = %StateMachine
@onready var jump_state: JumpState = %JumpState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	return
	update_body()
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		state_machine.change_state(jump_state)

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "ui_up", "ui_down")
	return input_direction

func update_body():
	var input_direction = get_input()
