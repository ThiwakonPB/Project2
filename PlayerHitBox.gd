extends Area2D
signal shake
signal is_dead
var hp = 2

func _physics_process(delta):

	if hp <= 0 :
		print("dead")
		emit_signal("is_dead")
	pass

func _take_damage():
	hp -= 1
	emit_signal("shake")
