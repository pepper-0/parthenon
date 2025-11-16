extends Node2D

@export var pipe_scene: PackedScene = preload("res://bridge-pipe.tscn")
@export var spacing: float = 300
@export var scroll_speed: float = 200
@export var gap_size: float = 200
@export var vertical_range: float = 150

var pipe_count: int = 0
var active_pipes: Array = []
var main_scene: Node = null

func _ready():
	main_scene = get_parent()
	for i in range(3):
		spawn_pipe()

func _process(delta):
	var player_x = main_scene.get_node("CharacterBody2D").position.x

	for pair in active_pipes:
		pair.top.position.x -= scroll_speed * delta
		pair.bottom.position.x -= scroll_speed * delta

	recycle_pipes()

func spawn_pipe():
	var top_pipe = pipe_scene.instantiate()
	var bottom_pipe = pipe_scene.instantiate()
	add_child(top_pipe)
	add_child(bottom_pipe)

	var top_sprite = top_pipe.get_node("BridgePipe")
	var bottom_sprite = bottom_pipe.get_node("BridgePipe")
	top_sprite.scale.y = -1

	var viewport_width = get_viewport_rect().size.x
	var y_offset = randf_range(-vertical_range, vertical_range)
	var spawn_x = viewport_width + pipe_count * spacing
	var gap_center_y = get_viewport_rect().size.y * 0.5 + y_offset
	var sprite_height = top_sprite.texture.get_height()

	top_pipe.position = Vector2(spawn_x, gap_center_y - gap_size * 0.5 - sprite_height)
	bottom_pipe.position = Vector2(spawn_x, gap_center_y + gap_size * 0.5)

	active_pipes.append({
		"top": top_pipe,
		"bottom": bottom_pipe
	})

	pipe_count += 1

func recycle_pipes():
	if active_pipes.is_empty():
		return

	var pair = active_pipes[0]
	var sprite_width = pair.top.get_node("BridgePipe").texture.get_width()
	if pair.top.position.x < -sprite_width:
		pair.top.queue_free()
		pair.bottom.queue_free()
		active_pipes.pop_front()
		spawn_pipe()
