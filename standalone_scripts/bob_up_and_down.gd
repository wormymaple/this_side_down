extends Node2D

@export var curve: Curve
@export var anim_time: float

@onready var start_pos = position.y

const INTENSITY = 50

func _process(_delta):
	position.y = start_pos + INTENSITY * curve.sample($"../Timer".time_left / $"../Timer".wait_time)
	
