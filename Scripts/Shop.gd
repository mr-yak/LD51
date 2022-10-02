extends ItemList
var seeds = load("res://Resources/seeds.tres")
var bought = []
var seed_number = 2
func _ready():
	for i in range(seed_number):
		bought.append(false)
		add_icon_item(seeds.texture[i])
		


func _on_Shop_item_selected(index):
	unselect(index)
	if(!bought[index]):
		bought[index] = true
		get_tree().get_root().get_node("Main").add_to_inventory(index)
	else:
		pass
