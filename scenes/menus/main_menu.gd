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
@onready var LevelContainer = $ScrollParent/LevelSelect/HBoxContainer/Control/LevelContainer
@onready var LevelBackButton = $ScrollParent/LevelSelect/HBoxContainer/ButtonContainer/ButtonBack
var locked_icon = preload("res://art/menus/locked_level.PNG")

enum ScrollStates {TO_LEVELS, FROM_LEVELS, TO_CONTROLLERS, FROM_CONTROLLERS, WAIT}
var slide_mode = ScrollStates.WAIT
enum LevelScrollStates {TO_TOP, TO_BOTTOM, WAIT}
var levels_slide_mode = LevelScrollStates.WAIT

func _ready():
	await GlobalVariables.load_data()
	Input.connect("joy_connection_changed", _on_joy_connection_changed)
	#Input.joy_connection_changed.connect(_on_joy_connection_changed())
	
	ControllerToButton.grab_focus()
	
	if OS.get_name() == "Web":
		$ScrollParent/TitleScreen/HBoxContainer/ButtonQuit.hide()
	
	for level in range(0, 16): # Goes from 0-11.
		#print(i)
		if level > GlobalVariables.last_beaten_level:
			button_list[level].disabled = true 
			button_list[level].icon = locked_icon
	
	if GlobalVariables.last_beaten_level < 16:
		for level in range(16, 24): # 16-24
			#print(i)
			button_list[level].disabled = true
			button_list[level].icon = locked_icon
		
		$ScrollParent/LevelSelect/HBoxContainer/ButtonContainer/ButtonUp.hide()
		$ScrollParent/LevelSelect/HBoxContainer/ButtonContainer/ButtonDown.hide()
		LevelBackButton.set_focus_previous(".")
		#LevelBackButton.set_focus_neighbor(SIDE_TOP, ".") # Thankfully I don't even need to do this!
	
	player_0_playing.button_pressed = GlobalVariables.player_0_playing
	player_1_playing.button_pressed = GlobalVariables.player_1_playing
	player_2_playing.button_pressed = GlobalVariables.player_2_playing
	player_3_playing.button_pressed = GlobalVariables.player_3_playing
	player_4_playing.button_pressed = GlobalVariables.player_4_playing

func _on_play_button_pressed():
	$Timer.start()
	LevelBackButton.grab_focus()
	slide_mode = ScrollStates.TO_LEVELS

func _on_back_button_pressed():
	$Timer.start()
	FocusButton.grab_focus()
	slide_mode = ScrollStates.FROM_LEVELS

func _on_button_controllers_pressed() -> void:
	$Timer.start()
	ControllerBackButton.grab_focus()
	slide_mode = ScrollStates.TO_CONTROLLERS

func _on_button_back_controller_pressed() -> void:
	$Timer.start()
	ControllerToButton.grab_focus()
	slide_mode = ScrollStates.FROM_CONTROLLERS


func _on_options_button_pressed():
	settings_menu.show()
func _on_quit_button_pressed():
	#await GlobalVariables.save_data()
	get_tree().quit()

func _on_joy_connection_changed(device_id, connected): # This is only for debug
	if connected:
		print(Input.get_joy_name(device_id), " connected.")
	else:
		print(Input.get_joy_name(device_id), " disconnected.")
	
	print(Input.get_connected_joypads())
	var amount_of_controllers = Input.get_connected_joypads().size()
	
	player_1_playing.button_pressed = false
	player_2_playing.button_pressed = false
	player_3_playing.button_pressed = false
	player_4_playing.button_pressed = false
	
	if amount_of_controllers > 0:
		player_1_playing.button_pressed = true
		#$ScrollParent/ControllerMenu/MarginContainer/HBoxContainer/Panel2/VBoxContainer/Automatic.text = Input.get_joy_name(0)
	if amount_of_controllers > 1:
		player_2_playing.button_pressed = true
		#$ScrollParent/ControllerMenu/MarginContainer/HBoxContainer/Panel3/VBoxContainer/Automatic.text = Input.get_joy_name(1)
	if amount_of_controllers > 2:
		player_3_playing.button_pressed = true
		#$ScrollParent/ControllerMenu/MarginContainer/HBoxContainer/Panel4/VBoxContainer/Automatic.text = Input.get_joy_name(2)
	if amount_of_controllers > 3:
		player_4_playing.button_pressed = true
		#$ScrollParent/ControllerMenu/MarginContainer/HBoxContainer/Panel5/VBoxContainer/Automatic.text = Input.get_joy_name(3)
	

