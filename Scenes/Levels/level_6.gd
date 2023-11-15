extends Node2D

var minRotation = 2.7
var maxRotation = 3.3
var box1loaded = false
var box2loaded = false

func _process(delta):
	if $SmallTriangleboxDown.rotation > minRotation and $SmallTriangleboxDown.rotation < maxRotation:
		if box1loaded == true:
			
			if $Squarebox.rotation > minRotation and $Squarebox.rotation < maxRotation:
				if box2loaded == true:
					print("YOU DID IT")

func _on_loading_zone_body_entered(body):
	if body == $SmallTriangleboxDown:
		box1loaded = true
	elif body == $Squarebox:
		box2loaded = true


func _on_loading_zone_body_exited(body):
	if body == $SmallTriangleboxDown:
		box1loaded = false
	elif body == $Squarebox:
		box2loaded = false
