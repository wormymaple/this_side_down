extends Node2D

@export var landing_zone: NodePath
@export var camera: Camera2D

func _ready():
	GlobalVariables.levelrn = 3
	
func _on_zone_body_body_entered(bodies):
	var won = GlobalVariables.check_win_condition(bodies)
	
	if won:
		win()
		
func win():
	if 3 in GlobalVariables.completed_levels:
		return
	
	GlobalVariables.win_level(3)
	get_node(landing_zone).play_particles()
	
	camera.fade_out(true)
	
	await get_tree().create_timer(1.9).timeout
	ThemeSongLoop.stop()
	ThemeSongLoop.intro1 = false
	ThemeSongLoop.warehouse = false
	ThemeSongLoop.intro2 = true
	ThemeSongLoop.stream = load("res://Audio/AutomaticLabelMakerIntro.mp3")
	ThemeSongLoop.play()
