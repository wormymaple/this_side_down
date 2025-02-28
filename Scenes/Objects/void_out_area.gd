extends Area2D

func _on_body_entered(body):
	#print(body.name)
	if body.is_in_group("Box") or body.is_in_group("Player"):
		get_tree().call_deferred("reload_current_scene")
