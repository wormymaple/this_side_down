extends Node2D

func _ready():
	if ThemeSongLoop.playing:
		ThemeSongLoop.stop()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://level_select.tscn")


func _on_options_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()
	
