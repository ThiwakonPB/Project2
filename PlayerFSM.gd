extends StateMachine

func _ready():
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	call_deferred("set_state", states.idle)

func _state_logic(delta):
	parent._apply_movement()
	parent._apply_gravity(delta)
	
	pass 

func _get_transition(delta):
	match state:
		states.idle:
			if !parent.is_on_floor():
				if parent.velocity.y <0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x != 0:
				return states.run
		states.run:
			if !parent.is_on_floor():
				if parent.velocity.y <0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x == 0:
				return states.idle
		states.jump:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y >= 0 :
				return states.fall
		states.fall:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y < 0 :
				return states.jump
	return null

func _enter_state(new_state, old_state):
#	match new_state:
#		states.idle:
#			parent.AnimatedSprite.play("Idle")
#		states.run:
#			parent.AnimatedSprite.play("Run")
#		states.jump:
#			parent.Sprite.play("Jump")
#		states.fall:
#			parent.Sprite.play("Fall")
	pass

func _exit_state(old_state, new_state):
	pass 