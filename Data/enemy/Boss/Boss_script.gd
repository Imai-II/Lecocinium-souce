extends Node2D

var Max_hp_boss = 15
var hp_boss = 15

var player

var can_create_dangeros = true
var boss_is_dead = false

@export var point_spawn_ayes : Array[Node2D]
@export var point_spawn_Dangeros : Array[Node2D]
@onready var animation_player = $AnimationPlayer

const BOOM_POSITION_PLAUYER = preload("res://Data/enemy/Boss/Attack/Boom_position_plauyer.tscn")


func _on_static_body_2d_take_damage(demage):
	
	animation_player.play("Get_damage")
	
	if hp_boss == Max_hp_boss - 3:
		Max_hp_boss = hp_boss
		position = point_spawn_ayes.pick_random().position
		
	hp_boss = hp_boss - demage
	
	if hp_boss <= 0:
		boss_is_dead = true
		animation_player.play("Die_boos")
		await get_tree().create_timer(5).timeout
		get_tree().change_scene_to_file("res://Data/Map/End_menu.tscn")
	
	print(hp_boss)

func _on_area_2d_body_entered(body):
	if body is Player:
		player = body


func  _physics_process(delta):
	
	if player != null:
		if can_create_dangeros && !boss_is_dead:
			can_create_dangeros = false
			create_dangeros()

func create_dangeros():
	
	var bulet = BOOM_POSITION_PLAUYER.instantiate()
	get_parent().add_child(bulet)
	bulet.global_position = player.global_position
	await get_tree().create_timer(randf_range(0.2, 2)).timeout
	can_create_dangeros = true
