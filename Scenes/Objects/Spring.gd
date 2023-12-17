extends Area2D

enum Themes {YELLOW, GREEN, BLUE}
@export var theme: Themes = Themes.YELLOW
enum State {DONE, IN, OUT}
var current_state: State = State.DONE
@export var Power: int = 700
@onready var sprite = $Sprite2D

func _ready():
	if theme == Themes.YELLOW:
		sprite.texture = load("res://Art/First Level/UI_spring.png")
	elif theme == Themes.BLUE:
		sprite.texture = load("res://Art/third level/UI_spring.png")
	elif theme == Themes.GREEN:
		sprite.texture = load("res://Art/second level/UI_spring.png")

func _process(_delta):
	# This makes the spring stretch when something bounces on it
	if current_state == State.IN:
		if scale.y > 0.5:
			scale.y -= .1
			position.y += 8.5 # 42.5 pixels down
		else:
			current_state = State.OUT
	elif current_state == State.OUT:
		if scale.y < 2:
			scale.y += .1
			position.y -= 8.16667 # up 122.5 pixels
		else: current_state = State.DONE
	elif current_state == State.DONE:
		if scale.y > 1:
			scale.y -= .1
			position.y += 8 # down 80

func _on_body_entered(body):
	if body.is_in_group("Player") or body.is_in_group("Box"):
		#print(abs(asin(rotation)))
		if body.is_in_group("Player"):
			body.unmovable = abs(asin(rotation)) > 0.1
		
		current_state = State.IN
		var dir = Vector2(asin(rotation), -acos(rotation)).normalized()
		body.linear_velocity = dir * Power
		$AudioStreamPlayer.play() # change for a more springy sound later
