extends Button



func _on_Button_button_up():
	get_tree().get_root().get_node("Death/Sounds/ButtonSFXReplay").play()

func _on_ButtonSFXReplay_finished():
	var x = get_tree().change_scene("res://Scenes/Farm.tscn")
