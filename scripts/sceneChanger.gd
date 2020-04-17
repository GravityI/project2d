extends Sprite

export var path = ""

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		get_tree().change_scene(path)
