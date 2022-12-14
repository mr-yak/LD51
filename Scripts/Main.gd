extends Node2D

var crops = []


var coins = 1000;
var seeds = load("res://Resources/seeds.tres")
var transparent = load("res://Assets/transparent.png")
onready var mouse = get_tree().get_root().get_node("Main/UI/MouseFollow")
onready var inventory = $UI/ItemList
onready var tiles = $TileMap
onready var quota_timer = $UI/Timer_Progress/Quota_Timer
var items_in_list = []
onready var seed_shop = $UI/NextSeed

var cells
onready var timers_node = get_tree().get_root().get_node("Main/Timers")

var income = 1
var discount = 1
onready var frozen_tex = load("res://Resources/Health_Bar/HealthBarFrozen.tres")
onready var normal_tex = load("res://Resources/Health_Bar/HealthBarNormal.tres")

func _ready():
	crop_array_init()
	cells = tiles.get_used_cells()

func crop_array_init():
	for x in range(12):
		crops.append([])
		for _y in range(12):
			crops[x].append(0)
func _process(_delta):
	$UI/Coin_Count.text = "Bank: $" + String(coins)
	
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		var pos = tiles.world_to_map(tiles.get_local_mouse_position())
		if cells.has(pos):
			var cell_type = tiles.get_cellv(pos)
			if cell_type == 1 and mouse.seed_holding != -1:
				plant_crop(pos, mouse.seed_holding)
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var pos = tiles.world_to_map(tiles.get_local_mouse_position())
		if cells.has(pos):
			var cell_type = tiles.get_cellv(pos)
			if seeds.tile_index_grown.has(cell_type):
				collect_crop(pos, seeds.tile_index_grown.find(cell_type))

func save_crop(pos,crop_type):
	crops[pos.x][pos.y] = crop_type

func get_crop_type(pos):
	return crops[pos.x][pos.y]

func _unhandled_input(event):
	if event.is_pressed():
		if mouse.texture != null and event.is_action("click"):
			_on_ItemList_nothing_selected()

func plant_crop(crop_pos, crop_type):
	if(coins - seeds.planting_cost[crop_type]>=0):
		$Sounds/PlantSFX.play()
		coins -= discount*seeds.planting_cost[crop_type]
		tiles.set_cellv(crop_pos, seeds.tile_index_seed[crop_type])
		save_crop(crop_pos, crop_type)
		var timer = Timer.new()
		timer.connect("timeout",self,"_on_timer_1_timeout", [crop_pos, timer, 2.0, crop_type]) 
		timer.wait_time = 2.0
		timer.autostart = true
		timers_node.add_child(timer)
	elif(!$Sounds/RejectSFX.playing):
		$Sounds/RejectSFX.play()

func _on_timer_1_timeout(pos, timer_node, time, crop_type):
	timer_node.queue_free()
	tiles.set_cellv(pos, seeds.tile_index_growing[crop_type])
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_2_timeout", [pos, timer, crop_type]) 
	timer.wait_time = time
	timer.autostart = true
	timers_node.add_child(timer)

func _on_timer_2_timeout(pos, timer_node, crop_type):
	tiles.set_cellv(pos, seeds.tile_index_grown[crop_type])
	timer_node.queue_free()


func collect_crop(crop_pos, crop_index):
	$Sounds/HarvestSFX.play()
	coins += income*seeds.value[crop_index]
	tiles.set_cellv(crop_pos, 1)

func add_to_inventory(seed_num):
	if(coins - seeds.unlock_cost[seed_num]>=0):
		$Sounds/CoinSFX.play()
#		$UI/Shop.set_item_disabled(seed_num, true)
		inventory.add_icon_item(seeds.texture[seed_num])
		items_in_list.append(seeds.texture[seed_num])
		coins -= discount*seeds.unlock_cost[seed_num]
	elif(!$Sounds/RejectSFX.playing):
		$Sounds/RejectSFX.play()



func _on_ItemList_item_selected(index):
	print(index)
	inventory.unselect_all()
	if mouse.texture != null:
		_on_ItemList_nothing_selected()
		return
	mouse.texture = seeds.texture[index]
	inventory.remove_item(index)
	inventory.set_item_icon(index, transparent)
	mouse.seed_holding = index

func _on_ItemList_nothing_selected():
	inventory.add_icon_item(mouse.texture)
	mouse.texture = null
	mouse.seed_holding = -1
	inventory.clear()
	for i in items_in_list:
		inventory.add_icon_item(i)
		


func time_freeze_powerup():
	$Powerup_Timers/Time_freeze.start()
	quota_timer.paused = true
	quota_timer.get_parent().texture_progress = frozen_tex
	
func time_freeze_timeout():
	quota_timer.paused = false
	quota_timer.get_parent().texture_progress = normal_tex
	
	
func discount():
	discount = 0.5
	$Powerup_Timers/Discount.start()

func income_double_ten_sec():
	income = 2
	$Powerup_Timers/Income.start()

 
