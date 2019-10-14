extends KinematicBody2D

const GRAVATY = 20
const SPEED = 30
const UP = Vector2(0,-1)

var motion = Vector2()
var direction = 1 

	
func _physics_process(delta):
	motion.x = SPEED * direction
	motion.y += GRAVATY
	
	if direction == 1 :
		$AnimatedSprite.flip_h = false
	else :
		$AnimatedSprite.flip_h = true
	
	$AnimatedSprite.play("Walk")
		
	
	motion = move_and_slide(motion,UP)

	if is_on_wall() :
		direction = direction * -1
		$RayCast2D.position.x *= -1
	if $RayCast2D.is_colliding() == false :
		direction = direction * -1
		$RayCast2D.position.x *= -1
	if get_node("HitBox").hp <= 0:
		queue_free()
	
	pass
