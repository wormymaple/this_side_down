extends Node2D

@export var landing_zone: NodePath

func _ready():
	GlobalVariables.levelrn = 11
	
func _on_zone_body_body_entered(bodies):
	var won = GlobalVariables.check_win_condition(bodies)
	
	if won:
		win()
		
func win():
	GlobalVariables.win_level(5)
	get_node(landing_zone).play_particles()
