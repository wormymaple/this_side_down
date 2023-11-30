extends Control


#Video Settings
@onready var display_options = $SettingTabs/Video/MarginContainer/VideoSettings/OptionButton

#Audio Settings
@onready var master_vol_slider = $SettingTabs/Audio/MarginContainer/AudioSettings/HBoxContainer/MasterVolSlider
@onready var music_vol_Slider = $SettingTabs/Audio/MarginContainer/AudioSettings/HBoxContainer2/MusicVolSlider
@onready var other_vol_slider = $SettingTabs/Audio/MarginContainer/AudioSettings/HBoxContainer3/OtherVolSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta_):
	if Input.is_action_just_pressed("cancel") and visible:
		hide()


func _on_option_button_item_selected(index):
	if index == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


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

const MUSIC_BUS = "Music"
const OTHER_BUS = "Other"


func _on_button_pressed():
	$".".hide()



