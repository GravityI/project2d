extends StateMachine

enum states { IDLE, WALKING, ATTACKING, COMBO1, COMBO2, HIT, DEAD }

func _ready():
	call_deferred("set_state", states.IDLE)

func _state_logic(_delta):
	parent.twoAxisInput()
	match state:
		states.IDLE:
			parent.movement()
		states.WALKING:
			parent.movement()
		states.ATTACKING:
			if parent.sprite.frame == 1 and !parent.dealtDamage:
				parent.dealDamage()
		states.COMBO1:
			if parent.sprite.frame == 2 and !parent.dealtDamage:
				parent.dealDamage()
		states.COMBO2:
			if parent.sprite.frame == 2 and !parent.dealtDamage:
				parent.dealDamage()
		states.HIT:
			pass
		states.DEAD:
			if parent.getAnimationFrame() == 7:
				get_tree().change_scene("res://Menu.tscn")

func _get_transition(_delta):
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
			if Input.is_action_just_pressed("attack") and !parent.getEnemiesInRange().empty() and parent.getAnimationFrame() == 2:
				return states.COMBO1
			elif parent.getAnimationFrame() == 3:
				return states.IDLE
		states.COMBO1:
			if Input.is_action_pressed("attack") and !parent.getEnemiesInRange().empty() and parent.getAnimationFrame() == 5:
				return states.COMBO2
			elif parent.getAnimationFrame() == 6:
				return states.IDLE
		states.COMBO2:
			if parent.getAnimationFrame() == 5:
				return states.IDLE
		states.HIT:
			if parent.health <= 0:
				return states.DEAD
			elif parent.getAnimationFrame() == 1:
				return states.IDLE
	return null

func _enter_state(new_state, _old_state):
	match new_state:
		states.IDLE:
			parent.setAnimation("idle")
		states.WALKING:
			parent.setAnimation("walk")
		states.ATTACKING:
			parent.dealtDamage = false
			parent.setAnimation("attack")
		states.COMBO1:
			parent.dealtDamage = false
			parent.setAnimation("combo1")
		states.COMBO2:
			parent.dealtDamage = false
			parent.setAnimation("combo2")
		states.HIT:
			parent.setAnimation("hit")
		states.DEAD:
			parent.setAnimation("dead")
	
func _exit_state(old_state, _new_state):
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
