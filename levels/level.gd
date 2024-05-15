extends Node3D

var player_scene = preload("res://player/player.tscn")
var grav_increaser = 0.18
var grav_threshold = 36
var has_fallen = false
@onready var grav_ui = $HUD/VBoxContainer/GravityProgressBar

func _unhandled_input(event):
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	PhysicsServer3D.area_set_param(get_viewport().find_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY, 9.8)
	var player = player_scene.instantiate()
	player.get_hud($HUD)
	player.transform.origin = $PlayerContainer/PlayerSpawnPoint.transform.origin
	$PlayerContainer.add_child(player)

	
func _on_gravity_timer_timeout():
	# continuously add "grav_increaser" to the project's gravity
	PhysicsServer3D.area_set_param(get_viewport().find_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY, PhysicsServer3D.area_get_param(get_viewport().find_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY) + grav_increaser)
	grav_ui.set_value_no_signal(PhysicsServer3D.area_get_param(get_viewport().find_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY))
	
	# suck everything into the void once gravity reaches "grav_threshold"
	if PhysicsServer3D.area_get_param(get_viewport().find_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY) >= grav_threshold and not has_fallen:
		for platform in $Platforms.get_children():
			platform.falling = true
			platform.gravity_scale = 1
			var rng = RandomNumberGenerator.new()
			var xrand = rng.randf_range(-PI/4, PI/4)
			var zrand = rng.randf_range(-PI/4, PI/4)
			platform.to_rotate_towards = Vector3(xrand, platform.rotation.y, zrand)
		for pickup in $Pickups.get_children():
			pickup.queue_free()
		$PlayerContainer/Player.level_falling = true
		has_fallen = true

func _process(_delta):
	if has_fallen:
		for platform in $Platforms.get_children():
			if not platform.has_rotated:
				platform.rotate_now()
				platform.has_rotated = true

func grav_update():
	grav_ui.set_value_no_signal(PhysicsServer3D.area_get_param(get_viewport().find_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY))
	
func reset_level():
	get_tree().reload_current_scene()

