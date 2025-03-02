extends Control

@onready var settings_menu = $SettingsMenu
@onready var FocusButton = $HBoxContainer/ButtonPlay

func _ready():
	FocusButton.grab_focus()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/level_select.tscn")
func _on_options_button_pressed():
	settings_menu.show()
func _on_quit_button_pressed():
	get_tree().quit()

func _on_joy_connection_changed(device_id, connected): # This is only for debug
	if connected:
		print(Input.get_joy_name(device_id))
	else:
		print("Keyboard")
