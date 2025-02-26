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
	
	if Input.is_action_just_pressed("ui_cancel") and visible:
		hide()


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
