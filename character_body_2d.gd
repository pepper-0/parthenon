extends CharacterBody2D

@export var jump_force: float = -400
@export var gravity: float = 900

func _physics_process(delta):
	velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_force
	move_and_slide()

func _on_pipe_collision():
	get_tree().change_scene_to_file("res://home/home.tscn")
