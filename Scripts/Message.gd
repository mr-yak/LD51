extends Label

var messages = ["Killed", "Hung", "Executed", "Thrown in\nPrison", "Eaten By Lions", "Left to Die", "Sent to the\nGulag", "Scammed out of\nyour fortune", "Thrown off a\ncliff", "a Heart Attack", "Pushed off a\nBuilding", "Smacked to \nDeath", "Beaten Up"]
var rng = RandomNumberGenerator.new()
func _ready():
	rng.set_seed(7340651920651)
	for i in range(10):
		randomize()
		rng.randomize()
	var key = rng.randi_range(0, messages.size()-1)
	text = "You Got " + messages[key]
