extends Node

class_name HorizontalFlipper

@export var translation_base: CharacterBody2D
@export var translation_target: Node2D

func _process(delta):
	if is_moving_left():
		_face_left()
	elif is_moving_right():
		_face_right()

func is_moving_left():
	return translation_base.velocity.x > 0

func is_moving_right():
	return translation_base.velocity.x < 0

func _is_facing_left():
	return translation_target.transform.x.x == -1

func _face_left():
	translation_target.transform.x.x = -1

func _face_right():
	translation_target.transform.x.x = 1
