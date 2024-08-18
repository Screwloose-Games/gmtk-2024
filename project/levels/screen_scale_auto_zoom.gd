extends Node

@export var camera: PhantomCamera2D
@export var camera_follow_offset: Vector2 = Vector2(0, 0)
@export var camera_scale_base: float = 1.0

var player: Node2D

@onready var follow_marker = get_tree().get_first_node_in_group("PlayerCameraMarker")

func _ready():
	if camera == null:
		camera = get_parent()
	player = get_tree().get_first_node_in_group("Player")
	player.scaled.connect(_on_player_scaled)
	#var follow_marker = get_tree().get_first_node_in_group("PlayerCameraMarker")
	camera.set_follow_target(follow_marker)
	scale_camera()

func _on_player_scaled(_val: float):
	scale_camera()

func _process(_delta):
	camera.follow_offset = Vector2(0, 0)
	camera.dead_zone_height = 0.2
	camera.dead_zone_width = 0.2
	return
	scale_camera()

func scale_camera():
	#return
	# Get the current viewport height
	var viewport_height = get_viewport().get_visible_rect().size.y
	# Get the display height (screen height)
	var display_height = get_viewport().size.y
	
	# Calculate the scale factor based on the display height and viewport height
	var scale_factor = display_height / viewport_height
	var camera_scale: float = calculate_camera_scale(scale_factor)
	# Apply the scale factor to the camera's zoom
	var camera_scale_vector := Vector2(camera_scale, camera_scale)
	var tween = get_tree().create_tween()
	var h = player.char_height
	tween.tween_property(camera, "zoom", camera_scale_vector, 1).set_trans(Tween.TRANS_SINE)
	#tween.tween_property(camera, "zoom", camera_scale_vector, 1).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(camera, "_follow_framed_offset", Vector2(0,0), 1)
	#camera._follow_framed_offset = Vector2(0,0)
	tween.tween_callback(func():
		camera.set_follow_target(follow_marker)
		camera.set_follow_offset(camera_follow_offset)
		
		#camera.dead_zone_width = 0.2 * pow(scale_factor, 2)
		#camera.dead_zone_height = 0.2 * pow(scale_factor, 2)
	)
	#_follow_framed_offset
	
	#camera.set_zoom(Vector2(camera_scale, camera_scale))
	#camera.zoom = Vector2(1, 1)

func calculate_camera_scale(game_scale_factor: float) -> float:
	var player_scale = player.scale_amount
	return camera_scale_base * game_scale_factor / player_scale
