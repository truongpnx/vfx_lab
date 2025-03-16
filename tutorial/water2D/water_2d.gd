@tool
extends Sprite2D

func calculate_aspect_ratio():
	print("okie")
	material.set_shader_parameter("aspect_ratio", scale.y / scale.x)
	#material.set_instance_shader_parameter("aspect_ratio", scale.y / scale.x)
