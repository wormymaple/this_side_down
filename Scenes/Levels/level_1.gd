extends Node2D

@export var landing_zone: NodePath

func _on_zone_body_body_entered(body):
	if body.is_in_group("Box"):
		if body.get_meta("grabbed"):
			return
		
		if abs(body.rotation_degrees) > 180 - 35:
			win()
		
func win():
	GlobalVariables.win_level(1)
	get_node(landing_zone).play_particles()

@onready var pause_menu = $Camera/PauseMenu
var paused = false


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused
