extends StateMachine

const verticalSpeed = 20
const horizontalSpeed = 50

var velocity = Vector2()

enum states { IDLE, ATTACKING, FOLLOW, HIT, DEAD }

#Substituir as onready vars pelas do parent.
onready var body = $"../EnemyBody"
onready var playerBody = $"../../Player/Body"
onready var combat = $"../AttackArea"
onready var followArea = $"../FollowArea"

func _ready():
	call_deferred("set_state", states.FOLLOW)

func _state_logic(delta):
	match state:
		states.IDLE:
			pass
		states.ATTACKING:
			if parent.canAttack and parent.getAnimationFrame() == 3:
				parent.dealDamage()
		states.FOLLOW:
			var relativePos = body.global_position - playerBody.global_position
			if relativePos.x > 60:
				velocity.x = -horizontalSpeed
			elif relativePos.x < -60:
				velocity.x = horizontalSpeed
			else:
				velocity.x = 0
			if relativePos.y > 0:
				velocity.y = -verticalSpeed
			elif relativePos.y < 0:
				velocity.y = verticalSpeed
			else:
				velocity = Vector2()
				
			if relativePos.x > 0:
				combat.scale.x = -1
				parent.sprite.flip_h = true
			elif relativePos.x < 0:
				combat.scale.x = 1
				parent.sprite.flip_h = false
			body.linear_velocity = velocity
		states.HIT:
			pass
		states.DEAD:
			if parent.getAnimationFrame() == 10:
				parent.queue_free()

func _get_transition(delta):
	match state:
		states.IDLE:
			if parent.playerInAttackRange() and parent.canAttack and parent.getPlayerHealth() > 0:
				return states.ATTACKING
			elif parent.playerInFollowRange() and !parent.playerInAttackRange():
				return states.FOLLOW
		states.ATTACKING:
			if parent.getAnimationFrame() == 4:
				return states.IDLE
		states.FOLLOW:
			if parent.playerInAttackRange() and parent.canAttack:
				return states.ATTACKING
			elif !parent.playerInFollowRange():
				return states.IDLE
		states.HIT:
			if parent.health <= 0:
				return states.DEAD
			elif parent.getAnimationFrame() == 2:
				return states.IDLE

func _enter_state(new_state, old_state):
	match new_state:
		states.IDLE:
			parent.setAnimation("idle")
			$"../CanvasLayer/State".text = "Idle"
		states.ATTACKING:
			parent.setAnimation("attack")
			$"../CanvasLayer/State".text = "Attacking"
		states.FOLLOW:
			parent.setAnimation("walk")
			$"../CanvasLayer/State".text = "Follow"
		states.HIT:
			parent.setAnimation("hit")
			$"../CanvasLayer/State".text = "Hit"
		states.DEAD:
			$"../AttackTimer".stop()
			parent.setAnimation("dead")
			$"../CanvasLayer/State".text = "Dead"

func _exit_state(old_state, new_state):
	match old_state:
		states.IDLE:
			pass
		states.ATTACKING:
			parent.canAttack = false
			$"../AttackTimer".start()
		states.FOLLOW:
			body.linear_velocity = Vector2()
		states.HIT:
			pass

