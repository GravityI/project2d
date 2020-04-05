extends Node2D

var vertical = 0
var horizontal = 0
var velocity = Vector2()
var verticalSpeed = 50
var horizontalSpeed = 100
var attacking = false
var health = 5
var dealtDamage = false

onready var stateMachine = $"StateMachine"
onready var body = $"Body"
onready var combat = $"AttackArea"
onready var sprite = $"Body/Sprite"
onready var barTween = $"UILayer/Control/ProgressBar/Tween"
onready var audioPlayer = $"StateMachine/AudioStreamPlayer"
onready var attackSound1 = load("res://audio/Punch1.wav")
onready var attackSound2 = load("res://audio/Punch2.wav")
onready var attackSound3 = load("res://audio/Punch3.wav")

func playSound(sound):
	audioPlayer.stream = sound
	audioPlayer.play()

func movement():
	if stateMachine.state in [stateMachine.states.WALKING, stateMachine.states.IDLE]:
		velocity = Vector2(horizontal * horizontalSpeed, vertical * verticalSpeed)
		body.linear_velocity = lerp(body.linear_velocity, velocity, 0.5)

func twoAxisInput():
		if Input.is_action_just_pressed("ui_up"):
			vertical -= 1
		if Input.is_action_just_pressed("ui_down"):
			vertical += 1
		if Input.is_action_just_pressed("ui_left"):
			horizontal -= 1
		if Input.is_action_just_pressed("ui_right"):
			horizontal += 1
		
		if Input.is_action_just_released("ui_up"):
			vertical += 1
		if Input.is_action_just_released("ui_down"):
			vertical -= 1
		if Input.is_action_just_released("ui_left"):
			horizontal += 1
		if Input.is_action_just_released("ui_right"):
			horizontal -= 1
		
		if horizontal > 0 and stateMachine.state in [stateMachine.states.WALKING, stateMachine.states.IDLE]: 
			sprite.scale.x = 1
			combat.scale.x = 1
		elif horizontal < 0 and stateMachine.state in [stateMachine.states.WALKING, stateMachine.states.IDLE]: 
			sprite.scale.x = -1
			combat.scale.x = -1

func takeDamage():
	health -= 1
	stateMachine.set_state(stateMachine.states.HIT)
	$"UILayer/Control/ProgressBar".value = health

func getEnemiesInRange():
	var bodyList = []
	for body in combat.get_overlapping_bodies():
		if body.is_in_group("enemy"):
			if body.get_parent().stateMachine.state != body.get_parent().stateMachine.states.DEAD:
				bodyList.append(body)
	return bodyList

func dealDamage():
	if !getEnemiesInRange().empty():
		for body in getEnemiesInRange():
			body.get_parent().takeDamage()
		if stateMachine.state == stateMachine.states.ATTACKING:
			playSound(attackSound1)
		elif stateMachine.state == stateMachine.states.COMBO1:
			playSound(attackSound2)
		elif stateMachine.state == stateMachine.states.COMBO2:
			playSound(attackSound3)
		dealtDamage = true

func setAnimation(animation):
	sprite.animation = animation

func getAnimationFrame():
	return sprite.frame
