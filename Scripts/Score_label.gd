extends Label


func _ready():
	text = "You survived until round " + String(get_tree().get_root().get_node("Score").score)
