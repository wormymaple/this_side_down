extends Node

var completed_levels: Array[int]

func win_level(level_cleared):
	if level_cleared not in completed_levels:
		completed_levels.append(level_cleared)
		print(completed_levels)
	
	await get_tree().create_timer(2).timeout
	
	if level_cleared != 12: # Because the next level is not ready
		get_tree().change_scene_to_file("res://Scenes/Levels/level_" + str(level_cleared + 1) + ".tscn")
	else: # Take me to the credits!
		#get_tree().change_scene_to_file("res://Scenes/UI/MainmenuLevelScene.tscn")
		get_tree().change_scene_to_file("res://Scenes/UI/credits.tscn")
