extends Label

var score: int = 0

func add_point():
	score += 1
	update_score()

func update_score():
	text = str(score)
	print("testteestse")
	if score >= 2:
		get_tree().change_scene("res://end/end.tscn")
