extends Node2D

var coins = 0;
var item1 = load("res://seeds/seed.png")
var seeds = load("res://Resources/seeds.tres")
onready var mouse = get_tree().get_root().get_node("Main/UI/MouseFollow")
onready var inventory = $UI/ItemList
onready var tiles = $TileMap
var items_in_list = []

var planting_mode = false
var cells
onready var timers_node = get_tree().get_root().get_node("Main/Timers")

func _ready():
	cells = tiles.get_used_cells()
	print(seeds.name[0])

func _process(delta):
	$UI/Coin_Count.text = String(coins)
	
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		var pos = tiles.world_to_map(tiles.get_local_mouse_position())
		if cells.has(pos):
			var cell_type = tiles.get_cellv(pos)
			if cell_type == 0 and planting_mode and mouse.seed_holding != 0:
				plant_crop(pos, mouse.seed_holding)
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var pos = tiles.world_to_map(tiles.get_local_mouse_position())
		if cells.has(pos):
			var cell_type = tiles.get_cellv(pos)
			if cell_type == 2 and planting_mode == false:
				collect_crop(pos)

func _on_timer_timeout(pos, timer_node):
	timer_node.queue_free()
	tiles.set_cellv(pos, 2)

func _unhandled_input(event):
	if event.is_pressed():
		if mouse.texture != null and event.is_action("click"):
			_on_ItemList_nothing_selected()
		var pos = tiles.world_to_map(tiles.get_local_mouse_position())
		if cells.has(pos):
			var cell_type = tiles.get_cellv(pos)
			if cell_type == 2: 
				planting_mode = false
			elif cell_type == 0:
				planting_mode = true

func plant_crop(crop_pos, crop_type):
	tiles.set_cellv(crop_pos, 1)
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout", [crop_pos, timer]) 
	timer.wait_time = 10.0
	timer.autostart = true
	timers_node.add_child(timer)

func collect_crop(crop_pos):
	tiles.set_cellv(crop_pos, 0)
	coins += 1

func add_to_inventory(seed_num):
	inventory.add_icon_item(seeds.texture[seed_num])
	items_in_list.append(seeds.texture[seed_num])

func _on_ItemList_item_selected(index):
	if mouse.texture != null:
		inventory.add_icon_item(mouse.texture)
	mouse.texture = inventory.get_item_icon(index)
	inventory.remove_item(index)
	mouse.seed_holding = 1

func _on_ItemList_nothing_selected():
	inventory.add_icon_item(mouse.texture)
	mouse.texture = null
	mouse.seed_holding = 0
	inventory.clear()
	for i in items_in_list:
		inventory.add_icon_item(i)
		

