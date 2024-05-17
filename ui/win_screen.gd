extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# reset in this case
func _on_play_pressed():
	GameGlobals.unlocked_levels = 1
	var level_unlocked = str(GameGlobals.unlocked_levels)
	get_tree().change_scene_to_file("res://levels/level_" + level_unlocked + ".tscn")


# still level select
func _on_level_select_pressed():
	get_tree().change_scene_to_file("res://ui/levels.tscn")


# menu in this case
func _on_help_pressed():
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")

