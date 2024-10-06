extends Area2D

var curent_enemy
@onready var audio_stream = $AudioStreamPlayer2D

func _on_body_entered(body):
	if body is can_attack:
		curent_enemy = body
		print(body.name)


func _on_body_exited(body):
	if body == curent_enemy:
		curent_enemy = null

func Take_damage(demage: float):
	
	if curent_enemy != null:
		curent_enemy._Take_damage(demage)
		audio_stream.pitch_scale = 2
		audio_stream.play()
	else:
		audio_stream.pitch_scale = randf_range(0.8, 1.2)
		print(audio_stream.pitch_scale)
		audio_stream.play()

