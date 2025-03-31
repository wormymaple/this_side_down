extends Area2D

enum Themes {YELLOW, BLUE, GREEN, PURPLE, WHITE}
@export var theme: Themes = Themes.BLUE
@onready var sprite = $LadderSprite

func _ready():
	match theme:
		Themes.YELLOW:
			modulate = Color("c9a338")
		Themes.BLUE:
			modulate = Color("377abd")
		Themes.GREEN:
			modulate = Color("008a5e")
		Themes.PURPLE:
			modulate = Color("482c84")
		Themes.WHITE:
			pass # Stay as white

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.standing_in_ladder += 1 # What if the player went from one ladder straight into another?

func _on_body_exited(body):
	if body.is_in_group("Player"):
		body.standing_in_ladder -= 1
