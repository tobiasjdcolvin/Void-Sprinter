extends CharacterBody3D

var speed = 6.0
const JUMP_VELOCITY = 6.5
var level_falling = false
var num_jumps = 0
var max_jumps = 1

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$CameraStick.rotate_y(-event.relative.x * GameGlobals.mouse_sens)
		$CameraStick/Camera3D.rotate_x(-event.relative.y * GameGlobals.mouse_sens)
		$CameraStick/Camera3D.rotation.x = clamp($CameraStick/Camera3D.rotation.x, -PI/4, PI/10)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() or level_falling:
		velocity.y -= PhysicsServer3D.area_get_param(get_viewport().find_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY) * delta

	if is_on_floor():
		num_jumps = 0
		
	if level_falling:
		max_jumps = 1

	# Handle jump.
	if Input.is_action_just_pressed("jump") and num_jumps <= max_jumps - 1 and $JumpTimer.is_stopped():
		velocity.y = JUMP_VELOCITY
		num_jumps += 1
		$JumpTimer.start()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = ($CameraStick.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
