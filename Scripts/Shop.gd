extends ItemList
var seeds = load("res://Resources/seeds.tres")
var bought = []
var seed_number = 2
onready var main = get_tree().get_root().get_node("Main")
func _ready():
	for i in range(seed_number):
		bought.append(false)
		add_icon_item(seeds.texture[i])
		


func _on_Shop_item_selected(index):
	if(!bought[index]):
		bought[index] = true
		get_tree().get_root().get_node("Main").add_to_inventory(index)



func _process(_delta):
	for i in range(seed_number):
		if(main.coins - main.unlock_cost[i]<0):
			set_item_selectable(i, false)
		else:
			set_item_selectable(i, true)
