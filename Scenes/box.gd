extends RigidBody2D

var on_ground = false

func _physics_process(delta):
	if sleeping:
		#print("I am sleeping!")
		on_ground == true
	else:
		on_ground == false

func _on_body_entered(_body):
	on_ground == true
	print("I am on the ground, or the player is touching me?")


func _on_body_exited(_body):
	on_ground == false
	print("I have left the ground/player?")


func _on_body_shape_entered():
	print("I am on the ground")


func _on_body_shape_exited():
	print("I have left the ground")
