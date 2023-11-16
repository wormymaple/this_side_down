extends Node2D

@export var curve: Curve
@export var anim_time: float
var anim_current = 0.0

@export var move: Vector2
@export var intensity: float
@onready var start_pos = position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	anim_current += delta
	if anim_current > anim_time:
		anim_current -= anim_time
	
	position = start_pos + move * intensity * curve.sample(anim_current / anim_time)
