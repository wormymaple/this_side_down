extends Node2D

@export var curve: Curve
@export var anim_time: float
var anim_current = 0.0

@export var move: Vector2
@export var intensity: float
@onready var start_pos = position

func _ready():
	pass # Replace with function body.

func _process(delta):
	anim_current += delta
	if anim_current > anim_time:
		anim_current -= anim_time
	
	position = start_pos + move * intensity * curve.sample(anim_current / anim_time)
