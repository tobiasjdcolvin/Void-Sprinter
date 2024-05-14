extends RigidBody3D

@onready var to_rotate_towards
@onready var move_direc = "right"
@onready var falling = false
@onready var direc_tween
@onready var has_rotated = false



func _on_move_timer_timeout():
	if falling == false:
		direc_tween = get_tree().create_tween()
		# move right, set left
		if move_direc == "right":
			direc_tween.tween_property(self, "position", Vector3(self.position.x + 10, self.position.y, self.position.z), 2)
			move_direc = "left"
		# move left, set right
		else:
			direc_tween.tween_property(self, "position", Vector3(self.position.x - 10, self.position.y, self.position.z), 2)
			move_direc = "right"

func _physics_process(_delta):
	if falling:
		direc_tween.pause()

func rotate_now():
	var rotate_tween = get_tree().create_tween()
	rotate_tween.tween_property(self, "rotation", to_rotate_towards, 0.3)
