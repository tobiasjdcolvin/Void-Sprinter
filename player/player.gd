extends CharacterBody3D

var speed = 6.0
const JUMP_VELOCITY = 6.5
var level_falling = false
var num_jumps = 0:
	set(value):
		num_jumps = value
		hud.set_jumps(str(max_jumps - num_jumps))
	get:
		return num_jumps
var max_jumps = 1:
	set(value):
		max_jumps = value
		hud.set_jumps(str(max_jumps - num_jumps))
	get:
		return max_jumps
var hud

func get_hud(hud_outside):
	hud = hud_outside

func grav_updated():
	get_parent().get_parent().grav_update()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$CameraStick.rotate_y(-event.relative.x * GameGlobals.mouse_sens)
		$SprinterGuy.rotate_y(-event.relative.x * GameGlobals.mouse_sens)
		$CameraStick/Camera3D.rotate_x(-event.relative.y * GameGlobals.mouse_sens)
		$CameraStick/Camera3D.rotation.x = clamp($CameraStick/Camera3D.rotation.x, -PI/3, PI/4)

func _process(_delta):
	if global_position.y <= -150:
		get_parent().get_parent().reset_level()
	
	if level_falling:
		$SprinterGuy/AnimationPlayer.play("fall")


func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor() or level_falling:
		velocity.y -= PhysicsServer3D.area_get_param(get_viewport().find_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY) * delta

	if is_on_floor():
		num_jumps = 0
		
	if level_falling:
		max_jumps = 1

	# Handle jump.
	if Input.is_action_pressed("jump") and num_jumps <= max_jumps - 1 and $JumpTimer.is_stopped() and not level_falling:
		$SprinterGuy/AnimationPlayer.play("jump")
		velocity.y = JUMP_VELOCITY
		num_jumps += 1
		$JumpTimer.start()
	
	if Input.is_action_pressed("dash") and $DashResetTimer.is_stopped() and not level_falling:
		$SprinterGuy/AnimationPlayer.play("dash")
		$DashTimer.start()
		$DashResetTimer.start()
	
	if not $DashTimer.is_stopped():
		global_position = global_position.move_toward($CameraStick/DashMarker.global_position, delta * 35)
	
	if not $DashResetTimer.is_stopped():
		hud.set_dash_text(str(snapped($DashResetTimer.time_left, 0.00001)))

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = ($CameraStick.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and $DashTimer.is_stopped:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		if is_on_floor and $DashTimer.is_stopped and $JumpTimer.is_stopped:
			$SprinterGuy/AnimationPlayer.play("run")
			
	elif $DashTimer.is_stopped:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	if not direction and $DashTimer.is_stopped and $JumpTimer.is_stopped:
		$SprinterGuy/AnimationPlayer.play("idle")

	move_and_slide()


func _on_dash_reset_timer_timeout():
	hud.set_dash_text("Dash")
