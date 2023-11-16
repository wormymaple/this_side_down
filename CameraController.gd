extends Camera2D

var players: Array

@export var min_dist: float
@export var min_scale: float
@export var scale_rate: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if len(players) < 1:
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
		zoom = ((furthest_dist - min_dist) * scale_rate + min_scale) * Vector2.ONE
	else:
		scale = min_scale * Vector2.ONE
