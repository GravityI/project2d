extends Area2D
export var BodyPath = ""


func _process(_delta):
	position.x = get_node(BodyPath).position.x
	position.y = get_node(BodyPath).position.y
