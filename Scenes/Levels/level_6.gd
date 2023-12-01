extends Node2D

var minRotation = 2.7
var maxRotation = 3.3
var box1loaded = false
var box2loaded = false

func _process(delta):
	if $TriangleboxUp.rotation > minRotation and $TriangleboxUp.rotation < maxRotation:
		if box1loaded == true:
			
			if $Squarebox.rotation > minRotation and $Squarebox.rotation < maxRotation:
				if box2loaded == true:
					#LevelsCompleted.level6done = true
					get_tree().change_scene_to_file("res://Scenes/Levels/level_7")

func _on_loading_zone_body_entered(body):
	if body == $TriangleboxUp:
		box1loaded = true
	elif body == $Squarebox:
		box2loaded = true


func _on_loading_zone_body_exited(body):
	if body == $TriangleboxUp:
		box1loaded = false
	elif body == $Squarebox:
		box2loaded = false
