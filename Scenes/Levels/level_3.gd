extends Node2D

@export var landing_zone: NodePath

func _on_zone_body_body_entered(body):
	if body.is_in_group("Box"):
		if body.get_meta("grabbed"):
			return
		
		if abs(body.rotation_degrees) > 180 - 35:
			win()
		
func win():
	GlobalVariables.win_level(3)
	get_node(landing_zone).play_particles()
	await get_tree().create_timer(0.9).timeout
	ThemeSongLoop.stop()
	ThemeSongLoop.warehouse = false
	ThemeSongLoop.intro2 = true
	ThemeSongLoop.stream = load("res://Audio/AutomaticLabelMakerIntro.mp3")
	ThemeSongLoop.play()
