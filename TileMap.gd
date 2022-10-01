extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cells

# Called when the node enters the scene tree for the first time.
func _ready():
	cells = get_used_cells()
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_pressed():
		var pos = world_to_map(get_local_mouse_position())
		print(pos)
		if cells.has(pos):
			print("True")
			set_cellv(pos, 1)
		else:
			print("False")
#	print('ye')
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
