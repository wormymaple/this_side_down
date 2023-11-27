extends AudioStreamPlayer2D

var intro = true
var loop = false
var outro = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_finished():
	if intro == true:
		stream = load("res://Audio/BoxInSocksLoop.wav")
		play()
		intro = false
		loop = true
	elif loop == true:
		play()
