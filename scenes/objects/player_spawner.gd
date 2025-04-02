extends Node

@export var player_scene: PackedScene
@export var camera: NodePath
@export var damp := 0.0
@export var gravity_scale := 1.0
@export var is_in_water := false

func _ready():
	var player_num = len(Input.get_connected_joypads())
	
	if player_num == 0 and not GlobalVariables.player_0_playing:
		get_node(camera).get_child(0).show()
		print("There aren't any controller connected and keyboard isn't an option")
		return
	
	for i in range(player_num + 1): # Adds a player for each joypad
		print("Adding player")
		if not GlobalVariables.player_0_playing and i == 0:
			print("Nevermind, the player isn't using the keyboard")
			continue
		
		var new_player = player_scene.instantiate();
		
		new_player.playerID = "p" + str(i)
		new_player.linear_damp = damp
		new_player.gravity_scale = gravity_scale
		new_player.is_in_water = is_in_water
		new_player.set_color(i)
		new_player.position.x += i * 50
		new_player.get_child(5).set_seed(i * 500) # Child 5 is the bubble particle emitter
		print(new_player.get_child(5).get_seed())
		add_child(new_player)
		get_node(camera).players.append(new_player)
