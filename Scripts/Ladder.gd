extends Area2D

func _on_body_entered(body):
	print(body.name)
	collide(body, true)

func _on_body_exited(body):
	collide(body, false)
	
func collide(body, state: bool): # Why make another function?
	if !body.is_in_group("Player"):
		return
	
	body.standing_in_ladder = state
