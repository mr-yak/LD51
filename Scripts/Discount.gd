extends Timer

func _on_Discount_timeout():
	get_parent().get_parent().discount = 1
