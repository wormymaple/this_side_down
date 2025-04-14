extends Node

var completed_levels: Array[int]
var last_beaten_level = 0

var clear_data = false

var player_0_playing = true
var player_1_playing = false
var player_2_playing = false
var player_3_playing = false
var player_4_playing = false

var number_of_players = 0

func save_data(furthest_level: int):
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	
	save_file.store_8(furthest_level)
	save_file.flush() # I shouldn't need to do this but I am being safe
	print("Data saved!")

func load_data():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	
	if not FileAccess.file_exists("user://savegame.save"):
		
		print("No save data found!")
		clear_save()
		return
	
	last_beaten_level = save_file.get_8()
	print("Save data loaded!")

func clear_save():
	
	last_beaten_level = 0
	
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_file.store_8(last_beaten_level)
	save_file.flush() # I shouldn't need to do this but I am being safe
	print("Data cleared!")

func _ready() -> void:
	load_data()

func win_level(level_cleared):
	print("Level #", level_cleared, " beaten")
	if level_cleared > last_beaten_level:
		
		last_beaten_level = level_cleared
		save_data(last_beaten_level)
	
	await get_tree().create_timer(2).timeout # Give the fade in time to...fade
	
	if level_cleared != 12: 
		get_tree().change_scene_to_file("res://scenes/levels/level_" + str(level_cleared + 1) + ".tscn")
	else: # Take me to the credits!
		get_tree().change_scene_to_file("res://scenes/menus/credits.tscn")
