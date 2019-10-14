extends Area2D


signal shake
var hp = 3

func _physics_process(delta):

	if hp <= 0 :
		print("dead")
	pass

func _take_damage():
	hp -= 1
	emit_signal("shake")