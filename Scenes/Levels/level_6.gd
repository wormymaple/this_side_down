extends Node2D

@export var landing_zone: NodePath

func _ready():
	GlobalVariables.levelrn = 6
	
func _on_zone_body_body_entered(bodies):
	var won = GlobalVariables.check_win_condition(bodies)
	
	if won:
		win()
		
func win():
	get_node(landing_zone).play_particles()
	if 6 in GlobalVariables.completed_levels:
		return
	
	GlobalVariables.completed_levels.append(6)
	print(GlobalVariables.completed_levels)
	
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://MainmenuLevelScene.tscn")
