extends Panel

var pauce : bool
@onready var panel = $"."


func _input(event):
	
	if event.is_action_pressed("ui_escape"):
		panel.visible = !panel.visible


func _on_button_button_down():
	get_tree().change_scene_to_file("res://Data/Map/Start_menu.tscn")


func _on_button_2_button_down():
	get_tree().quit()
