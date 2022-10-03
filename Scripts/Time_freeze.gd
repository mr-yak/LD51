extends Timer




func _on_Time_freeze_timeout():
	get_parent().get_parent().time_freeze_timeout()
