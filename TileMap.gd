extends TileMap

var cells
onready var timers_node = get_node(../Main)

func _ready():
	cells = get_used_cells()
	var timers = [cells.size()]
	for cell in cells:
		var index = cells.find(cell)
		timers[index] = Timer.new()
		#$Main/Timers.add_child(timers[index])

func _unhandled_input(event):
	if event.is_pressed():
		var pos = world_to_map(get_local_mouse_position())
		if cells.has(pos):
			set_cellv(pos, 1)
