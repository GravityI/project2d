extends CanvasLayer

var selectedButtonIndex = 0

onready var buttonListSize = $"VBoxContainer".get_child_count()

func _ready():
	$"VBoxContainer/Start".grab_focus()

func _on_Start_pressed():
	get_tree().change_scene("res://imageScenes/prebeat.tscn")

func _on_Credits_pressed():
	get_tree().change_scene("res://Credits.tscn")

func _on_Quit_pressed():
	get_tree().quit()

func _on_Tutorial_pressed():
	get_tree().change_scene("res://tutorial.tscn")
