extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_mouse_entered():
	position.x = 90
	position.y = 450
	show()


func _on_options_button_mouse_entered():
	position.x = 360
	position.y = 700
	show()
	


func _on_quit_button_mouse_entered():
	position.x = 630
	position.y = 950
	show()


func _on_play_button_mouse_exited():
	hide()


func _on_options_button_mouse_exited():
	hide()


func _on_quit_button_mouse_exited():
	hide()
