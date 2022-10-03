extends TextureProgress

var rnd = 0
onready var req_coin_label = get_tree().get_root().get_node("Main/UI/Required_Coins")

func _process(_delta):
	if value != ceil($Quota_Timer.time_left):
		value = ceil($Quota_Timer.time_left)
		get_tree().get_root().get_node("Main/Sounds/TickSFX").play()
		
func _on_Quota_Timer_timeout():
	rnd += 1
	req_coin_label.update_timer(rnd)
	
