extends TileMap

var cells

func _ready():
	cells = get_used_cells()

func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var pos = world_to_map(get_local_mouse_position())
		if cells.has(pos):
			set_cellv(pos, 1)
