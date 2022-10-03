extends ItemList
var power_textures_1 = load("res://Assets/Powerups/power1.png")
var power_textures_3 = load("res://Assets/Powerups/power2.png")
var power_textures_2 = load("res://Assets/Powerups/power3.png")
var power_textures = [power_textures_1, power_textures_2, power_textures_3]
var bought = []
var seed_number = 2
onready var main = get_tree().get_root().get_node("Main")
onready var time_freeze = main.get_node("Powerup_Timers").get_node("Time_freeze")
onready var timers_node = get_tree().get_root().get_node("Main/Timers")
func _ready():
	for i in range(3):
		bought.append(false)
		add_icon_item(power_textures[i])
#		set_item_selectable(i, false)


func _on_Shop_item_selected(index):
	if is_item_disabled(index): return
#	print(time_freeze.is_stopped())
#	print(time_freeze.time_left)
	if(index == 0 and (main.coins - 10000)>0 and time_freeze.is_stopped()):
		main.coins -= 10000
		main.time_freeze_powerup()
		powerup_ran(10)
	if(index == 1 and (main.coins - 50000)>0):
		main.coins -= 50000
		main.discount()
		powerup_ran(10)
	if(index == 2 and (main.coins - 100000)>0):
		main.coins -= 100000
		main.income_double_ten_sec()
		powerup_ran(10)
#		get_tree().get_root().get_node("Main").add_to_inventory(index)
#	unselect_all()
func powerup_ran(time):
	var timer = Timer.new()
	timer.connect("timeout", self,"_on_cooldown_timeout", [time, timer]) 
	timer.wait_time = time
	timer.autostart = true
	timers_node.add_child(timer)
	for i in range(3):
		set_item_disabled(i, true)

func _on_cooldown_timeout(time, timer):
	for i in range(3):
		set_item_disabled(i, false)
	timer.queue_free()
	
#
#func _process(_delta):
#	for i in range(seed_number):
#		if(main.coins - main.unlock_cost[i]>0):
#			set_item_selectable(i, false)
#		else:
#			set_item_selectable(i, true)
