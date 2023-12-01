extends Node2D

@export var landing_zone: NodePath
@export var camera: Camera2D

var num_of_boxes = 0

func _on_zone_body_body_entered(body):
	if body.is_in_group("Box"):
		if body.get_meta("grabbed"):
			return
		
		if abs(body.rotation_degrees) > 180 - 35:
			num_of_boxes += 1
			
		if num_of_boxes >= 2:
			win()
		
func win():
	if 2 in GlobalVariables.completed_levels:
		return
		
	GlobalVariables.win_level(2)
	get_node(landing_zone).play_particles();

	camera.fade_out(true)
