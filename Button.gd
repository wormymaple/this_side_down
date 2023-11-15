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
	get_tree().change_scene_to_file("res://Scenes/Levels/level_2.tscn")


func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_3.tscn")


func _on_button_4_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_4.tscn")


func _on_button_5_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_5.tscn")
