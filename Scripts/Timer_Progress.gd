extends ProgressBar

var rnd = 0
onready var req_coin_label = get_tree().get_root().get_node("Main/UI/Required_Coins")

func _process(_delta):
	value = $Quota_Timer.time_left

func _on_Quota_Timer_timeout():
	rnd += 1
	req_coin_label.update_timer(rnd)
	
