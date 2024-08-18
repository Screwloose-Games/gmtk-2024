class_name ActorCore
extends Node

@onready var actor: Actor = $".."


@onready var state_machine: StateMachine = %StateMachine
@onready var idle_state: IdleState = %IdleState
@onready var fall_state: FallState = %FallState
@onready var walk_state: WalkState = %WalkState
@onready var jump_state: JumpState = %JumpState


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	var direction := Input.get_axis("move_left", "move_right")

	if actor.is_on_floor():
		if direction:
			state_machine.change_state(walk_state)
		else:
			state_machine.change_state(idle_state)
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = jump_velocity
		#jumped.emit()
