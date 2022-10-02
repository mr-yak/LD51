extends Label
var value = 0.0
onready var main = get_tree().get_root().get_node("Main")
func update_timer(x):
	main.coins -= value
	value = truncate(((10000.0  /((1.0 + exp(-1.0/3.0*(x -pow(PI,2)))))) - 140.0) *( pow( x , 0.2)))
	text = "Quota: $" + String(value)
func truncate(input):
	return round(input/10)*10
