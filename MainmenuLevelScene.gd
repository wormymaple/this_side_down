extends Control

@onready var settings_menu = $SettingsMenu
#@onready var main_menu = $MainMenu

var arrow_position = "top"

func _ready():
	#if ThemeSongLoop.playing:
		#ThemeSongLoop.stop()
	#$"Play Button".grab_focus()
	
	#var left_stick = Input.get_axis("left_left_" + playerID, "left_right_" + playerID)
	#if left_stick != 0:
		#linear_velocity.x = left_stick * move_speed
	$Arrow.hide()

func _process(delta):
	if Input.is_action_just_pressed("left_up_p1"):
		print("you pressed up")
		if $Arrow.visible == false:
			$Arrow.show()
			return
		else:
			if arrow_position == "top": # is 477
				return
			if arrow_position == "middle": # is 721
				$Arrow.position.y = 477 
				arrow_position = "top"
			if arrow_position == "bottom": # is 975
				$Arrow.position.y = 721
				arrow_position = "middle"
	if Input.is_action_just_pressed("left_down_p1"):
		print("You pressed down")
		if $Arrow.visible == false:
			$Arrow.show()
			return
		else:
			if arrow_position == "top": # is 477
				$Arrow.position.y = 721
				arrow_position = "middle"
				return
			if arrow_position == "middle":
				$Arrow.position.y = 975
				arrow_position = "bottom"
			if arrow_position == "bottom":
				return
	
	if Input.is_action_just_pressed("left_trigger_p1"): # left trigger will be confirm
		if arrow_position == "top":
			get_tree().change_scene_to_file("res://level_select.tscn")
		elif arrow_position == "middle":
			settings_menu.show()
		elif arrow_position == "bottom":
			get_tree().quit()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://level_select.tscn")

func _on_options_button_pressed():
	settings_menu.show()

func _on_quit_button_pressed():
	get_tree().quit()
	

func _on_joy_connection_changed(device_id, connected):
	if connected:
		print(Input.get_joy_name(device_id))
	else:
		print("Keyboard")
