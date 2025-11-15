extends Sprite2D

const texture_left = preload("res://assets/player/orpheus-left.png")
const texture_right = preload("res://assets/player/orpheus-right.png")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		texture = texture_left
	elif Input.is_action_just_pressed("right"):
		texture = texture_right
