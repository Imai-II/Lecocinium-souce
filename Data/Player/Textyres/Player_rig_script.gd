extends Node2D

@onready var animation_player = $AnimationPlayer


var is_playng
var curent_animation : String = "null"

func playAnimation(name_animation: String):
	if curent_animation != name_animation:
		curent_animation = name_animation
		animation_player.play(name_animation)
