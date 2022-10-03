extends TextureButton

var seed_count = 0
var seeds = load("res://Resources/seeds.tres")
onready var main = get_tree().get_root().get_node("Main")
onready var text = $Description
var transparent = load("res://Assets/transparent.png")

func _ready():
	text.text = (seeds.name[seed_count] + " tree\nPlanting cost: $" + str(seeds.planting_cost[seed_count]) + "\nUnlock cost: $" + str(seeds.unlock_cost[seed_count]) + "\nValue: $" + str(seeds.value[seed_count]))

func _on_NextSeed_pressed():
	if seed_count == seeds.name.size(): return
	if main.coins - seeds.unlock_cost[seed_count] > 0:
		get_tree().get_root().get_node("Main").add_to_inventory(seed_count)
		seed_count += 1
		if seed_count == seeds.name.size(): 
			texture_normal = transparent
			text.text = ""
			return 
		texture_normal = seeds.texture[seed_count]
		text.text = (seeds.name[seed_count] + " tree\nPlanting cost: $" + str(seeds.planting_cost[seed_count]) + "\nUnlock cost: $" + str(seeds.unlock_cost[seed_count]) + "\nValue: $" + str(seeds.value[seed_count]))
