extends Node2D

@export var landing_zone: NodePath
@export var camera: Camera2D

func _ready():
	GlobalVariables.levelrn = 1
	
func _on_zone_body_body_entered(bodies):
	var won = GlobalVariables.check_win_condition(bodies)
	
	if won:
		win()
		
func win():
	GlobalVariables.win_level(1)
	get_node(landing_zone).play_particles()
	camera.fade_out(true)

