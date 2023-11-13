extends Node

@export var player_scene: PackedScene
@export var camera: NodePath

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_num = len(Input.get_connected_joypads())
	
	for i in range(player_num):
		var new_player = player_scene.instantiate();
		add_child(new_player)
		new_player.playerID = "p" + str(i + 1)
		get_node(camera).players.append(new_player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
