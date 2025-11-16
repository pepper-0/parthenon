extends Node2D

@export var pipe_texture: Texture2D
@export var spacing: float = 300
@export var scroll_speed: float = 200
@export var max_pipes: int = 100
@export var gap_size: float = 300
@export var vertical_range: float = 150

var pipe_count: int = 0
var active_pipes: Array = []
var main_scene: Node = null

var pipe_scene = preload("res://pipe.tscn")  # Make sure this is your pipe scene

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
		prints(top_pipe.has_meta("scored"), top_pipe.position.x, player_x)
		
		if not top_pipe.has_meta("scored") and top_pipe.position.x < player_x:
			top_pipe.set_meta("scored", true)

			# Update main_scene score
 			#if not main_scene.has_variable("score"):
				#main_scene.score = 0
			main_scene.score += 1

			# Update label
			var score_label = main_scene.get_node("ScoreLabel")
			score_label.text = str(main_scene.score)

			print("?JGKFNd")
			# Win condition
			if main_scene.score >= 7:
				get_tree().change_scene_to_file("res://end/end.tscn")

	# Recycle pipes
	recycle_pipes()

func spawn_pipe():
	if pipe_count >= max_pipes:
		return

	# Instantiate top and bottom pipes
	var top_pipe = pipe_scene.instantiate()
	top_pipe.level = "brooklyn"
	var bottom_pipe = pipe_scene.instantiate()
	bottom_pipe.level = "brooklyn"

	top_pipe.scale.y = -1
	add_child(top_pipe)
	add_child(bottom_pipe)

	#top_pipe.set_meta("scored", false)

	var y_offset = randf_range(-vertical_range, vertical_range)
	var viewport_width = get_viewport_rect().size.x
	var spawn_x = viewport_width + pipe_count * spacing
	var gap_center_y = get_viewport_rect().size.y / 2 + y_offset

	top_pipe.position = Vector2(spawn_x, gap_center_y - gap_size / 2 - 512)
	bottom_pipe.position = Vector2(spawn_x, gap_center_y + gap_size / 2)

	active_pipes.append(top_pipe)
	active_pipes.append(bottom_pipe)

	pipe_count += 1

func recycle_pipes():
	while active_pipes.size() >= 2:
		var top = active_pipes[0]
		var bottom = active_pipes[1]
		if top.position.x < -32:
			active_pipes.pop_front()
			active_pipes.pop_front()
			top.queue_free()
			bottom.queue_free()
			spawn_pipe()
		else:
			break
