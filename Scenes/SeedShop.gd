extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var seed_count = 0
var seeds = load("res://Resources/seeds.tres")
onready var main = get_tree().get_root().get_node("Main")
var transparent = load("res://Assets/transparent.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NextSeed_pressed():
	if seed_count == seeds.name.size(): return
	print(seeds.name.size())
	print(seed_count)
	if main.coins - seeds.unlock_cost[seed_count] > 0:
		get_tree().get_root().get_node("Main").add_to_inventory(seed_count)
		seed_count += 1
		if seed_count == seeds.name.size(): 
			texture_normal = transparent
			return 
		texture_normal = seeds.texture[seed_count]
	
	print("yes")
