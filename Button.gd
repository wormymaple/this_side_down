extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")

func _on_button_2_pressed():
	if LevelsCompleted.level1done == true:
		get_tree().change_scene_to_file("res://Scenes/Levels/level_2.tscn")

func _on_button_3_pressed():
	if LevelsCompleted.level2done == true:
		get_tree().change_scene_to_file("res://Scenes/Levels/level_3.tscn")

func _on_button_4_pressed():
	if LevelsCompleted.level3done == true:
		get_tree().change_scene_to_file("res://Scenes/Levels/level_4.tscn")

func _on_button_5_pressed():
	if LevelsCompleted.level4done == true:
		get_tree().change_scene_to_file("res://Scenes/Levels/level_5.tscn")

func _on_button_6_pressed():
	if LevelsCompleted.level5done == true:
		get_tree().change_scene_to_file("res://Scenes/Levels/level_6.tscn")
	
func _on_button_7_pressed():
	if LevelsCompleted.level6done == true:
		get_tree().change_scene_to_file("res://Scenes/Levels/level_7.tscn")
	
func _on_button_8_pressed():
	if LevelsCompleted.level7done == true:
		get_tree().change_scene_to_file("res://Scenes/Levels/level_8.tscn")
	
func _on_button_9_pressed():
	if LevelsCompleted.level8done == true:
		get_tree().change_scene_to_file("res://Scenes/Levels/level_9.tscn")
	
func _on_button_10_pressed():
	if LevelsCompleted.level9done == true:
		get_tree().change_scene_to_file("res://Scenes/Levels/level_10.tscn")
	
func _on_button_11_pressed():
	if LevelsCompleted.level10done == true:
		get_tree().change_scene_to_file("res://Scenes/Levels/level_11.tscn")
	
func _on_button_12_pressed():
	if LevelsCompleted.level11done == true:
		get_tree().change_scene_to_file("res://Scenes/Levels/level_12.tscn")
