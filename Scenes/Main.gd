extends Node2D

var coins = 0;
var item1 = load("res://seeds/seed.png")
onready var inventory = $UI/ItemList

func _ready():
	inventory.add_icon_item(item1)

func _process(delta):
	$UI/Coin_Count.text = String(coins)


func _on_ItemList_item_selected(index):
	inventory.remove_item(index)
	
	pass # Replace with function body.
