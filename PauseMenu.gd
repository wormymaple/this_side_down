extends Control

@onready var level_1 = $"../../"
@onready var settings_menu = $SettingsMenu

func _on_resume_btn_pressed():
	level_1.pauseMenu()

func _on_button_4_pressed():
	get_tree().quit()




func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://MainmenuLevelScene.tscn")


func _on_button_2_pressed():
	settings_menu.show()
