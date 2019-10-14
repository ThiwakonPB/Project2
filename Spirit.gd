extends KinematicBody2D


func _ready():
	set_process(true)
func _process(delta):
	var motionx = (get_global_mouse_position().x - position.x) * 0.2
	var motiony = (get_global_mouse_position().y - position.y) * 0.2
	translate(Vector2(motionx, motiony))

func _input(event):
	if Input.is_action_pressed("ui_click") :
		$Particles2D.set_emitting(true)
		$Attack/CollisionShape2D.set_disabled(false)
	else : 
		$Particles2D.set_emitting(false)
		$Attack/CollisionShape2D.set_disabled(true)


func _on_Attack_area_entered(area):
	if area.is_in_group("hitbox"):
		area._take_damage()
	
