extends Control

func _ready():
	$"Back Button".grab_focus()

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
