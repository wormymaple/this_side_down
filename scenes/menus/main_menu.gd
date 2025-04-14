extends Control

@export var Level1Button: Button
@export var QuitButton: Button
@export var ControllerBackButton: Button
@export var button_list: Array[Button]
@export var smooth_line: Curve

@export var player_0_playing: CheckBox
@export var player_1_playing: CheckBox
@export var player_2_playing: CheckBox
@export var player_3_playing: CheckBox
@export var player_4_playing: CheckBox

@onready var TitleScreen = $ScrollParent/TitleScreen
@onready var LevelSelect = $ScrollParent/LevelSelect
@onready var ControllerMenu = $ScrollParent/ControllerMenu
@onready var ScrollParent = $ScrollParent
@onready var settings_menu = $SettingsMenu
@onready var FocusButton = $ScrollParent/TitleScreen/HBoxContainer/ButtonPlay
@onready var ControllerToButton = $ScrollParent/TitleScreen/HBoxContainer/ButtonControllers
var locked_icon = preload("res://art/menus/locked_level.PNG")

enum States {TO_LEVELS, FROM_LEVELS, TO_CONTROLLERS, FROM_CONTROLLERS, WAIT}
var slide_mode = States.WAIT

func _ready():
	ControllerToButton.grab_focus()
	
	if OS.get_name() == "Web":
		$ScrollParent/TitleScreen/HBoxContainer/ButtonQuit.hide()
	
	for level in range(0, 12): # Goes from 0-11. Starts at 1 since 1 is always unlocked. Never reaching 12 is fine because there are only 11 textures 
		#print(i)
		if level > GlobalVariables.last_beaten_level:
			button_list[level].disabled = true # -1 because the button list indices start at 0
			button_list[level].icon = locked_icon
	
	player_0_playing.button_pressed = GlobalVariables.player_0_playing
	player_1_playing.button_pressed = GlobalVariables.player_1_playing
	player_2_playing.button_pressed = GlobalVariables.player_2_playing
	player_3_playing.button_pressed = GlobalVariables.player_3_playing
	player_4_playing.button_pressed = GlobalVariables.player_4_playing

func _on_play_button_pressed():
	$Timer.start()
	Level1Button.grab_focus()
	slide_mode = States.TO_LEVELS
	

func _on_back_button_pressed():
	$Timer.start()
	FocusButton.grab_focus()
	slide_mode = States.FROM_LEVELS

func _on_button_controllers_pressed() -> void:
	$Timer.start()
	ControllerBackButton.grab_focus()
	slide_mode = States.TO_CONTROLLERS

func _on_button_back_controller_pressed() -> void:
	$Timer.start()
	ControllerToButton.grab_focus()
	slide_mode = States.FROM_CONTROLLERS


func _on_options_button_pressed():
	settings_menu.show()
func _on_quit_button_pressed():
	get_tree().quit()

func _on_joy_connection_changed(device_id, connected): # This is only for debug
	if connected:
		print(Input.get_joy_name(device_id))
	else:
		print("Keyboard")

func _process(_delta: float) -> void:
	var percent_left = $Timer.time_left / $Timer.wait_time
	
	match slide_mode:
		States.WAIT:
			return
		States.TO_LEVELS:
			ScrollParent.position.x = -1920 * smooth_line.sample(1 - percent_left) # Should make it go to the left
		States.FROM_LEVELS:
			ScrollParent.position.x = -1920 * smooth_line.sample(percent_left)
		States.TO_CONTROLLERS:
			ScrollParent.position.x = 1920 * smooth_line.sample(1 - percent_left)
		States.FROM_CONTROLLERS:
			ScrollParent.position.x = 1920 * smooth_line.sample(percent_left)

func _start_level(level): # I am not sure why this is it's own function
	get_tree().change_scene_to_file("res://scenes/levels/level_" + str(level) + ".tscn")

func _on_button_1_pressed():
	_start_level(1)
func _on_button_2_pressed():
	_start_level(2)
func _on_button_3_pressed():
	_start_level(3)
func _on_button_4_pressed():
	_start_level(4)
func _on_button_5_pressed():
	_start_level(5)
func _on_button_6_pressed():
	_start_level(6)
func _on_button_7_pressed():
	_start_level(7)
func _on_button_8_pressed():
	_start_level(8)
func _on_button_9_pressed():
	_start_level(9)
func _on_button_10_pressed():
	_start_level(10)
func _on_button_11_pressed():
	_start_level(11)
func _on_button_12_pressed():
	_start_level(12)

func _on_timer_timeout() -> void:
	slide_mode = States.WAIT

func _on_check_box_4_toggled(toggled_on: bool) -> void:
	GlobalVariables.player_4_playing = toggled_on
func _on_check_box_3_toggled(toggled_on: bool) -> void:
	GlobalVariables.player_3_playing = toggled_on
func _on_check_box_2_toggled(toggled_on: bool) -> void:
	GlobalVariables.player_2_playing = toggled_on
func _on_check_box_1_toggled(toggled_on: bool) -> void:
	GlobalVariables.player_1_playing = toggled_on
func _on_check_box_0_toggled(toggled_on: bool) -> void:
	GlobalVariables.player_0_playing = toggled_on
