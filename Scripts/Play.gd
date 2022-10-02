extends Button

func _on_Play_button_up():
	get_parent().get_node("Sounds/ButtonSFX").play()


func _on_ButtonSFX_finished():
	var x = get_tree().change_scene("res://Scenes/Farm.tscn")
