extends Node2D


func _on_void_out_area_body_entered(body):
	#print(body)
	if body.is_in_group("Player") or body.is_in_group("Box"):
		get_tree().change_scene_to_file("res://Scenes/Levels/level_4.tscn")
