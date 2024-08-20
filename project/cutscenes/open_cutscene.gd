extends Control

@onready var finally: Label = %Finally
@onready var huge: RichTextLabel = %Huge
@onready var little: RichTextLabel = %Little
@onready var bang: RichTextLabel = %Bang
@onready var oh_no: Label = %OhNo
@onready var felicity: Node2D = %Felicity
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer

const _01 = preload("res://levels/campaign/01.tscn")
const CIRCLE_TRANSITION = preload("res://scenes/scene_transitions/circle_transition.tscn")

signal next

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	felicity.play("Idle")
	felicity.play_overlapping("Adjustglasses")
	pass # Replace with function body.
	play_sequence()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		next.emit()

func display(node):
	pass

func play_sequence():
	finally.show()
	await next
	finally.hide()
	huge.show()
	await next
	huge.hide()
	little.show()
	await next
	little.hide()
	bang.show()
	audio_stream_player.play()
	await next
	var tween = get_tree().create_tween()
	var new_scale = felicity.scale * 0.01
	var new_position_y = felicity.global_position.y - 390
	var new_position = Vector2(felicity.global_position.x, new_position_y)
	tween.tween_property(felicity, "scale", new_scale, 5)
	tween.parallel().tween_property(felicity, "global_position", new_position, 5)
	bang.hide()
	oh_no.show()
	await next
	SceneTransitionManager.change_scene_with_transition(_01, CIRCLE_TRANSITION)
	#get_tree().change_scene_to_packed(_01)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
