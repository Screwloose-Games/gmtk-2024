
class_name Actor
extends CharacterBody2D

var _is_coyote_time : bool = false
@export var coyote_time_amount: float = 0.2

@onready var character_scaler: Node = %CharacterScaler

@onready var state_machine: StateMachine = %StateMachine

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var character_gravity: Vector2 = Vector2(0, 980)
@export var can_grow: bool = false
@export var can_shrink: bool = false

@onready var base_height = collision_shape_2d.shape.height
@onready var char_height: float:
	get: return base_height * scale_amount
@onready var jump_height = 0.9 * base_height
@onready var jump_power = calculate_jump_velocity(character_gravity.y, jump_height)

@export var base_move_speed = 100.0
@onready var move_speed = base_move_speed

@onready var base_jump_velocity = -jump_power
@onready var jump_velocity = -jump_power
@export var max_fall_speed: float = 250.0
@onready var max_float_fall_speed: float:
	get: return max_fall_speed * scale_amount

signal scaled(amount: float)
signal jumped
signal became_airborn
signal landed

var _is_on_floor: bool = true

func _check_floor():
	if _is_on_floor and not is_on_floor():
		_on_leave_floor()
		
	if not _is_on_floor and is_on_floor():
		_on_touch_floor()
	
	_is_on_floor = is_on_floor()

func _on_touch_floor():
	stop_coyote_time()

func stop_coyote_time():
	_is_coyote_time = false
	_is_on_floor = false

func _on_leave_floor():
	if velocity.y >= 0.0:
		start_coyote_time()

@export var base_push_force: float = 100.0

func start_coyote_time():
	if _is_coyote_time:
		return
	_is_coyote_time = true
	await get_tree().create_timer(coyote_time_amount).timeout
	_is_coyote_time = false

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

func calculate_jump_velocity(gravity_strength: float, jump_height: float) -> float:
	# Using the formula v0 = sqrt(2 * g * h)
	return sqrt(2 * gravity_strength * jump_height)

func _on_character_scaled(amount: float):
	scaled.emit(amount)

func _apply_jump():
	#if not _can_move: return
	
	if Input.is_action_just_pressed("jump"):
		if _can_jump():
			velocity.y = jump_velocity
			state_machine.change_state(%JumpState)
			jumped.emit()
			#on_jump_start.emit()
			stop_coyote_time()
		#else:
			#_start_jump_buffer()

	#elif Input.is_action_just_released("jump"):
		#on_jump_end.emit()

func _can_jump():
	return _is_coyote_time or _is_on_floor

func _ready():
	character_scaler.scaled.connect(_on_character_scaled)
	character_scaler.can_grow = can_grow
	character_scaler.can_shrink = can_shrink

func _physics_process(delta: float) -> void:
	var grav = get_gravity()
	_check_floor()
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += character_gravity * delta
		if velocity.y > 0 and Input.is_action_pressed("jump"):
			velocity.y = min(max_float_fall_speed, velocity.y)

	# Handle jump.
	_apply_jump()
	#if Input.is_action_just_pressed("jump") and (is_on_floor() or _is_coyote_time):
		#_is_coyote_time = false
		#velocity.y = jump_velocity
		#state_machine.change_state(%JumpState)
		#jumped.emit()
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)

	var collision_info = move_and_slide()

	# Check for collisions with RigidBody2D and apply push force
	if collision_info:
		handle_collisions()
		

func handle_collisions():
	for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			if collision.get_collider() is RigidBody2D:
				var rigidbody = collision.get_collider() as RigidBody2D
				var push_direction = (rigidbody.global_position - global_position).normalized()
				rigidbody.apply_central_impulse(push_direction * push_force)
