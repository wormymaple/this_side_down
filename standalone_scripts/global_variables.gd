extends Node

var completed_levels: Array[int]
var farthest_unlocked_level = 1

var player_0_playing = true
var player_1_playing = false
var player_2_playing = false
var player_3_playing = false
var player_4_playing = false

func win_level(level_cleared):
	if level_cleared > farthest_unlocked_level:
		farthest_unlocked_level = level_cleared
	
	await get_tree().create_timer(2).timeout # Give the fade out time to come over
	
	if level_cleared != 12: 
		get_tree().change_scene_to_file("res://scenes/levels/level_" + str(level_cleared + 1) + ".tscn")
	else: # Take me to the credits!
		get_tree().change_scene_to_file("res://scenes/menus/credits.tscn")
