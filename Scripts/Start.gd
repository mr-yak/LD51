extends Button



func _on_Button_button_up():
	get_tree().get_root().get_node("Menu/Sounds/ButtonSFX").play()

func _on_ButtonSFX_finished():
	var x = get_tree().change_scene("res://Scenes/Farm.tscn")
