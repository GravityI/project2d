extends Area2D

const moveSpeed = 50
var crashed = false

func _process(delta):
	position.x -= delta * moveSpeed


func _on_Area2D_body_entered(body):
	if body.is_in_group("player") and !crashed:
		$"../crash".play()
		crashed = true
		body.health -= 1
		if body.health <= 0:
			get_tree().paused = true
			yield(get_tree().create_timer(1),"timeout")
			get_tree().paused = false
			get_tree().change_scene("res://Menu.tscn")


func _on_Timer_timeout():
	$"YSort/Sprite".offset.y *= -1


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		crashed = false
