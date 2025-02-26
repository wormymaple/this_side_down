extends CanvasLayer

const positions = [402, 525, 648, 771]
#const button_functions = ['_on_resume_button_pressed', '_on_restart_level_pressed', '_on_settings_pressed', '_on_quit_to_menu_pressed']
var selected_space = 0

@onready var SettingsMenu = $SettingsMenu

@onready var FocusButton = $CenterContainer/VBoxContainer/ResumeButton
@onready var RestartButton = $CenterContainer/VBoxContainer/RestartLevel
@onready var SettingsButton = $CenterContainer/VBoxContainer/Settings
@onready var QuitButton = $CenterContainer/VBoxContainer/QuitToMenu

func _ready():
	#$CenterContainer/VBoxContainer/ResumeButton.grab_focus()
	hide()

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		visible = !visible
	
	#if SettingsMenu.visible: # Prevents selecting while the settings are up
		#return
	#if Input.is_action_just_pressed("left_up_p1") and visible:
		##print("You pressed up")
		#move_arrow(-1)
	#if Input.is_action_just_pressed("left_down_p1") and visible:
		#move_arrow(1)
	#
	#if Input.is_action_just_pressed("confirm") and visible:
		#call(button_functions[selected_space])
		
	if Input.is_action_just_pressed("cancel") and visible:
		hide()

#func move_arrow(dir: int):
	#selected_space += dir
	#if selected_space > 3:
		#selected_space = 0
	#elif selected_space < 0:
		#selected_space = 3
	#
	#Highlighter.position.y = positions[selected_space]

func _on_resume_button_pressed():
	hide()
func _on_restart_level_pressed():
	get_tree().reload_current_scene()
func _on_settings_pressed():
	SettingsMenu.show()
func _on_quit_to_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/UI/MainMenu.tscn")

func _on_visibility_changed():
	if visible:
		$CenterContainer/VBoxContainer/ResumeButton.grab_focus()
		#print("Pausing")
		if !get_tree().paused:
			get_tree().paused = true
	else:
		#print("Unpausing")
		if get_tree().paused:
			get_tree().paused = false
