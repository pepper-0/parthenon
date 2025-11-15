extends Node

var images = [
	preload("res://nyc.webp"),
	preload("res://bb.jpeg"),
	preload("res://nyc.webp"),
	preload("res://bb.jpeg")
]

var index = 0

func _ready():
	$Sprite2D.texture = images[index]

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		index += 1
		if index < images.size():
			$Sprite2D.texture = images[index]
		else:
			get_tree().change_scene("res://LevelSelect.tscn")
