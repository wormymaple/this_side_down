extends Node2D

@onready var global_vars = get_node("/root/GlobalVariables")

@export var landing_zone: NodePath

func _on_zone_body_body_entered(body):
	if body.is_in_group("Box"):
		if body.get_meta("grabbed"):
			return
		
		if abs(body.rotation_degrees) > 180 - 35:
			win()
		
func win():
	global_vars.win_level(1)
	get_node(landing_zone).play_particles();
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/Levels/level_2.tscn")
