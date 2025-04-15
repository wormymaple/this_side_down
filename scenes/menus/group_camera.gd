extends Camera2D

## This scene could be combined with the PlayerSpawn script

@onready var NoController = $NoController
@onready var fade = $CanvasLayer/Fade

@export var camera_offset = Vector2(0, -80) # This is only used for level 9 where the player needs to look up

var players: Array

var min_dist = 250
var max_zoom_in = 1.5
var scale_rate = 0.0001
var max_zoom_out = 0.6

var fade_time = 1.0
var fade_delay = 0.5
var unfade_speed = 2.0
var fade_time_real: float
var fading = false
var fadout = true

func _ready():
	fade.modulate.a = 1

func _process(delta):
	if fading:
		fade_time_real += delta
		if fade_time_real >= fade_time:
			fade_time_real = fade_time
			fading = false
		
		fade.modulate = Color(1, 1, 1, fade_time_real / fade_time)
		
	elif fadout:
		if fade.modulate.a > 0:
			fade.modulate.a -= delta * unfade_speed
		else:
			fadout = false
	
	if len(players) < 1: 
		if NoController.visible == false:
			NoController.visible = true
		return 
	
	## This calculates the camera to be inbetween all the players
	var pos = Vector2.ZERO
	for player in players:
		pos += player.global_position + camera_offset
	
	global_position = pos / len(players) # Get the average
	
	## Make the camera zoom out based on distance between players. First, find the farthest player.
	var furthest_dist = min_dist #(position - players[0].global_position).length()
	for player in players: # dist check
		var dist = (position - player.global_position).length()
		if dist > furthest_dist:
			furthest_dist = dist 
	
	# The bigger the distance is, the smaller target_zoom should be
	var target_zoom = max_zoom_in - 0.0005 * furthest_dist # * scale_rate * 100 + max_zoom_in
	target_zoom = max(target_zoom, max_zoom_out) # Don't go bigger than max zoom!
	
	zoom = target_zoom * Vector2.ONE
	
	#print(furthest_dist)
	#print(target_zoom)
	#print(zoom)

func fade_out(default_delay = false):
	if !default_delay:
		await get_tree().create_timer(fade_delay).timeout;
	fading = true
