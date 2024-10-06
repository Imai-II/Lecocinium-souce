extends Node2D

@onready var player_rig = $CanvasLayer/PlayerRig

func _ready():
	player_rig.playAnimation("Menu_animation")

# кнопка выхода из игры
func _on_button_2_button_down():
	get_tree().quit()


func _on_button_button_down():
	get_tree().change_scene_to_file("res://Data/Map/Map_0.tscn")
