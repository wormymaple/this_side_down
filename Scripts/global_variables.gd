extends Node

var completed_levels: Array[int]

var is_ok = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func check_win_condition(bodies):
	for body in bodies:
		if body.is_in_group("Box"):
			if body.get_meta("grabbed"):
				return false
			
			if abs(body.rotation_degrees) < 180 - 35:
				return false
	
	return true

func win_level(level: int):
	if level in completed_levels:
		return
	
	completed_levels.append(level)
	print(completed_levels)
	
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scenes/Levels/level_" + str(level + 1) + ".tscn")
	
