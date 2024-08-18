extends Node

@export var scale_target: Node2D
@export var scale_levels: Array[float] = [0.25, 0.5, 1.0, 2.0, 4.0]

signal scaled(amount: float)

var current_scale_index: int = 1:
	set = set_scale_index
func set_scale_index(val: int):
	current_scale_index = val
	scale_target.scale_amount = current_scale
	scaled.emit(current_scale)

var current_scale: float:
	get: return scale_levels[current_scale_index]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func scale_up():
	current_scale_index = min(current_scale_index + 1, scale_levels[scale_levels.size() - 1])

func scale_down():
	current_scale_index = max(current_scale_index - 1, 0)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("scale_player_up"):
		scale_up()
	elif event.is_action_pressed("scale_player_down"):
		scale_down()
