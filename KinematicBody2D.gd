extends KinematicBody2D

const UP = Vector2(0,-1)
const MAX_SPEED = 300 
const JUMP_HEIGHT = -400 
const ACCELERATION = 50

var GRAVITY = 20
var double_jump = 2
var double_jump_max = 2
var jump_timer = 0.2
var jump_timer_fall = 0.2
var motion = Vector2() 
var dash = 1
var dash_timer = 0.5



#func _check_is_valid_wall (wall_ray_casts):
#	for raycast in wall_ray_casts.get_children():
#		if raycast.is_colliding():
#			return true


func _physics_process(delta):
#	if get_node("HitBox").hp <= 0:
#		queue_free()

	motion.y += GRAVITY
	jump_timer -= delta
	jump_timer_fall -= delta
	dash_timer -= delta
	var friction = false
	
	if $LRayCast2D.is_colliding() :
		GRAVITY = 4
	elif $RRayCast2D.is_colliding():
		GRAVITY = 4
	else :
		GRAVITY = 20
		
	if $LRayCast2D.is_colliding() && !is_on_floor():
		if Input.is_action_pressed("ui_up") && Input.is_action_pressed("ui_left"):
			motion.y = JUMP_HEIGHT
			motion.x = 400
		elif Input.is_action_pressed("ui_up") && !Input.is_action_pressed("ui_left"):
			motion.y = JUMP_HEIGHT
			print("FUCK")
			motion.x = 4000
		
	if $RRayCast2D.is_colliding() && !is_on_floor():
		if Input.is_action_pressed("ui_up") && Input.is_action_pressed("ui_right"):
			motion.y = JUMP_HEIGHT
			motion.x = -400
		elif Input.is_action_pressed("ui_up") && !Input.is_action_pressed("ui_right"):
			motion.y = JUMP_HEIGHT
			motion.x = -4000
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
		
	
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
		
	
	else :
		$Sprite.play("Idle")
		friction = true
	
#	Double jump checker
	if !is_on_floor():
#		Lets the player have a time window to jump after running off the edge of tiles
		if Input.is_action_just_pressed("ui_up") && double_jump == 1:
			motion.y = JUMP_HEIGHT
#			print("double jump")
			double_jump -= 1 
		if Input.is_action_just_pressed("ui_up") && jump_timer_fall > 0 && double_jump == 2  :
			motion.y = JUMP_HEIGHT
#			print("jump 1")
			double_jump -= 1 

	if Input.is_action_just_pressed("ui_up") :
		jump_timer = 0.2

	if is_on_floor(): 
		double_jump = double_jump_max
		jump_timer_fall = 0.2
		if friction == true :
			motion.x = lerp(motion.x, 0 , 0.2)
		if jump_timer > 0:
			motion.y = JUMP_HEIGHT
			double_jump -= 1
		
	
	else :
		if motion.y < 0 :
			$Sprite.play("Jump")
		else : 
			$Sprite.play("Fall")
		if friction == true :
			motion.x = lerp(motion.x, 0 , 0.5)

	
	
	
	motion = move_and_slide(motion,UP)

func _dash():
	if dash>0 :
		print("ok")
	
	pass 



func _on_HitBox_is_dead():
	queue_free()
	pass # Replace with function body.
