extends Camera2D

var players: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = Vector2.ZERO;
	for player in players:
		pos += player.position
	pos /= len(players)
	
	position = pos	
	
