extends Area2D

enum Themes {YELLOW, GREEN, BLUE}
@export var theme: Themes = Themes.YELLOW
enum State {DONE, IN, OUT}
var current_state: State = State.DONE
@export var Power: int = 700
@onready var Sprite = $Sprite2D
@export var platform_to_attach_to: Path2D = null

func _ready():
	if theme == Themes.YELLOW:
		Sprite.texture = load("res://art/area_1/spring.png")
	elif theme == Themes.BLUE:
		Sprite.texture = load("res://art/area_3/spring.png")
	elif theme == Themes.GREEN:
		Sprite.texture = load("res://art/area_4/spring.png")
	
	if platform_to_attach_to != null:
		platform_to_attach_to.objects_to_move.push_back(self)

func _process(delta): # Handle looking stretched ## When I get the spring split I shouldn't need to do this anymore
	
	
	if current_state == State.IN: # Instead of 1, it's 0.082
		if Sprite.scale.y > 0.041:
			Sprite.scale.y -= .2 * delta
			Sprite.position.y += 160 * delta
		else:
			current_state = State.OUT
	elif current_state == State.OUT:
		if Sprite.scale.y < 0.164:
			Sprite.scale.y += .2 * delta
			Sprite.position.y -= 160 * delta # up 122.5 pixels
		else: current_state = State.DONE
	elif current_state == State.DONE:
		if Sprite.scale.y > 0.082:
			Sprite.scale.y -= .2 * delta
			Sprite.position.y += 160 * delta # down 80

func _on_body_entered(body):
	if body.is_in_group("Player") or body.is_in_group("Box"):
		#print(abs(asin(rotation)))
		if body.is_in_group("Player"):
			body.unmovable = abs(asin(rotation)) > 0.1 # Sets if the player can control their direction midair based on the springs rotation
		current_state = State.IN
		
		# var dir = Vector2(asin(rotation), -acos(rotation)).normalized() Old code, didn't work
		body.linear_velocity = Vector2(0, -Power).rotated(rotation)
		$AudioStreamPlayer.play() # change for a more springy sound later
