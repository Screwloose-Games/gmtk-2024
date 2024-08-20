extends CanvasLayer


signal dismissed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		hide()
		var player = get_tree().get_first_node_in_group("Player")
		player.process_mode = Node.PROCESS_MODE_INHERIT
		dismissed.emit()
		get_viewport().set_input_as_handled()
