extends Node
## These variables need to be saved between play sessions
var last_beaten_level = 0
var bus_master_vol = 0.0
var bus_music_vol = 0.0
var bus_effects_vol = 0.0

## These ones don't need to be saved
var player_0_playing = true
var player_1_playing = false
var player_2_playing = false
var player_3_playing = false
var player_4_playing = false
var number_of_players = 0

func save_data():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	
	save_file.store_8(last_beaten_level)
	save_file.store_float(bus_master_vol)
	save_file.store_float(bus_music_vol)
	save_file.store_float(bus_effects_vol)
	
	save_file.flush() # I shouldn't need to do this but I am being full/perfect/exact/clear/concise
	print("Data saved!")

func load_data():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	
	if not FileAccess.file_exists("user://savegame.save"):
		
		print("No save data found!")
		clear_save()
		return
	
	last_beaten_level = save_file.get_8()
	bus_master_vol = save_file.get_float()
	bus_music_vol = save_file.get_float()
	bus_effects_vol = save_file.get_float()
	
	AudioServer.set_bus_volume_db(0, bus_master_vol)
	AudioServer.set_bus_volume_db(1, bus_music_vol)
	AudioServer.set_bus_volume_db(2, bus_effects_vol)
	
	print("Save data loaded!")

func clear_save():
	
	last_beaten_level = 0
	
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_file.store_8(last_beaten_level)
	save_file.flush()
	print("Data cleared!")
	
	#get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

func _ready() -> void:
	load_data()
	
	#print("music bus volume: ", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))

func win_level(level_cleared):
	print("Level #", level_cleared, " beaten")
	if level_cleared > last_beaten_level:
		
		last_beaten_level = level_cleared
		save_data()
	
	await get_tree().create_timer(2).timeout # Give the fade in time to...fade
	
	if level_cleared != 12: 
		get_tree().change_scene_to_file("res://scenes/levels/level_" + str(level_cleared + 1) + ".tscn")
	else: # Take me to the credits!
		get_tree().change_scene_to_file("res://scenes/menus/credits.tscn")
