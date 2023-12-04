extends CanvasLayer

const positions = [402, 525, 648, 771]
const button_functions = ['_on_resume_btn_pressed', '_on_settings_pressed', '_on_button_3_pressed', '_on_button_4_pressed']
var selected_space = 0

func _ready():
	hide()

func _on_resume_btn_pressed():
	hide()

func _on_settings_pressed():
	$SettingsMenu.show()

func _on_button_3_pressed():
	if get_tree().paused:
		get_tree().paused = false
	get_tree().change_scene_to_file("res://MainmenuLevelScene.tscn")
	
func _on_button_4_pressed():
	get_tree().quit()

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		visible = !visible
	
	if $SettingsMenu.visible: # Prevents selectingwhile the settings are up
		return
	if Input.is_action_just_pressed("left_up_p1") and visible:
		print("You pressed up")
		move_arrow(-1)
	if Input.is_action_just_pressed("left_down_p1") and visible:
		move_arrow(1)
	
	if Input.is_action_just_pressed("confirm") and visible:
		call(button_functions[selected_space])
		
		

func move_arrow(dir: int):
	selected_space += dir
	if selected_space > 3:
		selected_space = 0
	elif selected_space < 0:
		selected_space = 3
	
	$Selector.position.y = positions[selected_space]

func _on_visibility_changed():
	if visible:
		#print("Pausing")
		if !get_tree().paused:
			get_tree().paused = true
	else:
		#print("Unpausing")
		if get_tree().paused:
			get_tree().paused = false
