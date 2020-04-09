extends PopupMenu

func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		popup()

func unpause():
	$"../..".horizontal = 0
	$"../..".vertical = 0
	$"../..".pressedOnce = false
	get_tree().paused = false

func _on_PopupMenu_index_pressed(index):
	unpause()
	match index:
		0:
			hide()
		1:
			get_tree().change_scene("res://Menu.tscn")
		2:
			get_tree().quit()
