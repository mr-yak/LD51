extends Timer



func _on_Income_timeout():
	get_parent().get_parent().income = 1
