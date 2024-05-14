extends RigidBody3D

@onready var to_rotate_towards
@onready var falling = false
@onready var has_rotated = false

func rotate_now():
	var rotate_tween = get_tree().create_tween()
	rotate_tween.tween_property(self, "rotation", to_rotate_towards, 0.3)
