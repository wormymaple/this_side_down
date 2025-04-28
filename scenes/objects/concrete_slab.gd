extends RigidBody2D

var can_play_sound = false

func _ready() -> void:
	$Sprite.scale *= scale
	$CollisionPolygon2D.scale *= scale
	#scale = Vector2i(1, 1) # This is done automaticallly by the game engine

func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
			return
	
	if not can_play_sound:
		return
	
	$ImpactSound.play()
	can_play_sound = false
	$Timer.start()

func _on_timer_timeout() -> void:
	can_play_sound = true
