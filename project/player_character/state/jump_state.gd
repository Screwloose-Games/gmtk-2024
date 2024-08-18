extends State

class_name JumpState

@onready var animation_player: AnimationPlayer = %Felicity/%MainAnimations
@onready var state_machine: StateMachine = %StateMachine
@onready var fall_state: FallState = %FallState


#@onready var debugger: StateDebugger = %StateDebugger

func _init():
	machine = StateMachine.new()
	add_child(machine)

func _on_jump_animation_finished(anim_name: String):
	if anim_name == "JumpUp":
		start_falling()

func start_falling():
	state_machine.change_state(fall_state)

func enter_state(_data: Dictionary = {}):
	animation_player.play("JumpUp")
	animation_player.animation_finished.connect(_on_jump_animation_finished)
	#Fall
#Idle
#JumpUp
#Land
#Push
#RESET
#Walk Right
#jump
	
	pass
	#if debugger:
		#debugger.states.append(self)

func update(delta):
	if not machine.state == null:
		machine.state.update(delta)

func exit_state():
	animation_player.stop()
	machine.change_state(null)
	animation_player.animation_finished.disconnect(_on_jump_animation_finished)
	#if debugger:
		#debugger.states.erase(self)
