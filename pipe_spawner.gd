extends Node2D

@export var pipe_texture: Texture2D
@export var spacing: float = 300
@export var scroll_speed: float = 200
@export var max_pipes: int = 100
@export var gap_size: float = 400
@export var vertical_range: float = 150

var pipe_count: int = 0
var active_pipes: Array = []
var main_scene: Node = null

var pipe_scene = preload("res://pipe.tscn")


func _ready():
	main_scene = get_parent()
	for i in range(3):
		spawn_pipe()

func _process(delta):
	# Move pipes left
	for pipe in active_pipes:
		pipe.position.x -= scroll_speed * delta

	# Update score
	var player_x = main_scene.get_node("CharacterBody2D").position.x
	for i in range(0, active_pipes.size(), 2):
		var top_pipe = active_pipes[i]
		if not top_pipe.get_meta("scored") and top_pipe.position.x + pipe_texture.get_width() < player_x:
			top_pipe.set_meta("scored", true)
			main_scene.score += 1
			main_scene.get_node("ScoreLabel").text = str(main_scene.score)

	# Recycle pipes
	recycle_pipes()

func spawn_pipe():
	if pipe_count >= max_pipes:
		return

	var top_pipe = pipe_scene.instantiate()
	top_pipe.level = "brooklyn"
	var bottom_pipe = pipe_scene.instantiate()
	top_pipe.level = "brooklyn"

	top_pipe.scale.y = -1
	add_child(top_pipe)
	add_child(bottom_pipe)

	top_pipe.set_meta("scored", false)

	var y_offset = randf_range(-vertical_range, vertical_range)
	var viewport_width = get_viewport_rect().size.x
	var spawn_x = viewport_width + pipe_count * spacing
	var gap_center_y = get_viewport_rect().size.y / 2 + y_offset

	top_pipe.position = Vector2(spawn_x, gap_center_y - gap_size / 2 - pipe_texture.get_height())
	bottom_pipe.position = Vector2(spawn_x, gap_center_y + gap_size / 2)

	active_pipes.append(top_pipe)
	active_pipes.append(bottom_pipe)

	pipe_count += 1

func recycle_pipes():
	while active_pipes.size() >= 2:
		var top = active_pipes[0]
		var bottom = active_pipes[1]
		if top.position.x < -pipe_texture.get_width():
			active_pipes.pop_front()
			active_pipes.pop_front()
			top.queue_free()
			bottom.queue_free()
			spawn_pipe()
		else:
			break
