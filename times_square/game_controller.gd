extends Node

#@onready var seller_node = get_node("Seller")
#@onready var dialogue_node = get_node("Seller/Dialogue")

var total_coins: int = 0

func coin_collected(value: int):
	total_coins += value
	EC.emit_signal("coin_collected", total_coins)

func helmet_touched():
	#seller_node.visible = true
	#dialogue_node.visible = true
	EC.emit_signal("helmet_touched")
