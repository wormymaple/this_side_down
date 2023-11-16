extends Node2D

var minRotation = 2.7
var maxRotation = 3.3
var box1loaded = false
@onready var global_vars = get_node("/root/GlobalVariables")

@export var particles: GPUParticles2D

func _on_zone_body_body_entered(body):
	if body.is_in_group("Box"):
		if body.get_meta("grabbed"):
			return
		
		if abs(body.rotation_degrees) > 180 - 35:
			win()
		
func win():
	global_vars.win_level(1)
	particles.emitting = true
