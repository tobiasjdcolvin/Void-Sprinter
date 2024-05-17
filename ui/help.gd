extends Control

func _unhandled_input(event):
	if event.is_action_pressed("exit"):
		get_tree().change_scene_to_file("res://ui/main_menu.tscn")
