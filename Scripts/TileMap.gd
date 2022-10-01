extends TileMap

var planting_mode = false
var cells
onready var timers_node = get_tree().get_root().get_node("Main/Timers")

func _ready():
	cells = get_used_cells()
#	var timers = [cells.size()]
#	for cell in cells:
#		var index = cells.find(cell)
#		timers.insert(index, Timer.new()) 
#		timers[index].connect("timeout",self,"_on_timer_timeout", [cell]) 
#		timers[index].wait_time = 10.0
#		timers[index].autostart = true
#		timers_node.add_child(timers[index])

func _on_timer_timeout(pos, timer_name):
	print("timer "+ timer_name + "worked: " + String(pos))
	set_cellv(pos, 2)

func _unhandled_input(event):
	if event.is_pressed():
		print(timers_node.get_children())
		var pos = world_to_map(get_local_mouse_position())
		if cells.has(pos):
			var cell_type = get_cellv(pos)
			if cell_type == 2: 
				planting_mode = false
			elif cell_type == 0:
				planting_mode = true

func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var pos = world_to_map(get_local_mouse_position())
		if cells.has(pos):
			var cell_type = get_cellv(pos)
			if cell_type == 2 and planting_mode == false:
				collect_crop(pos)
			elif cell_type == 0 and planting_mode:
				plant_crop(pos)

func plant_crop(crop_pos):
	set_cellv(crop_pos, 1)
	print("yes")
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout", [crop_pos, timer.name]) 
	timer.wait_time = 10.0
	timer.autostart = true
	timers_node.add_child(timer)

func collect_crop(crop_pos):
	set_cellv(crop_pos, 0)
	print("crop should be collected now (TODO)")
	
