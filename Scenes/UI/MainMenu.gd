extends Control

@onready var settings_menu = $SettingsMenu
@onready var FocusButton = $HBoxContainer/ButtonPlay


func _ready():
	#if ThemeSongLoop.playing:
		#ThemeSongLoop.stop()
	FocusButton.grab_focus()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/LevelSelect.tscn")
func _on_options_button_pressed():
	settings_menu.show()
func _on_quit_button_pressed():
	get_tree().quit()

func _on_joy_connection_changed(device_id, connected):
	if connected:
		print(Input.get_joy_name(device_id))
	else:
		print("Keyboard")
