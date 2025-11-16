extends Node2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		self.queue_free()
		print("aughgghhghgh")
		get_tree().change_scene_to_file("res://home/home.tscn")
