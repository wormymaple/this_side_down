extends Control

@onready var level_1 = $"../../"
@onready var settings_menu = $SettingsMenu
var paused = false

func _on_resume_btn_pressed():
	pauseMenu()

func _on_button_4_pressed():
	get_tree().quit()

func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://MainmenuLevelScene.tscn")

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		hide()
		Engine.time_scale = 1
	else:
		show()
		Engine.time_scale = 0
	
	paused = !paused
