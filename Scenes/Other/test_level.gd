extends Node2D

var minRotation = 2.7
var maxRotation = 3.3

func _process(_delta):
	if $Box.rotation > minRotation and $Box.rotation < maxRotation:
		if $Box2.rotation > minRotation and $Box2.rotation < maxRotation:
			if $TBox.rotation > minRotation and $TBox.rotation < maxRotation:
				print("YOU DID IT!!!")
