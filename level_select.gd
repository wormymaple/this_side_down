extends Control

var focus_position_x = "far_left"

enum Pos {TOP, MID, BOTTOM}
var positions = [477, 721, 975]
@export var arrow_position := Pos.TOP

func _ready():
	#if ThemeSongLoop.playing:
		#ThemeSongLoop.stop()
	pass

func _process(_delta):
	pass

func _on_button_1_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_2.tscn")


func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_3.tscn")


func _on_button_4_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_4.tscn")


func _on_button_5_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_5.tscn")


func _on_button_6_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_6.tscn")


func _on_button_7_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_7.tscn")


func _on_button_8_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_8.tscn")


func _on_button_9_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_9.tscn")

func _on_button_10_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_10.tscn")


func _on_button_11_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_11.tscn")


func _on_button_12_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_12.tscn")
