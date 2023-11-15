extends Control


#Video Settings
@onready var display_options = $SettingTabs/Video/MarginContainer/VideoSettings/OptionButton

#Audio Settings
@onready var master_vol_slider = $SettingTabs/Audio/MarginContainer/AudioSettings/HBoxContainer/MasterVolSlider
@onready var music_vol_Slider = $SettingTabs/Audio/MarginContainer/AudioSettings/HBoxContainer2/MusicVolSlider
@onready var other_vol_slider = $SettingTabs/Audio/MarginContainer/AudioSettings/HBoxContainer3/OtherVolSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_option_button_item_selected(index):
	pass # Replace with function body.


func _on_master_vol_slider_value_changed(value):
	pass # Replace with function body.


func _on_music_vol_slider_value_changed(value):
	pass # Replace with function body.


func _on_other_vol_slider_value_changed(value):
	pass # Replace with function body.
