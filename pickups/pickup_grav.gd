extends Area3D

func _process(delta):
	rotation.y += (PI/4) * delta
	rotation.x += (PI/4) * delta

func _on_body_entered(body):
	# make gravity less intense
	PhysicsServer3D.area_set_param(get_viewport().find_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY, PhysicsServer3D.area_get_param(get_viewport().find_world_3d().space, PhysicsServer3D.AREA_PARAM_GRAVITY) - 9.0)
	body.grav_updated()
	queue_free()
