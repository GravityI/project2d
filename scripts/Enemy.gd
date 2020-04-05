extends Node2D

var health = 9

onready var combat = $"AttackArea"
onready var player = $"../Player"
onready var follow = $"FollowArea"
onready var stateMachine = $"StateMachine"
onready var sprite = $"EnemyBody/Sprite"

var canAttack = true
var dealtDamage = false

func _ready():
	$"CanvasLayer/Health".text = str(health)

func takeDamage():
	if stateMachine.state != stateMachine.states.DEAD:
		health -= 1
		$"CanvasLayer/Health".text = str(health)
		stateMachine.set_state(stateMachine.states.HIT)

func startAttackTimer():
	$"AttackTimer".start()

func playerInAttackRange():
	for body in combat.get_overlapping_bodies():
		if body.is_in_group("player"):
			return true
	return false

func dealDamage():
	for body in combat.get_overlapping_bodies():
		if body.is_in_group("player"):
			player.takeDamage()
			canAttack = false
			startAttackTimer()

func playerInFollowRange():
	for body in follow.get_overlapping_bodies():
		if body.is_in_group("player"):
			return true
	return false

func _on_AttackTimer_timeout():
	canAttack = true
	dealtDamage = false

func setAnimation(animation):
	sprite.animation = animation

func getAnimationFrame():
	return sprite.frame

func getPlayerHealth():
	return player.health
