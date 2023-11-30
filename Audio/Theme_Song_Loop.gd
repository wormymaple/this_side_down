extends AudioStreamPlayer

var intro1 = false
var warehouse = false
var intro2 = false
var yard = false
var outro1 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_finished():
	if intro1 == true:
		stream = load("res://Audio/BoxInSocksLoop.wav")
		play()
		intro1 = false
		warehouse = true
	elif warehouse == true:
		stream = load("res://Audio/BoxInSocksLoop.wav")
		play()
		
	if intro2 == true:
		stream = load("res://Audio/AutomaticLabelMakerLoop.mp3")
		play()
		intro2 = false
		yard = true
	elif yard == true:
		stream = load("res://Audio/AutomaticLabelMakerLoop.mp3")
		play()
		
