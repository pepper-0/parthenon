extends CharacterBody2D

@export var gravity = 900.0
@export var jump_strength = -400.0

func _physics_process(delta):
	# Use the built-in velocity directly
	velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_strength

	# Godot 4: move_and_slide() takes no arguments
	move_and_slide()

	# Collision detection
	for i in get_slide_collision_count():
		var collider = get_slide_collision(i).collider
		if collider.name.begins_with("Pipe") or collider.name == "StatueOfLiberty":
			get_tree().change_scene("res://GameOver.tscn")
