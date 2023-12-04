extends Node2D

@export var landing_zone: NodePath
@export var camera: Camera2D
#var num_of_boxes = 0

func _on_zone_body_body_entered(bodies):
	var won = GlobalVariables.check_win_condition(bodies)
	
	if won:
		win()
		

func win():
	if 4 in GlobalVariables.completed_levels:
		return
		
	GlobalVariables.win_level(4)
	get_node(landing_zone).play_particles()
	camera.fade_out(true)


func _ready():
	GlobalVariables.levelrn = 4

#func _on_loading_zone_body_exited(body):
#	if body.is_in_group("Box") && num_of_boxes > 0:
#		num_of_boxes -= 1


func _on_void_out_area_body_entered(body):
	#print(body)
	if body.is_in_group("Player") or body.is_in_group("Box"):
		get_tree().change_scene_to_file("res://Scenes/Levels/level_4.tscn")
