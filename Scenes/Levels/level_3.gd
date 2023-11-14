extends Node2D

var minRotation = 2.7
var maxRotation = 3.3
var box1loaded = false

func _process(delta):
	if $Squarebox.rotation > minRotation and $Squarebox.rotation < maxRotation:
		if box1loaded == true:
			print("YOU DID IT")

func _on_loading_zone_body_entered(body):
	if body == $Squarebox:
		box1loaded = true


func _on_loading_zone_body_exited(body):
	if body == $Squarebox:
		box1loaded = false
