extends Control

@export var lock_list: Array[Sprite2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	#if ThemeSongLoop.playing:
		#ThemeSongLoop.stop()
	for lock in lock_list:
		if GlobalVariables.completed_levels.has(str(lock.name) as int):
			lock.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _start_level(level):
	get_tree().change_scene_to_file("res://Scenes/Levels/level_" + str(level) + ".tscn")
	
func _nope():
	print("uh uh uh, you didnt say the magic word")

func _on_pressed():
	_start_level(1)

func _on_button_2_pressed():
	if GlobalVariables.completed_levels.has(1):
		_start_level(2)

func _on_button_3_pressed():
	if GlobalVariables.completed_levels.has(2):
		_start_level(3)

func _on_button_4_pressed():
	if GlobalVariables.completed_levels.has(3):
		_start_level(4)

func _on_button_5_pressed():
	if GlobalVariables.completed_levels.has(4):
		_start_level(5)

func _on_button_6_pressed():
	if GlobalVariables.completed_levels.has(5):
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
	if GlobalVariables.completed_levels.has(9):
		_start_level(10)

func _on_button_11_pressed():
	if GlobalVariables.completed_levels.has(10):
		_start_level(11)

func _on_button_12_pressed():
	if GlobalVariables.completed_levels.has(11):
		_start_level(12)

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://MainmenuLevelScene.tscn")
