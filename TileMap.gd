extends TileMap

var cells

func _ready():
	cells = get_used_cells()

func _unhandled_input(event):
	if event.is_pressed():
		var pos = world_to_map(get_local_mouse_position())
		if cells.has(pos):
			set_cellv(pos, 1)
