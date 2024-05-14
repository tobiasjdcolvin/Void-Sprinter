extends RigidBody3D

var move_speed = 7
@onready var to_rotate_towards
@onready var move_direc = "right"
@onready var falling = false
@onready var direc_tween
@onready var has_rotated = false

func _ready():
	linear_velocity.x = move_speed
	move_direc = "left"
	

func _on_move_timer_timeout():
	if falling == false:
		# move right, set left
		if move_direc == "right":
			linear_velocity.x = move_speed
			move_direc = "left"
		# move left, set right
		else:
			linear_velocity.x = -move_speed
			move_direc = "right"

func _physics_process(_delta):
	if falling:
		linear_velocity.x = 0

func rotate_now():
	var rotate_tween = get_tree().create_tween()
	rotate_tween.tween_property(self, "rotation", to_rotate_towards, 0.3)
