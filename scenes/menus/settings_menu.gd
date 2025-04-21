extends CanvasLayer

#Display Mode Button
@export var display_options: OptionButton
@export var FocusButton: Button

#Audio Sliders
@export var MasterSlider: HSlider
@export var MusicSlider: HSlider
@export var EffectSlider: HSlider
@export var DeleteDataContainer: HBoxContainer
@export var SecondSeparator: HSeparator
@export var ControllerRumble: CheckBox

#const MUSIC_BUS = "Music"
#const OTHER_BUS = "Effects"

#func _process(_delta_):
	#pass
func _ready() -> void:
	if not get_meta("on_title_screen"):
		DeleteDataContainer.hide()
		SecondSeparator.hide()
	

func _on_button_pressed():
	hide()
	owner.FocusButton.grab_focus()
	
	GlobalVariables.bus_master_vol = AudioServer.get_bus_volume_db(0)
	GlobalVariables.bus_music_vol = AudioServer.get_bus_volume_db(1)
	GlobalVariables.bus_effects_vol = AudioServer.get_bus_volume_db(2)
	GlobalVariables.save_data()

func _on_option_button_item_selected(index):
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_visibility_changed() -> void:
	if visible:
		FocusButton.grab_focus()
		
		MasterSlider.value = AudioServer.get_bus_volume_db(0)
		MusicSlider.value = AudioServer.get_bus_volume_db(1)
		EffectSlider.value = AudioServer.get_bus_volume_db(2)
		ControllerRumble.button_pressed = GlobalVariables.controller_rumble
		print(GlobalVariables.controller_rumble)

func _on_master_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0,value)
func _on_music_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_db(1, value)
func _on_other_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_db(2, value)
	

func _on_delete_button_pressed() -> void:
	GlobalVariables.clear_save()

func _on_controller_rumble_check_box_toggled(toggled_on: bool) -> void:
	GlobalVariables.controller_rumble = toggled_on
	for controller in Input.get_connected_joypads():
		if GlobalVariables.controller_rumble:
			Input.start_joy_vibration(controller, 1, 1, .2)
