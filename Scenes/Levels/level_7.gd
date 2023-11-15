extends Node2D

var minRotation = 2.7
var maxRotation = 3.3
var box1loaded = false
var box2loaded = false
var box3loaded = false

func _process(delta):
	if $TriangleboxUp.rotation > minRotation and $TriangleboxUp.rotation < maxRotation:
		if box1loaded == true:
			
			if $TriangleboxUp2.rotation > minRotation and $TriangleboxUp2.rotation < maxRotation:
				if box2loaded == true:
					
					if $Spherebox.rotation > minRotation and $Spherebox.rotation < maxRotation:
						if box3loaded == true:
							LevelsCompleted.level7done = true
							get_tree().change_scene_to_file("res://Scenes/Levels/level_8")

func _on_loading_zone_body_entered(body):
	if body == $TriangleboxUp:
		box1loaded = true
	elif body == $TriangleboxUp2:
		box2loaded = true
	elif body == $Spherebox:
		box3loaded = true


func _on_loading_zone_body_exited(body):
	if body == $TriangleboxUp:
		box1loaded = false
	elif body == $TriangleboxUp2:
		box2loaded = false
	elif body == $Spherebox:
		box3loaded = false
