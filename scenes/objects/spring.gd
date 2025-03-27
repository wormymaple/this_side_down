extends Area2D

enum Themes {YELLOW, GREEN, BLUE, WHITE}
@export var theme: Themes = Themes.YELLOW

@export var Power: int = 700
@export var platform_to_attach_to: Path2D = null
@export var ReleaseCurve: Curve

@onready var ReleaseTimer = $Timer
@onready var Top = $Top
@onready var Bottom = $Bottom

func _ready():
	match theme:
		Themes.YELLOW:
			modulate = Color("c9a338")
		Themes.BLUE:
			modulate = Color("377abd")
		Themes.GREEN:
			modulate = Color("008a5e")
		Themes.WHITE:
			pass # Stay as white
	
	if platform_to_attach_to != null:
		platform_to_attach_to.objects_to_move.push_back(self)

func _process(_delta):
	
	#print((ReleaseTimer.time_left))
	var height = -ReleaseCurve.sample(1 - ReleaseTimer.time_left)
	
	Top.position.y = height # I am technically doing this backwards, but that's okay since the curve is identical both sides
	$Line2D.points[0].y = height + 10
	$Line2D.points[5].y = height + 10
	
	$Line2D.points[1].y = (16 + $Line2D.points[0].y) / 2
	$Line2D.points[4].y = (16 + $Line2D.points[0].y) / 2
	

func _on_body_entered(body):
	if body.is_in_group("Player") or body.is_in_group("Box"):
		
		if body.is_in_group("Player"):
			body.unmovable = abs(asin(rotation)) > 0.1 # Sets if the player can control their direction midair based on the springs rotation
		
		ReleaseTimer.start()
		body.linear_velocity = Vector2(0, -Power).rotated(rotation)
		$AudioStreamPlayer.play() # change for a more springy sound later
