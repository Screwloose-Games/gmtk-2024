extends Control

@onready var finally: Label = %Finally
@onready var huge: RichTextLabel = %Huge
@onready var little: RichTextLabel = %Little
@onready var bang: RichTextLabel = %Bang
@onready var oh_no: Label = %OhNo
@onready var felicity: Node2D = %Felicity
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer
@onready var to_be_continued: Label = $ToBeContinued


const _01 = preload("res://levels/campaign/01.tscn")
const CIRCLE_TRANSITION = preload("res://scenes/scene_transitions/circle_transition.tscn")

const MAIN_MENU = preload("res://scenes/samples/main_menu.tscn")

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
	await next
	SceneTransitionManager.change_scene_with_transition(MAIN_MENU, CIRCLE_TRANSITION)
	#get_tree().change_scene_to_packed(_01)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
