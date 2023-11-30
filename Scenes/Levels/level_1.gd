extends Node2D

@export var landing_zone: NodePath
@export var camera: Camera2D

func _ready():
	pass
	
func _on_zone_body_body_entered(body):
	if body.is_in_group("Box"):
		if body.get_meta("grabbed"):
			return
		
		if abs(body.rotation_degrees) > 180 - 35:
			win()
		
func win():
	GlobalVariables.win_level(1)
	get_node(landing_zone).play_particles()
	
	camera.fade_out(true)

