extends TileMap

var cells
onready var timers_node = get_tree().get_root().get_node("Main/Timers")

func _ready():
	cells = get_used_cells()
	var timers = [cells.size()]
	for cell in cells:
		var index = cells.find(cell)
		timers.insert(index, Timer.new()) 
		timers[index].autostart = true
		timers[index].wait_time = 10.0
		timers_node.add_child(timers[index])

func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var pos = world_to_map(get_local_mouse_position())
		if cells.has(pos):
			set_cellv(pos, 1)
