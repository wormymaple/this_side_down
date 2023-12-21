extends Area2D

@export var landing_zone: RigidBody2D

func _on_body_entered(body):
	#print(body.name)
	if body.is_in_group("Box") or body.is_in_group("Player"):
		get_tree().reload_current_scene()
