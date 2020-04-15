extends Area2D

const moveSpeed = 50

func _process(delta):
	position.x -= delta * moveSpeed


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://Menu.tscn")


func _on_Timer_timeout():
	$"YSort/Sprite".offset.y *= -1
