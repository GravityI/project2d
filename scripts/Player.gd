extends Node2D

var vertical = 0
var horizontal = 0
var velocity = Vector2()
var verticalSpeed = 40
var horizontalSpeed = 70
var attacking = false

onready var stateMachine = $"StateMachine"
onready var body = $"Body"
onready var combat = $"AttackArea"

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

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

func startAttackTimer():
	$"Timers/AttackTimer".start()

func startHitTimer():
	$"Timers/HitTimer".start()
	if not $"Timers/AttackTimer".is_stopped():
		$"Timers/AttackTimer".stop()

func takeDamage():
	startHitTimer()
	stateMachine.set_state(stateMachine.states.HIT)
	

func _on_ComboTimer_timeout():
	pass

func _on_AttackTimer_timeout():
	stateMachine.set_state(stateMachine.states.IDLE)

func _on_HitTimer_timeout():
	stateMachine.set_state(stateMachine.states.IDLE)
