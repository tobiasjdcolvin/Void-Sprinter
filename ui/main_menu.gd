extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_play_pressed():
	var level_unlocked = str(GameGlobals.unlocked_levels)
	get_tree().change_scene_to_file("res://levels/level_" + level_unlocked + ".tscn")


func _on_level_select_pressed():
	get_tree().change_scene_to_file("res://ui/levels.tscn")
