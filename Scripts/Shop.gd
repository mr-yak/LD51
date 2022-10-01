extends ItemList
var seeds = load("res://Resources/seeds.tres")

func _ready():
	for i in [0,1]:
		add_icon_item(seeds.texture[i])
		


func _on_Shop_item_selected(index):
	unselect(index)
	set_item_disabled(index, true)
	get_tree().get_root().get_node("Main").add_to_inventory(index)
	
