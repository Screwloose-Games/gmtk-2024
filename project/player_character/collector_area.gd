class_name CollectorComponent

extends Area2D

@export var character_scaler: CharacterScaler

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(collectable_area: Area2D):
	if collectable_area.has_method("get_collected_by"):
		collectable_area.get_collected_by(self)

func add_to_collection(collectable_item):
	pass
	
