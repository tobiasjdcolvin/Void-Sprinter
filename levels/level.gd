extends Node3D

var player_scene = preload("res://player/player.tscn")
var grav_increaser = 1.5
var grav_threshold = 25


func _ready():
	var player = player_scene.instantiate()
	player.transform.origin = $PlayerContainer/PlayerSpawnPoint.transform.origin
	$PlayerContainer.add_child(player)
	
func _on_gravity_timer_timeout():
	# continuously add "grav_increaser" to the project's gravity
	PhysicsServer3D.area_set_param(get_viewport().find_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY, PhysicsServer3D.area_get_param(get_viewport().find_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY) + grav_increaser)
	
	# suck everything into the void once gravity reaches "grav_threshold"
	if PhysicsServer3D.area_get_param(get_viewport().find_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY) >= grav_threshold:
		for platform in $Platforms.get_children():
			platform.axis_lock_linear_y = false
		$PlayerContainer/Player.level_falling = true

