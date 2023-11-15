extends Node2D

var minRotation = 2.7
var maxRotation = 3.3

func _process(delta):
	if $RigidBody2D.rotation > minRotation and $RigidBody2D.rotation < maxRotation:
		if $RigidBody2D2.rotation > minRotation and $RigidBody2D2.rotation < maxRotation:
			if $TBox.rotation > minRotation and $TBox.rotation < maxRotation:
				print("YOU DID IT!!!")
