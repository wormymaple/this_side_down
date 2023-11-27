extends Node2D

@onready var settings_menu = $SettingsMenu
@onready var main_menu = $MainMenu

func _ready():
	#if ThemeSongLoop.playing:
		#ThemeSongLoop.stop()
	pass

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://level_select.tscn")

func _on_options_button_pressed():
	settings_menu.show()

func _on_quit_button_pressed():
	get_tree().quit()
	
