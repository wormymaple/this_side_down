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
	global_vars.win_level(2)
	get_node(landing_zone).play_particles();
