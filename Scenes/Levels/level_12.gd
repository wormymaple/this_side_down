extends Node2D

var minRotation = 2.7
var maxRotation = 3.3
var box1loaded = false
var box2loaded = false

func _process(delta):
	if $SquareBox.rotation > minRotation and $SquareBox.rotation < maxRotation:
		if box1loaded == true:
			
			if $CircleBox.rotation > minRotation and $CircleBox.rotation < maxRotation:
				if box2loaded == true:
					LevelsCompleted.level12done = true
					get_tree().change_scene("res://Scenes/Levels/level_1")

func _on_loading_zone_body_entered(body):
	if body == $SquareBox:
		box1loaded = true
	elif body == $CircleBox:
		box2loaded = true


func _on_loading_zone_body_exited(body):
	if body == $SquareBox:
		box1loaded = false
	elif body == $CircleBox:
		box2loaded = false
