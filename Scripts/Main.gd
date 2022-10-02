extends Node2D

var planting_costs = [100, 200] 
var crop_value = [200, 500]
var unlock_cost = [0, 1500]
var crops = []


var coins = 1000;
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
	crop_array_init()
	cells = tiles.get_used_cells()
	print(seeds.name[0])
	print(tiles.get_cell(0,0))

func crop_array_init():
	for x in range(10):
		crops.append([])
		for y in range(10):
			crops[x].append(0)
func _process(delta):
	$UI/Coin_Count.text = "$" + String(coins)
	
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		var pos = tiles.world_to_map(tiles.get_local_mouse_position())
		if cells.has(pos):
			var cell_type = tiles.get_cellv(pos)
			if cell_type == 1 and mouse.seed_holding != 0:
				plant_crop(pos, mouse.seed_holding - 1)
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var pos = tiles.world_to_map(tiles.get_local_mouse_position())
		if cells.has(pos):
			var cell_type = tiles.get_cellv(pos)
			if seeds.tile_index_grown.has(cell_type):
				collect_crop(pos)

func save_crop(pos,crop_type):
	crops[pos.x][pos.y] = crop_type

func get_crop_type(pos):
	return crops[pos.x][pos.y]

func _unhandled_input(event):
	if event.is_pressed():
		if mouse.texture != null and event.is_action("click"):
			_on_ItemList_nothing_selected()
		var pos = tiles.world_to_map(tiles.get_local_mouse_position())
		if cells.has(pos):
			var cell_type = tiles.get_cellv(pos)
			if cell_type == 2: 
				planting_mode = false
			elif cell_type == 1:
				planting_mode = true

func plant_crop(crop_pos, crop_type):
	if(coins - planting_costs[crop_type]>=0):
		coins -= planting_costs[crop_type]
		tiles.set_cellv(crop_pos, seeds.tile_index_seed[crop_type])
		save_crop(crop_pos, crop_type)
		var timer = Timer.new()
		timer.connect("timeout",self,"_on_timer_1_timeout", [crop_pos, timer, 2.0, crop_type]) 
		timer.wait_time = 2.0
		timer.autostart = true
		timers_node.add_child(timer)

func _on_timer_1_timeout(pos, timer_node, time, crop_type):
	print("timer 1 timeout")
	timer_node.queue_free()
	tiles.set_cellv(pos, seeds.tile_index_growing[crop_type])
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_2_timeout", [pos, timer, crop_type]) 
	timer.wait_time = time
	timer.autostart = true
	timers_node.add_child(timer)

func _on_timer_2_timeout(pos, timer_node, crop_type):
	print("timer 2 timeout")
	tiles.set_cellv(pos, seeds.tile_index_grown[crop_type])
	timer_node.queue_free()

func collect_crop(crop_pos):
	coins += crop_value[get_crop_type(crop_pos)]
	tiles.set_cellv(crop_pos, 1)

func add_to_inventory(seed_num):
	if(coins - unlock_cost[seed_num]>=0):
		$UI/Shop.set_item_disabled(seed_num, true)
		inventory.add_icon_item(seeds.texture[seed_num])
		items_in_list.append(seeds.texture[seed_num])
		coins -= unlock_cost[seed_num]

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
		

