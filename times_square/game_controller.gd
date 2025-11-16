extends Node

var total_coins: int = 0

func coin_collected(value: int):
	total_coins += value
	var player = get_tree().current_scene.get_node("Player")
	if player:
		player.set_coin(value)  # update Player’s counter + Label

	EC.emit_signal("coin_collected", total_coins)

func helmet_touched():
	var seller_node = get_tree().current_scene.get_node("Seller")
	var dialogue_node = get_tree().current_scene.get_node("Seller/Dialogue")
	print("Seller node:", seller_node)
	print("Dialogue node:", dialogue_node)
	seller_node.visible = true
	dialogue_node.visible = true
	EC.emit_signal("helmet_touched")
