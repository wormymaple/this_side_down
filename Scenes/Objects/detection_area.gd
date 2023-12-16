extends RigidBody2D

# This script is for tests i (Hiro) do

@export var box : RigidBody2D

func _on_void_out_area_body_entered(body):
	if body.is_in_group("Box") or body.is_in_group("Player"):
		print("The level would reset now.")
		
