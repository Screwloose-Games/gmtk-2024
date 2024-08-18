extends CharacterBody2D

@onready var character_scaler: Node = %CharacterScaler

@export var base_move_speed = 100.0
var move_speed = base_move_speed

@export var base_jump_velocity = -400.0
var jump_velocity = base_jump_velocity

signal scaled(amount: float)
signal jumped
signal became_airborn
signal landed

enum State {
	IDLE,
	JUMP,
	WALK,
	FALL,
	PUSH
}

@export var base_push_force: float = 100.0

var push_force: float:
	get: return base_push_force * scale_amount

@export var scale_duration: float = 0.5
@export var scale_amount: float = 1.0:
	set = set_scale_amount
func set_scale_amount(val: float):
	scale_amount = val
	jump_velocity = sqrt(val) * base_jump_velocity
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(val, val), scale_duration)
	move_speed = base_move_speed * sqrt(scale_amount)
	#gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * sqrt(scale_amount)

func _on_character_scaled(amount: float):
	scaled.emit(amount)

func _ready():
	character_scaler.scaled.connect(_on_character_scaled)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		jumped.emit()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)

	move_and_slide()
