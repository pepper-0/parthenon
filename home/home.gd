extends Control

func _on_brooklyn_pressed() -> void:
	get_tree().change_scene_to_file("res://brooklyn-bridge.tscn")

func _on_liberty_pressed() -> void:
	get_tree().change_scene_to_file("res://statue-of-liberty.tscn")

func _on_park_pressed() -> void:
	get_tree().change_scene_to_file("res://park/park.tscn")

func _on_ts_pressed() -> void:
	get_tree().change_scene_to_file("res://times_square/times_square.tscn")
