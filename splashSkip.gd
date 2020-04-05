extends VideoPlayer

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		get_tree().change_scene("res://Menu.tscn")

func _on_VideoPlayer_finished():
	get_tree().change_scene("res://Menu.tscn")
