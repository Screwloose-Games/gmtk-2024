class_name CollectableArea
extends Area2D

@export var effects: Array[CollectableEffect]

signal collected
signal collected_by(collector: CollectorComponent)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_collected_by(collector_area: CollectorComponent):
	collected.emit()
	collected_by.emit(collector_area)
	for effect in effects:
		effect.get_collected_by(collector_area)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
