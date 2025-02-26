extends Control

@export var button_texture_list: Array[TextureRect] # Removed 6 temporarily
@export var select_rect = TextureRect

@export var select_rect_position: int = 0
@export var FocusButton: Button

func _ready():
	FocusButton.grab_focus()
	
	for i in range(GlobalVariables.farthest_unlocked_level - 1): # Because it starts counting at 1 and 1 is already unlocked
		button_texture_list[i+2]
		
		for child in button_texture_list[i+2].get_children():
			child.queue_free()

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/MainMenu.tscn")
	
func _start_level(level): # I am not sure why this is it's own function
	get_tree().change_scene_to_file("res://Scenes/Levels/level_" + str(level) + ".tscn")
	

func _on_button_1_pressed():
	ThemeSongLoop.intro1 = true
	ThemeSongLoop.intro2 = false
	ThemeSongLoop.stream = load("res://Audio/BoxInSocksIntro.wav")
	ThemeSongLoop.play()
	_start_level(1)
func _on_button_2_pressed():
	if GlobalVariables.farthest_unlocked_level >= 2:
		ThemeSongLoop.intro1 = true
		ThemeSongLoop.intro2 = false
		ThemeSongLoop.stream = load("res://Audio/BoxInSocksntro.wav")
		ThemeSongLoop.play()
		_start_level(2)
func _on_button_3_pressed():
	if GlobalVariables.farthest_unlocked_level >= 3:
		ThemeSongLoop.intro1 = true
		ThemeSongLoop.intro2 = false
		ThemeSongLoop.stream = load("res://Audio/BoxInSocksntro.wav")
		ThemeSongLoop.play()
		_start_level(3)
func _on_button_4_pressed():
	if GlobalVariables.farthest_unlocked_level >= 4:
		ThemeSongLoop.intro1 = false
		ThemeSongLoop.intro2 = true
		ThemeSongLoop.stream = load("res://Audio/AutomaticLabelMakerIntro.mp3")
		ThemeSongLoop.play()
		_start_level(4)
func _on_button_5_pressed():
	if GlobalVariables.farthest_unlocked_level >= 5:
		ThemeSongLoop.intro1 = false
		ThemeSongLoop.intro2 = true
		ThemeSongLoop.stream = load("res://Audio/AutomaticLabelMakerIntro.mp3")
		ThemeSongLoop.play()
		_start_level(5)
func _on_button_6_pressed():
	if GlobalVariables.farthest_unlocked_level >= 6:
		ThemeSongLoop.intro1 = false
		ThemeSongLoop.intro2 = true
		ThemeSongLoop.stream = load("res://Audio/AutomaticLabelMakerIntro.mp3")
		ThemeSongLoop.play()
		_start_level(6)
func _on_button_7_pressed():
	if GlobalVariables.farthest_unlocked_level >= 7:
		_start_level(7)
func _on_button_8_pressed():
	if GlobalVariables.farthest_unlocked_level >= 8:
		_start_level(8)
func _on_button_9_pressed():
	if GlobalVariables.farthest_unlocked_level >= 9:
		_start_level(9)
func _on_button_10_pressed():
	if GlobalVariables.farthest_unlocked_level >= 10:
		_start_level(10)
func _on_button_11_pressed():
	if GlobalVariables.farthest_unlocked_level >= 11:
		_start_level(11)
func _on_button_12_pressed():
	if GlobalVariables.farthest_unlocked_level >= 12:
		_start_level(12)
