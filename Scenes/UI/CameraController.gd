extends Camera2D

## This scene could be combined with the PlayerSpawn script

@onready var NoController = $NoController
@onready var fade = $CanvasLayer/Fade

var players: Array

var min_dist = 250
var min_scale = 1.5
var scale_rate = -0.0001
var max_scale = 0.8

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
		if !NoController.visible:
			NoController.visible = true
		return 
	
	var pos = Vector2.ZERO;
	for player in players:
		pos += player.global_position
	pos /= len(players)
	
	global_position = pos	
	
	var furthest_player = players[0]
	var furthest_dist = (position - furthest_player.global_position).length()
	for player in players: # dist check
		var dist = (position - player.global_position).length()
		if dist > furthest_dist:
			furthest_player = player
			furthest_dist = dist
		
	if furthest_dist > min_dist:
		var target_zoom = (furthest_dist - min_dist) * scale_rate + min_scale
		if target_zoom < max_scale:
			target_zoom = max_scale
			
		zoom = target_zoom * Vector2.ONE
	else:
		zoom = min_scale * Vector2.ONE

func fade_out(default_delay = false):
	if !default_delay:
		await get_tree().create_timer(fade_delay).timeout;
	fading = true
