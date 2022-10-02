extends Label

var messages = ["Killed", "Hung", "Executed", "Thrown in Prison", "Eaten By Lions", "Left to Die"]
func _ready():
	var key = rand_range(0, messages.size()-1)
	text = "You Got " + messages[key]
