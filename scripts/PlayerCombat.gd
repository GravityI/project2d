extends Area2D

func _process(delta):
	position = $"../Body".position + Vector2(64, -8)
