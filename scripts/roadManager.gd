extends Node


export var moveSpeed = 300
export var teleportPos = 452

func _process(delta):
	for child in get_children():
		child.position.x -= delta * moveSpeed
		if child.position.x <= -teleportPos:
			child.position.x = teleportPos
