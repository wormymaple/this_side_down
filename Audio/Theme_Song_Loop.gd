extends AudioStreamPlayer2D

var intro = true
var warehouse = false
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
		warehouse = true
	elif warehouse == true:
		stream = load("res://Audio/BoxInSocksLoop.wav")
		play()
