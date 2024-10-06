extends StaticBody2D
class_name can_attack

signal Take_damage(demage)

func _Take_damage(damage):
	Take_damage.emit(damage)
