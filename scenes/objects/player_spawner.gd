extends Node

@export var player_scene: PackedScene
@export var camera: NodePath
@export var damp := 0.0
@export var gravity_scale := 1.0
@export var is_in_water := false

func _ready():
	var player_num = len(Input.get_connected_joypads())
	
	for i in range(player_num): # Adds a player for each joypad
		var new_player = player_scene.instantiate();
		
		new_player.playerID = "p" + str(i + 1)
		new_player.linear_damp = damp
		new_player.gravity_scale = gravity_scale
		new_player.is_in_water = is_in_water
		new_player.set_color(i)
		new_player.position.x += i * 50
		new_player.get_child(5).set_seed(i * 500) # Child 5 is the bubble particle emitter
		print(new_player.get_child(5).get_seed())
		add_child(new_player)
		get_node(camera).players.append(new_player)
