extends Marker2D



@export var next_level: PackedScene
@onready var finish_area_2d: Area2D = $FinishArea2D

const CIRCLE_TRANSITION = preload("res://scenes/scene_transitions/circle_transition.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	finish_area_2d.body_entered.connect(_on_player_finished)
	pass

func _on_player_finished(player: CharacterBody2D):
	var tween = get_tree().create_tween()
	tween.tween_property(player, "scale", player.scale * 0.01, 1)
	#tween.tween_property(player, "rotation", PI, 1)d
	player.process_mode = Node.PROCESS_MODE_DISABLED
	
	SceneTransitionManager.change_scene_with_transition(next_level, CIRCLE_TRANSITION)
	#get_tree().change_scene_to_packed.call_deferred(next_level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
