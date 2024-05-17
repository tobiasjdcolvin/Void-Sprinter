extends Area3D

func _process(delta):
	rotation.y += (PI/4) * delta

func _on_body_entered(_body):
	if GameGlobals.cur_level == GameGlobals.winning_level:
		get_tree().change_scene_to_file("res://ui/win_screen.tscn")
	else:
		GameGlobals.cur_level += 1
		if GameGlobals.unlocked_levels < GameGlobals.cur_level:
			GameGlobals.unlocked_levels = GameGlobals.cur_level
		var next_level_str = str(GameGlobals.cur_level)
		get_tree().call_deferred("change_scene_to_file", "res://levels/level_" + next_level_str + ".tscn")
		#get_tree().change_scene_to_file("res://levels/level_" + next_level_str + ".tscn")

