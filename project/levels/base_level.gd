class_name Level

extends Node2D

signal level_complete(level: Level)

@onready var finish_area_2d: Area2D = %FinishArea2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	finish_area_2d.body_entered.connect(_on_player_finished)
	pass # Replace with function body.

func _on_player_finished(player: CharacterBody2D):
	print("Level finished")
	level_complete.emit(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
