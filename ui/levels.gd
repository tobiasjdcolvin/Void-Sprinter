extends Control

func _unhandled_input(event):
	if event.is_action_pressed("exit"):
		get_tree().change_scene_to_file("res://ui/main_menu.tscn")

func _ready():
	if GameGlobals.unlocked_levels == 1:
		$HBoxContainer/Level1.text = "Level 1"
	if GameGlobals.unlocked_levels == 2:
		$HBoxContainer/Level1.text = "Level 1"
		$HBoxContainer/Level2.text = "Level 2"
	if GameGlobals.unlocked_levels == 3:
		$HBoxContainer/Level1.text = "Level 1"
		$HBoxContainer/Level2.text = "Level 2"
		$HBoxContainer/Level3.text = "Level 3"
	if GameGlobals.unlocked_levels == 4:
		$HBoxContainer/Level1.text = "Level 1"
		$HBoxContainer/Level2.text = "Level 2"
		$HBoxContainer/Level3.text = "Level 3"
		$HBoxContainer/Level4.text = "Level 4"
	if GameGlobals.unlocked_levels == 5:
		$HBoxContainer/Level1.text = "Level 1"
		$HBoxContainer/Level2.text = "Level 2"
		$HBoxContainer/Level3.text = "Level 3"
		$HBoxContainer/Level4.text = "Level 4"
		$HBoxContainer/Level4.text = "Level 5"




func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://levels/level_1.tscn")


func _on_level_2_pressed():
	if GameGlobals.unlocked_levels >= 2:
		get_tree().change_scene_to_file("res://levels/level_2.tscn")
