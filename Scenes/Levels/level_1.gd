extends Node2D

#@export var landing_zone: RigidBody2D
#@export var camera: Camera2D

#func win():
	#GlobalVariables.win_level(1)
	#get_node(landing_zone).play_particles()
	#camera.fade_out(true)

