extends Area2D
export var BodyPath = ""

func _process(delta):
	position = get_node(BodyPath).position + Vector2(64, -8)*scale
