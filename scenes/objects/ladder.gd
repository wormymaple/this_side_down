extends Area2D

enum Themes {BLUE, GREEN, PURPLE}
@export var theme: Themes = Themes.BLUE
@onready var sprite = $LadderSprite

func _ready():
	if theme == Themes.BLUE:
		sprite.texture = load("res://Art/Area3/Ladder.png")
	elif theme == Themes.GREEN:
		sprite.texture = load("res://Art/Area2/Ladder.png")
	elif theme == Themes.PURPLE:
		sprite.texture = load("res://Art/Area4/Ladder.png")
		sprite.scale = Vector2(0.19, 0.19)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.standing_in_ladder = true # What if the player went from one ladder straight into another?

func _on_body_exited(body):
	if body.is_in_group("Player"):
		body.standing_in_ladder = false

#func collide(body, state: bool): # Why make another function?
#	if body.is_in_group("Player"):
#		body.standing_in_ladder = true
