extends Label

var messages = ["Killed", "Hung", "Executed", "Thrown in Prison", "Eaten By Lions", "Left to Die"]
var rng = RandomNumberGenerator.new()
func _ready():
	rng.set_seed(7340651920651)
	for i in range(10):
		randomize()
		rng.randomize()
	var key = rng.randi_range(0, messages.size()-1)
	text = "You Got " + messages[key]
