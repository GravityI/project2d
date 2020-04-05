extends PopupMenu

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		popup()

func unpause():
	get_tree().paused = false
	$"../../Player".horizontal = 0
	$"../../Player".vertical = 0

func _on_PopupMenu_index_pressed(index):
	call_deferred("unpause")
	match index:
		0:
			hide()
		1:
			get_tree().change_scene("res://Menu.tscn")
		2:
			get_tree().quit()
