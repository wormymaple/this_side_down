extends Node2D

var minRotation = 2.7
var maxRotation = 3.3
var box1loaded = false
var box2loaded = false
var box3loaded = false

func _process(delta):
	if $SquareBox1.rotation > minRotation and $SquareBox1.rotation < maxRotation:
		if box1loaded == true:
			
			if $SquareBox2.rotation > minRotation and $SquareBox2.rotation < maxRotation:
				if box2loaded == true:
					if $TriangleboxUp.rotation > minRotation and $TriangleboxUp.rotation < maxRotation:
						if box3loaded == true:
							LevelsCompleted.level9done = true
							get_tree().change_scene_to_file("res://Scenes/Levels/level_10")

func _on_loading_zone_body_entered(body):
	if body == $SquareBox1:
		box1loaded = true
	elif body == $SquareBox2:
		box2loaded = true
	elif body == $TriangleboxUp:
		box3loaded = true


func _on_loading_zone_body_exited(body):
	if body == $SquareBox1:
		box1loaded = false
	elif body == $SquareBox2:
		box2loaded = false
	elif body == $TriangleboxUp:
		box3loaded = false