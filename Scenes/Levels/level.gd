extends Node2D

@export var Song := ThemeSongLoop.Songs.BOX_IN_SOCKS

func _ready():
	ThemeSongLoop.song_to_play_next = Song
