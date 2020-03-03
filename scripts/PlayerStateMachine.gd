extends StateMachine

enum states {
	IDLE, WALKING, ATTACKING, COMBO1, COMBO2, HIT
}

func _ready():
	call_deferred("set_state", states.IDLE)

func _state_logic(delta):
	parent.twoAxisInput()
	match state:
		states.IDLE:
			parent.movement()
		states.WALKING:
			parent.movement()
		states.ATTACKING:
			pass
		states.COMBO1:
			pass
		states.COMBO2:
			pass
		states.HIT:
			pass

func _get_transition(delta):
	#Return new state
	match state:
		states.IDLE:
			if parent.vertical != 0 or parent.horizontal != 0:
				return states.WALKING
			elif Input.is_action_just_pressed("attack"):
				return states.ATTACKING
		states.WALKING:
			if parent.vertical == 0 and parent.horizontal == 0:
				return states.IDLE
			elif Input.is_action_just_pressed("attack"):
				return states.ATTACKING
		states.ATTACKING:
			if Input.is_action_just_pressed("attack") and !parent.getEnemiesInRange().empty():
				return states.COMBO1
		states.COMBO1:
			if Input.is_action_just_pressed("attack") and !parent.getEnemiesInRange().empty():
				return states.COMBO2
		states.COMBO2:
			pass
		states.HIT:
			pass

	return null

func _enter_state(new_state, old_state):
	match new_state:
		states.IDLE:
			#Labels are for debugging
			$"CanvasLayer/Label".text = "Idle"
		states.WALKING:
			$"CanvasLayer/Label".text = "Walking"
		states.ATTACKING:
			parent.startAttackTimer()
			parent.dealDamage()
			$"CanvasLayer/Label".text = "Attack"
		states.COMBO1:
			parent.startAttackTimer()
			parent.dealDamage()
			$"CanvasLayer/Label".text = "Combo 1"
		states.COMBO2:
			parent.startAttackTimer()
			parent.dealDamage()
			$"CanvasLayer/Label".text = "Combo 2"
		states.HIT:
			parent.startHitTimer()
			$"CanvasLayer/Label".text = "Hit"
	
func _exit_state(old_state, new_state):
	match old_state:
		states.IDLE:
			pass
		states.WALKING:
			parent.body.linear_velocity = Vector2()
		states.ATTACKING:
			pass
		states.COMBO1:
			pass
		states.COMBO2:
			pass
		states.HIT:
			pass
