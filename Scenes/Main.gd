extends Node2D

var coins = 0;
var item1 = load("res://seeds/seed.png")
onready var mouse = get_tree().get_root().get_node("Main/UI/MouseFollow")
onready var inventory = $UI/ItemList
onready var tiles = $TileMap

var planting_mode = false
var cells
onready var timers_node = get_tree().get_root().get_node("Main/Timers")

func _ready():
	cells = tiles.get_used_cells()
	
	inventory.add_icon_item(item1)

func _process(delta):
	$UI/Coin_Count.text = String(coins)
	
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		var pos = tiles.world_to_map(tiles.get_local_mouse_position())
		if cells.has(pos):
			var cell_type = tiles.get_cellv(pos)
			if cell_type == 2 and planting_mode == false:
				collect_crop(pos)
			elif cell_type == 0 and planting_mode and mouse.seed_holding == 1:
				plant_crop(pos)


func _on_timer_timeout(pos, timer_node):
	timer_node.queue_free()
	tiles.set_cellv(pos, 2)

func _unhandled_input(event):
	if event.is_pressed():
		var pos = tiles.world_to_map(tiles.get_local_mouse_position())
		if cells.has(pos):
			var cell_type = tiles.get_cellv(pos)
			if cell_type == 2: 
				planting_mode = false
			elif cell_type == 0:
				planting_mode = true

func plant_crop(crop_pos):
	tiles.set_cellv(crop_pos, 1)
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout", [crop_pos, timer]) 
	timer.wait_time = 10.0
	timer.autostart = true
	timers_node.add_child(timer)

func collect_crop(crop_pos):
	tiles.set_cellv(crop_pos, 0)
	coins += 1



func _on_ItemList_item_selected(index):
	inventory.remove_item(index)
	mouse.texture = item1
	mouse.seed_holding = 1

func _on_ItemList_nothing_selected():
	inventory.add_icon_item(mouse.texture)
	mouse.texture = null
	mouse.seed_holding = 0
