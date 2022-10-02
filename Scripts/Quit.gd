extends Button

func _on_Title_button_up():
	get_tree().get_root().get_node("Death/Sounds/ButtonSFXMenu").play()

func _on_ButtonSFXMenu_finished():
	var x = get_tree().change_scene("res://Scenes/Menu.tscn")
