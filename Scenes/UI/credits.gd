extends Control


func _ready():
	pass # Replace with function body.


func _process(_delta):
	if Input.is_action_just_pressed("cancel"):
		get_tree().change_scene_to_file("res://Scenes/UI/MainmenuLevelScene.tscn")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/MainmenuLevelScene.tscn")
