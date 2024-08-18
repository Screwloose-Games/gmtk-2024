extends Marker2D



@export var next_level: PackedScene
@onready var finish_area_2d: Area2D = $FinishArea2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	finish_area_2d.body_entered.connect(_on_player_finished)
	pass

func _on_player_finished(player: CharacterBody2D):
	get_tree().change_scene_to_packed.call_deferred(next_level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
