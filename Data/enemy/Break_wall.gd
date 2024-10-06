extends Node

var HP : float = 3

@onready var tile_map = $"../TileMap"

func _on_wall_take_damage(demage):
	HP = HP - demage
	if HP > 0:
		tile_map.visible = false
		await get_tree().create_timer(0.05).timeout
		tile_map.visible = true
	else :
		get_parent().queue_free()

