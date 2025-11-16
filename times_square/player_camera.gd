class_name PlayerCamera extends Camera2D

@export var tilemap: TileMapLayer

func _ready() -> void:
	setup_camera_limits(tilemap.get_used_rect())

func setup_camera_limits(rect: Rect2i) ->  void: 
	pass
	#limit_left = rect.position.x
	#limit_right = (rect.position.x + rect.size.x) * 12
	#limit_bottom = (rect.position.y + rect.size.y) * 12
