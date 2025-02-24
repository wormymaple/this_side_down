extends Control

@export var lock_list: Array[Sprite2D] # Removed 6 temporarily
@export var select_rect = TextureRect

#var menu_funcs = ['_on_play_button_pressed', '_on_options_button_pressed', '_on_quit_button_pressed']
const positions = [Vector2(45, 333), Vector2(334, 333), Vector2(622, 333), Vector2(913, 333), Vector2(1202, 333), Vector2(1492, 333), Vector2(45, 620), Vector2(334, 620), Vector2(622, 620), Vector2(913, 620), Vector2(1202, 620), Vector2(1492, 620)]
@export var select_rect_position: int = 0


func _ready():
	#if ThemeSongLoop.playing:
		#ThemeSongLoop.stop()
		
	for lock in lock_list:
		if GlobalVariables.completed_levels.has(str(lock.name) as int):
			#lock.queue_free()
			#var parent_of_lock = lock.get_parent()
			for child in lock.get_parent().get_children():
				child.queue_free()

func _process(_delta):
	if Input.is_action_just_pressed("ui_right"):
		move_arrow(1)
	if Input.is_action_just_pressed("ui_left"):
		move_arrow(-1)
	
	if Input.is_action_just_pressed("ui_up"):
		move_arrow(-6) # Minus 6 because the lower row is the second row
	if Input.is_action_just_pressed("ui_down"):
		move_arrow(6)
	
	if Input.is_action_just_pressed("ui_accept"):
		call('_on_button_' + str(select_rect_position + 1) + '_pressed')
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Scenes/UI/MainmenuLevelScene.tscn")
	
	

func move_arrow(dir: int):
	select_rect_position += dir
	if select_rect_position > 11:
		select_rect_position -= 12
	elif select_rect_position < 0:
		select_rect_position += 12
	
	select_rect.global_position = positions[select_rect_position]

func _start_level(level):
	get_tree().change_scene_to_file("res://Scenes/Levels/level_" + str(level) + ".tscn")
	
func _nope(): # This is not used currently
	print("uh uh uh, you didnt say the magic word")

func _on_button_1_pressed():
	ThemeSongLoop.intro1 = true
	ThemeSongLoop.intro2 = false
	ThemeSongLoop.stream = load("res://Audio/BoxInSocksntro.wav")
	ThemeSongLoop.play()
	_start_level(1)

func _on_button_2_pressed():
	if GlobalVariables.completed_levels.has(1):
		ThemeSongLoop.intro1 = true
		ThemeSongLoop.intro2 = false
		ThemeSongLoop.stream = load("res://Audio/BoxInSocksntro.wav")
		ThemeSongLoop.play()
		_start_level(2)

func _on_button_3_pressed():
	if GlobalVariables.completed_levels.has(2):
		ThemeSongLoop.intro1 = true
		ThemeSongLoop.intro2 = false
		ThemeSongLoop.stream = load("res://Audio/BoxInSocksntro.wav")
		ThemeSongLoop.play()
		_start_level(3)

func _on_button_4_pressed():
	if GlobalVariables.completed_levels.has(3):
		ThemeSongLoop.intro1 = false
		ThemeSongLoop.intro2 = true
		ThemeSongLoop.stream = load("res://Audio/AutomaticLabelMakerIntro.mp3")
		ThemeSongLoop.play()
		_start_level(4)

func _on_button_5_pressed():
	if GlobalVariables.completed_levels.has(4):
		ThemeSongLoop.intro1 = false
		ThemeSongLoop.intro2 = true
		ThemeSongLoop.stream = load("res://Audio/AutomaticLabelMakerIntro.mp3")
		ThemeSongLoop.play()
		_start_level(5)

func _on_button_6_pressed():
	if GlobalVariables.completed_levels.has(5):
		ThemeSongLoop.intro1 = false
		ThemeSongLoop.intro2 = true
		ThemeSongLoop.stream = load("res://Audio/AutomaticLabelMakerIntro.mp3")
		ThemeSongLoop.play()
		_start_level(6)

func _on_button_7_pressed():
	if GlobalVariables.completed_levels.has(6):
		_start_level(7)

func _on_button_8_pressed():
	if GlobalVariables.completed_levels.has(7):
		_start_level(8)

func _on_button_9_pressed():
	if GlobalVariables.completed_levels.has(8):
		_start_level(9)

func _on_button_10_pressed():
	#return # Because there level is not made yet
	if GlobalVariables.completed_levels.has(9):
		_start_level(10)

func _on_button_11_pressed():
	if GlobalVariables.completed_levels.has(10):
		_start_level(11)

func _on_button_12_pressed():
	if GlobalVariables.completed_levels.has(11):
		_start_level(12)

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/MainmenuLevelScene.tscn")
