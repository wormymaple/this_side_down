extends RigidBody2D

var rng = RandomNumberGenerator.new()
var can_play_sound = false

func _ready() -> void:
	$Sprite.scale *= scale
	$CollisionPolygon2D.scale *= scale
	
	var sprite_version = rng.randi_range(1, 6)
	if sprite_version == 1: 
		pass # The texture will be uncracked, which is what the default is
	elif sprite_version < 4: # 2 and 3
		$Sprite.texture = load("res://art/general/concrete_slab_1.png")
	else:# 4, 5, 6
		$Sprite.texture = load("res://art/general/concrete_slab_3.png")
	
	#scale = Vector2i(1, 1) # This is done automaticallly by the game engine

func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
			return
	#print(self.get_linear_velocity().length())
	#print(get_angular_velocity())
	if not can_play_sound:
		return
	if linear_velocity.length() < 100: # This is flawed because it's highly dependent on rotation, but it's oka
		return
	
	$ImpactSound.play()
	can_play_sound = false
	$Timer.start()

func _on_timer_timeout() -> void:
	can_play_sound = true
