extends Node2D

func _on_seller_body_entered(body: Node2D) -> void:
	if body is Player and body.coin_counter >= 10:
		get_tree().change_scene_to_file("res://end/end.tscn")
		var has_helmet = true
		self.queue_free()
