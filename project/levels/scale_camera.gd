extends Camera2D

func _ready():
	scale_camera()

func _process(delta):
	scale_camera()

func scale_camera():
	# Get the current viewport height
	var viewport_height = get_viewport().get_visible_rect().size.y
	# Get the display height (screen height)
	var display_height = get_viewport().size.y
	
	# Calculate the scale factor based on the display height and viewport height
	var scale_factor = display_height / viewport_height
	
	# Apply the scale factor to the camera's zoom
	zoom = Vector2(scale_factor, scale_factor)
