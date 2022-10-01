extends Node2D

var coins = 0;

func _process(delta):
	$UI/Coin_Count.text = String(coins)
