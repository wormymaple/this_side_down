extends Node

@export var player_scene: PackedScene
@export var camera: NodePath
@export var colors: Array[Color]
@export var damp := 0.0
@export var gravity_scale := 1.0
@export var is_in_water := false

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_num = len(Input.get_connected_joypads())
	
	for i in range(player_num):
		var new_player = player_scene.instantiate();
		add_child(new_player)
		new_player.playerID = "p" + str(i + 1)
		new_player.linear_damp = damp
		new_player.gravity_scale = gravity_scale
		new_player.is_in_water = is_in_water
		get_node(camera).players.append(new_player)
		new_player.set_color(Color.WHITE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
