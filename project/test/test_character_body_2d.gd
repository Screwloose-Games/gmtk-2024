extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const PUSH_FORCE = 500.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Move the character and handle collisions
	var collision_info = move_and_slide()

	# Check for collisions with RigidBody2D and apply push force
	if collision_info:
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			if collision.get_collider() is RigidBody2D:
				var rigidbody = collision.get_collider() as RigidBody2D
				var push_direction = (rigidbody.global_position - global_position).normalized()
				rigidbody.apply_central_impulse(push_direction * PUSH_FORCE)
