extends RigidBody2D

@export var upward_force: float = 2000.0
@export var vertical_falloff: float = 1.0
@export var horizontal_falloff: float = 1.0

@onready var air_force_area: Area2D = $AirForceArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	air_force_area.upward_force = upward_force
	air_force_area.vertical_falloff = vertical_falloff
	air_force_area.horizontal_falloff = horizontal_falloff

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
