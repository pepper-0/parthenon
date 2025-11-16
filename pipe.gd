extends Area2D

@export var level = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if level == "brooklyn":
		$BridgePipe.visible = true 
		$Pipe.visible = false
	if level == "liberty":
		$BridgePipe.visible = false 
		$Pipe.visible = true



var score = 0


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.restart()
