extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GlobalVariables.win_level(12) # This should be an export but since this is only used in level 12 I do not need to do that
