extends Node2D

@onready var main_animations: AnimationPlayer = %MainAnimations
@onready var overlapping_animations: AnimationPlayer = %OverlappingAnimations

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("Walk Right")

func play(animation_name: String):
	main_animations.play(animation_name)

func play_overlapping(animation_name: String):
	overlapping_animations.play(animation_name)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
