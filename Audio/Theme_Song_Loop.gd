extends AudioStreamPlayer

var song_playing = "Box in socks" # I might want to make this use an enum
var song_to_play_next = "Box in socks" # "Automatic label maker"
var song_phase = "intro" # "loop", "outro"

func _ready():
	play()

func _on_finished():
	
	if song_phase == "intro": # The intro can go straight into the outro if the song needs to change
		if song_playing == "Box in socks":
			if song_to_play_next != "Box in socks":
				stream = load("res://Audio/AutomaticLabelMakerIntro.mp3")
				song_playing = "Automatic label maker"
			else:
				stream = load("res://Audio/BoxInSocksLoop.wav")
		else:
			if song_to_play_next != "Automatic label maker":
				stream = load("res://Audio/BoxInSocksIntro.wav")
				song_playing = "Box in socks"
			else:
				stream = load("res://Audio/AutomaticLabelMakerLoop.mp3")
	
	elif song_phase == "loop":
		if song_to_play_next == song_playing: # Then loop
			pass # Will calling play on it without changing it start it again?
			#play() 
		else:
			if song_playing == "Box in socks":
				stream = load("res://Audio/BoxInSocksOutro.wav")
			else:
				stream = load("res://Audio/AutomaticLabelMakerOutro.mp3")
			
	else: # Outro
		if song_to_play_next == "Box in socks":
			stream = load("res://Audio/BoxInSocksIntro.wav")
			song_playing = "Box in socks"
		else:
			stream = load("res://Audio/AutomaticLabelMakerIntro.mp3")
			song_playing = "Automatic label maker"
		
	play()
