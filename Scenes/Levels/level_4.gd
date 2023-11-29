extends Node2D

var minRotation = 2.7
var maxRotation = 3.3
var box1loaded = false
var box2loaded = false

func _ready():
	ThemeSongLoop.stop()
	ThemeSongLoop.stream = load("res://Audio/.wav")
	ThemeSongLoop.play()
	
func _process(delta):
	if $TriangleboxUp.rotation > minRotation and $TriangleboxUp.rotation < maxRotation:
		if box1loaded == true:
			
			if $TriangleboxUp2.rotation > minRotation and $TriangleboxUp2.rotation < maxRotation:
				if box2loaded == true:
					#LevelsCompleted.level4done = true
					get_tree().change_scene_to_file("res://Scenes/Levels/level_5")

func _on_loading_zone_body_entered(body):
	if body == $TriangleboxUp:
		box1loaded = true
	elif body == $TriangleboxUp2:
		box2loaded = true


func _on_loading_zone_body_exited(body):
	if body == $TriangleboxUp:
		box1loaded = false
	elif body == $TriangleboxUp2:
		box2loaded = false
