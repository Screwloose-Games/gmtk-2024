extends State

class_name IdleState

@onready var animation_player = %Felicity/AnimationPlayer

#@onready var debugger: StateDebugger = %StateDebugger

func _init():
	machine = StateMachine.new()
	add_child(machine)

func enter_state(_data: Dictionary = {}):
	animation_player.play("idle")
	
	pass
	#if debugger:
		#debugger.states.append(self)

func update(delta):
	if not machine.state == null:
		machine.state.update(delta)

func exit_state():
	machine.change_state(null)
	#if debugger:
		#debugger.states.erase(self)
