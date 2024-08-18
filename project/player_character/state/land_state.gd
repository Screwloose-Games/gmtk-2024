extends State

class_name LandState

@onready var main_animation_player: AnimationPlayer = %Felicity/%MainAnimations
@onready var player_input_handler: Node = %PlayerInputHandler

signal finished

#@onready var debugger: StateDebugger = %StateDebugger

func _init():
	machine = StateMachine.new()
	add_child(machine)

func _on_animation_finished(anim_name: String):
	if anim_name == "Land":
		finished.emit()

func enter_state(_data: Dictionary = {}):
	main_animation_player.play("Land")
	main_animation_player.animation_finished.connect(_on_animation_finished)
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
	main_animation_player.stop()
	main_animation_player.animation_finished.disconnect(_on_animation_finished)
	machine.change_state(null)
	#if debugger:
		#debugger.states.erase(self)