func _process(_delta: float) -> void:
	var percent_left = $Timer.time_left / $Timer.wait_time
	
	match slide_mode:
		ScrollStates.WAIT:
			pass
		ScrollStates.TO_LEVELS:
			ScrollParent.position.x = -1920 * smooth_line.sample(1 - percent_left) # Should make it go to the left
		ScrollStates.FROM_LEVELS:
			ScrollParent.position.x = -1920 * smooth_line.sample(percent_left)
		ScrollStates.TO_CONTROLLERS:
			ScrollParent.position.x = 1920 * smooth_line.sample(1 - percent_left)
		ScrollStates.FROM_CONTROLLERS:
			ScrollParent.position.x = 1920 * smooth_line.sample(percent_left)
	
	var level_timer_percent = $LevelTimer.time_left / $LevelTimer.wait_time
	
	match levels_slide_mode:
		LevelScrollStates.WAIT:
			pass
		LevelScrollStates.TO_BOTTOM:
			#print("Scrolling content upwards")
			LevelContainer.position.y = -1048 * smooth_line.sample(1 - level_timer_percent)
		LevelScrollStates.TO_TOP:
			#print("Scrolling content downwards")
			LevelContainer.position.y = -1048 * smooth_line.sample(level_timer_percent)

func start_level(level): # I am not sure why this is it's own function
	#if left(str(level)) == 'b':
		
	get_tree().change_scene_to_file("res://scenes/levels/level_" + str(level) + ".tscn")

func _on_timer_timeout() -> void:
	slide_mode = ScrollStates.WAIT
func _on_level_timer_timeout() -> void:
	if levels_slide_mode == LevelScrollStates.TO_TOP:
		#print(get_node("ScrollParent/LevelSelect/HBoxContainer/Control/LevelContainer/Normal/Button1").name)
		LevelBackButton.set_focus_neighbor(SIDE_RIGHT, "../../Control/LevelContainer/Normal/Button7")#"ScrollParent/LevelSelect/HBoxContainer/Control/LevelContainer/Normal/Button1")
		$ScrollParent/LevelSelect/HBoxContainer/ButtonContainer/ButtonUp.disabled = true
		$ScrollParent/LevelSelect/HBoxContainer/ButtonContainer/ButtonDown.disabled = false
	else:
		LevelBackButton.set_focus_neighbor(SIDE_RIGHT, "../../Control/LevelContainer/Special/Button23")
		$ScrollParent/LevelSelect/HBoxContainer/ButtonContainer/ButtonDown.disabled = true
		$ScrollParent/LevelSelect/HBoxContainer/ButtonContainer/ButtonUp.disabled = false
	levels_slide_mode = LevelScrollStates.WAIT

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
	print(toggled_on)
	GlobalVariables.save_data()

func _on_button_1_pressed():
	start_level(1)
func _on_button_2_pressed():
	start_level(2)
func _on_button_3_pressed():
	start_level(3)
func _on_button_4_pressed():
	start_level(4)
func _on_button_5_pressed():
	start_level(5)
func _on_button_6_pressed():
	start_level(6)
func _on_button_7_pressed():
	start_level(7)
func _on_button_8_pressed():
	start_level(8)
func _on_button_9_pressed():
	start_level(9)
func _on_button_10_pressed():
	start_level(10)
func _on_button_11_pressed():
	start_level(11)
func _on_button_12_pressed():
	start_level(12)
func _on_button_13_pressed() -> void:
	start_level(13)
func _on_button_14_pressed() -> void:
	start_level(14)
func _on_button_15_pressed() -> void:
	start_level(15)
func _on_button_16_pressed() -> void:
	start_level(16)
	
func _on_button_17_pressed() -> void:
	start_level("s1") # Where levels are started with s#
func _on_button_18_pressed() -> void:
	start_level("s2")
func _on_button_19_pressed() -> void:
	start_level("s3")
func _on_button_20_pressed() -> void:
	start_level("s4")
func _on_button_21_pressed() -> void:
	start_level("s5")
func _on_button_22_pressed() -> void:
	start_level("s6")
func _on_button_23_pressed() -> void:
	start_level("s7")
func _on_button_24_pressed() -> void:
	start_level("s8")


func _on_button_down_pressed() -> void:
	#print("Button down pressed!")
	if levels_slide_mode != LevelScrollStates.WAIT:
		return
	levels_slide_mode = LevelScrollStates.TO_BOTTOM
	$LevelTimer.start()


func _on_button_up_pressed() -> void:
	#print("Button up pressed!")
	if levels_slide_mode != LevelScrollStates.WAIT:
		return
	levels_slide_mode = LevelScrollStates.TO_TOP
	$LevelTimer.start()
