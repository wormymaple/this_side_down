extends CanvasLayer

#Display Mode Button
@export var display_options: OptionButton
@export var FocusButton: Button

#Audio Sliders
@export var master_vol_slider: HSlider
@export var music_vol_Slider: HSlider
@export var other_vol_slider: HSlider

const MUSIC_BUS = "Music"
const OTHER_BUS = "Other"

#func _process(_delta_):
	#pass

func _on_button_pressed():
	hide()
	owner.FocusButton.grab_focus()

func _on_option_button_item_selected(index):
	if index == 1: # Fullscreen is 1
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else: # Windowed is 0
		#print(index) 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_visibility_changed() -> void:
	if visible:
		FocusButton.grab_focus()
		
func _on_master_vol_slider_value_changed(value):
	if value == -50:
		AudioServer.set_bus_mute(0,true)
	else:
		AudioServer.set_bus_mute(0,false)
		AudioServer.set_bus_volume_db(0,value)
func _on_music_vol_slider_value_changed(value):
	var BusInt = AudioServer.get_bus_index(MUSIC_BUS)
	AudioServer.set_bus_volume_db(BusInt, value)
func _on_other_vol_slider_value_changed(value):
	var BusInt = AudioServer.get_bus_index(OTHER_BUS)
	AudioServer.set_bus_volume_db(BusInt, value)
	
