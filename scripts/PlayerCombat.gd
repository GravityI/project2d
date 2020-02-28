extends Area2D

var comboStage = 0
var comboEnabled = false
var hitBodiesList

func _ready():
	monitoring = false

func _process(delta):
	position = $"../Body".position + Vector2(64, -8)

	if monitoring:
		for body in get_overlapping_bodies():
			if body.has_method("takeDamage"):
				body.takeDamage(comboStage)
				comboEnabled = true
