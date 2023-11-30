extends CanvasLayer

var paused = false

func _on_resume_btn_pressed():
	pauseMenu()
	
func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://MainmenuLevelScene.tscn")
	
func _on_button_4_pressed():
	get_tree().quit()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		visible = false
		paused = false
	else:
		visible = true
		paused = true
