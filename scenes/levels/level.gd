extends Node2D

# I could honestly just move this to the LandingZone and then I wouldn't need this script
@export var Song := ThemeSongLoop.Songs.BOX_IN_SOCKS 

func _ready():
	ThemeSongLoop.song_to_play_next = Song
