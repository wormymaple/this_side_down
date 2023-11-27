extends Node2D

var minRotation = 2.7
var maxRotation = 3.3
var box1loaded = false
var box2loaded = false

@onready var global_vars = get_node("/root/GlobalVariables")

func _process(delta):
	if $SquareBox.rotation > minRotation and $SquareBox.rotation < maxRotation:
		if box1loaded == true:
			
			if $CircleBox.rotation > minRotation and $CircleBox.rotation < maxRotation:
				if box2loaded == true:
					global_vars.win_level(12)
					get_tree().change_scene_to_file("res://level_select.tscn")

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
