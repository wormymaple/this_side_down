extends Area2D

var won_already = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and won_already == false:
		GlobalVariables.win_level("16") # This should be an export but since this is only used in level 12 I do not need to do that
		won_already = true # This prevents multiple players from loading the credits multiple times
		print("You won!")
	else:
		print("Something that wasn't a player entered the victory area")
