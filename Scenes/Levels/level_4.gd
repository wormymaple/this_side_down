extends Node2D

@export var landing_zone: NodePath
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
	GlobalVariables.win_level(3)
	get_node(landing_zone).play_particles()


func _ready():
	pass

func _on_loading_zone_body_exited(body):
	if body.is_in_group("Box") && num_of_boxes > 0:
		num_of_boxes -= 1


func _on_area_2d_body_entered(body):
	print(body)
	if body.is_in_group("Player") or body.is_in_group("Box"):
		get_tree().change_scene_to_file("res://Scenes/Levels/level_4.tscn")
