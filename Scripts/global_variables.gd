extends Node

var completed_levels: Array[int]
#var levelrn = 0



func win_level(level: int):
	if level not in completed_levels:
		completed_levels.append(level)
		print(completed_levels)
	
	await get_tree().create_timer(2).timeout
	
	if level != 5: # Because the next level is not ready
		get_tree().change_scene_to_file("res://Scenes/Levels/level_" + str(level + 1) + ".tscn")
	else:
		get_tree().change_scene_to_file("res://MainmenuLevelScene.tscn")
