extends ProgressBar

func _ready():
	pass # Replace with function body.

func _process(_delta):
	value = $Quota_Timer.time_left

func _on_Quota_Timer_timeout():
	print(":(")
