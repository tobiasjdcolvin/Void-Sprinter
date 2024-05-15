extends RigidBody3D

var move_speed = 7
@onready var to_rotate_towards
# For sideways moving: right
# For forward/backwards moving: backward
# For vertical moving: up
@export var move_direc = "right"
@onready var falling = false
@onready var direc_tween
@onready var has_rotated = false
@onready var has_fallen = false

func _ready():
	if move_direc == "right":
		linear_velocity.x = move_speed
		move_direc = "left"
	if move_direc == "backward":
		linear_velocity.z = -move_speed
		move_direc = "forward"
	if move_direc == "up":
		linear_velocity.y = move_speed
		move_direc = "down"
	

func _on_move_timer_timeout():
	if falling == false:
		# move right, set left
		if move_direc == "right":
			linear_velocity.x = move_speed
			move_direc = "left"
		# move left, set right
		if move_direc == "left":
			linear_velocity.x = -move_speed
			move_direc = "right"
		if move_direc == "backward":
			linear_velocity.z = -move_speed
			move_direc = "forward"
		if move_direc == "forward":
			linear_velocity.z = move_speed
			move_direc = "backward"
		if move_direc == "up":
			linear_velocity.y = move_speed
			move_direc = "down"
		if move_direc == "down":
			linear_velocity.y = -move_speed
			move_direc = "up"

func _physics_process(_delta):
	if falling and not has_fallen:
		linear_velocity.x = 0
		linear_velocity.y = 0
		linear_velocity.z = 0
		has_fallen = true

func rotate_now():
	var rotate_tween = get_tree().create_tween()
	rotate_tween.tween_property(self, "rotation", to_rotate_towards, 0.3)
