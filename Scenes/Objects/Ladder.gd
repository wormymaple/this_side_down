extends Area2D

enum Themes {BLUE, GREEN, PURPLE}
@export var theme: Themes = Themes.BLUE
@onready var sprite = $LadderSprite

func _ready():
	if theme == Themes.BLUE:
		sprite.texture = load("res://Art/third level/UI_ladder.png")
	elif theme == Themes.GREEN:
		sprite.texture = load("res://Art/second level/UI_ladder.png")
	elif theme == Themes.PURPLE:
		sprite.texture = load("res://Art/Fourth Level/UI_ladder.png")
		sprite.scale = Vector2(0.19, 0.19)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.standing_in_ladder = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		body.standing_in_ladder = false

#func collide(body, state: bool): # Why make another function?
#	if body.is_in_group("Player"):
#		body.standing_in_ladder = true
