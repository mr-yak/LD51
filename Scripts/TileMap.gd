extends TileMap
#
#var planting_mode = false
#var cells
#onready var timers_node = get_tree().get_root().get_node("Main/Timers")
#
func _ready():
	pass
#	cells = get_used_cells()
#
#func _on_timer_timeout(pos, timer_node):
#	timer_node.queue_free()
#	set_cellv(pos, 2)
#
#func _unhandled_input(event):
#	if event.is_pressed():
#		var pos = world_to_map(get_local_mouse_position())
#		if cells.has(pos):
#			var cell_type = get_cellv(pos)
#			if cell_type == 2: 
#				planting_mode = false
#			elif cell_type == 0:
#				planting_mode = true
#
#func _process(delta):
#	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
#		var pos = world_to_map(get_local_mouse_position())
#		if cells.has(pos):
#			var cell_type = get_cellv(pos)
#			if cell_type == 2 and planting_mode == false:
#				collect_crop(pos)
#			elif cell_type == 0 and planting_mode:
#				plant_crop(pos)
#
#func plant_crop(crop_pos):
#	set_cellv(crop_pos, 1)
#	var timer = Timer.new()
#	timer.connect("timeout",self,"_on_timer_timeout", [crop_pos, timer]) 
#	timer.wait_time = 10.0
#	timer.autostart = true
#	timers_node.add_child(timer)
#
#func collect_crop(crop_pos):
#	set_cellv(crop_pos, 0)
#	get_parent().coins += 1
#	print("crop should be collected now (TODO)")
#
