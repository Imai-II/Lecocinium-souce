extends Node2D

var player_b
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	if !animation_player.is_playing():
		animation_player.play("Boom_attack")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func damage_self():
	if player_b != null:
		player_b.get_damage()
		print("damage")

func delite_self():
	queue_free()


func _on_area_2d_body_entered(body):
	if body is Player:
		player_b = body


func _on_area_2d_body_exited(body):
		if body is Player:
			player_b = null
