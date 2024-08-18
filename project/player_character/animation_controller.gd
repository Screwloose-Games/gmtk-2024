extends Node

@onready var player_controller: CharacterBody2D = $".."
@onready var felicity: Node2D = $"../Flippable/Felicity"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_controller.jumped.connect(_on_player_jumped)


func _on_player_jumped():
	felicity.play("jump")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
