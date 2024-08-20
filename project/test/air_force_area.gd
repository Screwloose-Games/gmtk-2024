extends Area2D

# Exported properties for adjusting in the editor
@export var upward_force: float = 2000.0
@export var vertical_falloff: float = 1.0
@export var horizontal_falloff: float = 1.0
@onready var force_center: Marker2D = $ForceCenter

#func _ready():
	#body_entered.connect(_on_area_body_entered)

func _physics_process(delta: float) -> void:
	for body in get_overlapping_bodies():
		_on_area_body_entered(body)

# This method is called when a body enters the area.
func _on_area_body_entered(body: Node):
	if body is CharacterBody2D:
		var origin_global = force_center.global_position
		# Calculate the distance from the origin
		var distance_to_origin = body.global_position.distance_to(origin_global)
		
		# Apply falloff calculations
		var vertical_distance = abs(body.global_position.y - origin_global.y)
		var horizontal_distance = abs(body.global_position.x - origin_global.x)

		# Calculate the effective force with falloff
		var effective_force = upward_force / (1.0 + vertical_falloff * vertical_distance + horizontal_falloff * horizontal_distance)
		
		# Apply the calculated force
		#body.apply_central_force
		body.velocity.y -= effective_force
