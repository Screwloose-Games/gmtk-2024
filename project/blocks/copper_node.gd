extends Sprite2D

@onready var label: Label = $Label


var duplicates = []
@onready var x_pos: float:
	get: return get_global_transform_with_canvas().origin.x
@onready var y_pos: float:
	get: return get_global_transform_with_canvas().origin.y
@onready var x_center: float:
	get: return get_viewport().get_visible_rect().size.x / 2
@onready var y_center: float:
	get: return get_viewport().get_visible_rect().size.y / 2
@onready var x_pos_percent = 0.0:
	get: return (x_pos - x_center) / x_center
@onready var y_pos_percent = 0.0:
	get: return (y_pos - y_center) / y_center
@onready var max_step_count = 6
@onready var max_step_size_pixels = 3
#@onready var displacement_vector: Vector2 = Vector2.ZERO:
	#get: return Vector2(max_step_count * max_step_size_pixels * x_pos_percent, )
@onready var displacement_vector:
	get: return Vector2(x_pos - x_center, y_pos - y_center)

@onready var source_instance = self.duplicate(0)

# The total displacement of the node compared to its distance from the screen center.
var displacement_factor = 0.0025

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	source_instance.remove_child(source_instance.get_child(0))
	for i in max_step_count:
		spawn_duplicate()
		position_duplicate(i)
	
	pass # Replace with function body.

func position_duplicate(index):
	var disp = displacement_vector
	var this_displacement = displacement_factor * displacement_vector / max_step_count * max_step_size_pixels * (index + 1)
	duplicates[index].global_position = global_position + this_displacement

	#var total_distance = 
	#var incriments = total_distance / step_size_pixels

func spawn_duplicate():
	var duplicate_item = source_instance.duplicate(0)
	duplicate_item.scale = Vector2(1, 1)
	duplicates.append(duplicate_item)
	add_child(duplicate_item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#label.text = "x center: " + str(x_center) + " screen_position: " + str(get_global_transform_with_canvas().origin.x) + ", " + str(get_global_transform_with_canvas().origin.y)
	label.text = "x pos_percent: " + str(x_pos_percent) + " y pos percent: " + str(y_pos_percent)
	for i in max_step_count:
		position_duplicate(i)
