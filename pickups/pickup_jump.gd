extends Area3D

func _process(delta):
	rotation.y += (PI/4) * delta
	rotation.x += (PI/4) * delta

func _on_body_entered(body):
	body.max_jumps += 1
	body.speed += 0.5
	queue_free()
