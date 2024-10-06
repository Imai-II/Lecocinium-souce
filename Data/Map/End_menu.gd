extends Node2D



func _on_button_button_down():
	get_tree().change_scene_to_file("res://Data/Map/Start_menu.tscn")


func _on_button_2_button_down():
	get_tree().quit()
