extends Node

const car = preload("res://EnemyCar.tscn")

func _on_spawnTimer_timeout():
	randomize()
	var newCar = car.instance()
	newCar.position = Vector2(600, $"../CarBody".position.y)
	get_parent().add_child(newCar)
	$"spawnTimer".wait_time = rand_range(6, 8)
