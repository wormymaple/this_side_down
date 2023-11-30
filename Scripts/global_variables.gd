extends Node

var completed_levels: Array[int]

var is_ok = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func win_level(level: int):
	is_ok = true
	for number in completed_levels:
		if number == level:
			is_ok = false
			print("already won that level")
	if is_ok:
		completed_levels.append(level)
		print(completed_levels)
	
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scenes/Levels/level_" + str(level + 1) + ".tscn")
	
