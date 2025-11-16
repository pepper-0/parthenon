extends Label

var score = 0

func update_score():
	text = str(score)
	if score >= 20:
		get_tree().change_scene("res://HomeScreen.tscn")
