extends RigidBody2D

const moveSpeed = 100

var vertical = 0
var horizontal = 0
var pressedOnce = false

func _ready():
	pass

func twoAxisInput():
	if Input.is_action_just_pressed("ui_up"):
		if !pressedOnce and (Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
			return
		vertical -= 1
		pressedOnce = true
	if Input.is_action_just_pressed("ui_down"):
		if !pressedOnce and (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
			return
		vertical += 1
		pressedOnce = true
	if Input.is_action_just_pressed("ui_left"):
		if !pressedOnce and (Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_right")):
			return
		horizontal -= 1
		pressedOnce = true
	if Input.is_action_just_pressed("ui_right"):
		if !pressedOnce and (Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_up")):
			return
		horizontal += 1
		pressedOnce = true
	
	if pressedOnce:
		if Input.is_action_just_released("ui_up"):
			vertical += 1
		if Input.is_action_just_released("ui_down"):
			vertical -= 1
		if Input.is_action_just_released("ui_left"):
			horizontal += 1
		if Input.is_action_just_released("ui_right"):
			horizontal -= 1

func _process(_delta):
	twoAxisInput()
	linear_velocity = Vector2(horizontal, vertical)* moveSpeed

func _on_Timer_timeout():
	$"SpritePivot/Sprite".offset.y *= -1
