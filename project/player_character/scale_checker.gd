class_name ScaleChecker
extends CharacterBody2D

@export var player: CharacterBody2D
@export var speed: float = 200.0

@onready var rotator = %Rotator

@onready var bottom_area: Area2D = %BottomArea
@onready var right_area: Area2D = %RightArea
@onready var left_area: Area2D = %LeftArea
@onready var top_area: Area2D = %TopArea

@onready var player_overlap: Area2D = %PlayerOverlap


var has_room_to_grow: bool:
	get: return has_h_space and has_v_space and can_avoid_collision and player_is_close

var can_avoid_collision: bool = true

var player_is_close: bool:
	get: return player_overlap.has_overlapping_bodies()

var has_h_space: bool:
	get: return !(right_is_colliding and left_is_colliding)
	
var has_v_space: bool:
	get: return !(top_is_colliding and bottom_is_colliding)

func _ready():
	global_position = player.global_position
	scale = player.scale * 2

var top_is_colliding: bool:
	get: return top_area.has_overlapping_bodies()

var bottom_is_colliding: bool:
	get: return bottom_area.has_overlapping_bodies()

var right_is_colliding: bool:
	get: return right_area.has_overlapping_bodies()

var left_is_colliding: bool:
	get: return left_area.has_overlapping_bodies()

func _physics_process(delta: float) -> void:
	#rotator.visible = !has_room_to_grow
	global_position = player.global_position
	#var trajectory = move_toward(global_position, player.global_position, delta)
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		#var collisions = move_and_collide(Vector2(0,0), true, 0.08, true)

		var collisions = move_and_collide(Vector2(0,0))
		var more_collisions = move_and_collide(Vector2(0,0))
		if more_collisions:
			pass
		var still_more_collisions = move_and_collide(Vector2(0,0))
		if still_more_collisions:
			can_avoid_collision = false
		else:
			can_avoid_collision = true

		#move_and_slide()

func is_colliding_on_left_and_right():
	pass

func is_colliding_on_top_and_bottom():
	pass


func handle_collisions():
	print("clear")
	for i in range(get_slide_collision_count()):
				var collision = get_slide_collision(i)
				if collision.get_collider() is StaticBody2D:
					var rigidbody = collision.get_collider() as StaticBody2D
					var collision_direction = collision.get_angle()
					print(collision_direction)
					rotator.rotation = collision_direction
	pass
					#rigidbody.apply_central_impulse(push_direction * push_force)
