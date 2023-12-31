extends Control

@onready var settings_menu = $SettingsMenu

var positions = [597, 848, 1100]
var menu_funcs = ['_on_play_button_pressed', '_on_options_button_pressed', '_on_quit_button_pressed']
@export var arrow_position: int

func _ready():
	#if ThemeSongLoop.playing:
		#ThemeSongLoop.stop()
	#$"Play Button".grab_focus()
	
	#var left_stick = Input.get_axis("left_left_" + playerID, "left_right_" + playerID)
	#if left_stick != 0:
		#linear_velocity.x = left_stick * move_speed
	#$Arrow.hide()
	pass

func _process(_delta):
	if Input.is_action_just_pressed("left_up_p1"):
		move_arrow(-1)
	if Input.is_action_just_pressed("left_down_p1"):
		move_arrow(1)
	
	if Input.is_action_just_pressed("confirm"):
		call(menu_funcs[arrow_position])
	
	
	
func move_arrow(dir: int):
	arrow_position += dir
	if arrow_position > 2:
		arrow_position = 0
	elif arrow_position < 0:
		arrow_position = 2
	
	$Arrow.position.y = positions[arrow_position]

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/level_select.tscn")

func _on_options_button_pressed():
	settings_menu.show()

func _on_quit_button_pressed():
	get_tree().quit()
	

func _on_joy_connection_changed(device_id, connected):
	if connected:
		print(Input.get_joy_name(device_id))
	else:
		print("Keyboard")
