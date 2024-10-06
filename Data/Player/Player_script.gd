extends CharacterBody2D
class_name Player

@export var player_hp = 3

const ground_speed = 300.0

const JUMP_VELOCITY = -400.0

var jump_buffer_timer: float = 0.0

const JUMP_VELOCITY_STEP = 30
var jump_power_initial = 200
var jump_power = 0
var jump_timer_max = 0.19
var jump_timer = 0.0
var is_jumping = false

@onready var ray_cast = $RayCast2D

@onready var flip_direction = $FlipDirection
@onready var player_rig = $FlipDirection/PlayerRig


#настройки камеры
@onready var camera_2d = $Camera2D
@export var camera_offcet : Vector2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var can_attack : bool = true
var attacking : bool
var curent_attack : int
@onready var timer = $Timer
@onready var arm_can = $Arm_can

@onready var area_damage = $FlipDirection/Area_damage

var can_move : bool

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += (gravity * 2) * delta
		
		#Игрок не на земле
		jump_timer += delta
	else:
		jump_timer = 0
		is_jumping = false


	# Нажатие кнопики прыжка
	if Input.is_action_just_pressed("ui_jump") && is_on_floor() && !attacking:
		jump_timer = 0.0
		is_jumping = true
		apply_jump_force(jump_power_initial)
		jump_power = jump_power_initial
		#cюда анмацию
		
	elif Input.is_action_pressed("ui_jump") && is_jumping && jump_timer < jump_timer_max:
		jump_power += JUMP_VELOCITY_STEP
		apply_jump_force(jump_power)
	
	# Get the input direction and handle the movement/deceleration
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")

	
	if is_on_floor():
		if direction:
			velocity.x = direction * ground_speed
			if direction < 0:
				flip_direction.scale.x = -1
			else:
				flip_direction.scale.x = 1
		else:
			velocity.x = lerp(velocity.x, direction * ground_speed, delta * 8)
	else:
		velocity.x = lerp(velocity.x, direction * ground_speed, delta * 4)
	
	#обновление анимаций
	if is_on_floor():
		
		if Input.is_action_just_pressed("left_mouse_button") && can_attack:
			can_attack = false
			attacking = true
			if curent_attack == 0:
				curent_attack = 1
				player_rig.playAnimation("first_attack")
				arm_can.start(0.4)
			elif curent_attack == 1:
				curent_attack = 2
				player_rig.playAnimation("second_attack")
				arm_can.start(0.4)
			elif curent_attack == 2:
				curent_attack = 3
				player_rig.playAnimation("third_attack")
				arm_can.start(0.5)
			elif curent_attack == 3:
				arm_can.start(0.8)
			timer.start(0.8)


		if !attacking:
			if direction == 0:
				player_rig.playAnimation("idle")
			else:
				player_rig.playAnimation("run")
	else:
		player_rig.playAnimation("jump")

	if !attacking:
		move_and_slide()

func apply_jump_force(power):
	velocity.y = -power

func _input(event):
	if event.is_action_released("ui_jump") && is_jumping:
		jump_timer = jump_timer_max #делам таймер с максимальным значением
		velocity.y += gravity / 4

func _on_timer_timeout():
	attacking = false
	curent_attack = 0
	timer.stop()
func _on_arm_can_timeout():
	attack(1)
	can_attack = true
	arm_can.stop()
	
@onready var hert_3 = $CanvasLayer/PanelContainer/Hert3

var inbrecable : bool
@onready var inbrecable_timer = $inbrecable

func get_damage():
	
	if inbrecable == false:
		inbrecable = true
		player_hp = player_hp - 1
		player_rig.playAnimation("get_damage")
		inbrecable_timer.start(2)
		timer.start(0.4)
	
	if player_hp == 2:
		hert_3.visible = false
	elif player_hp == 1:
		$CanvasLayer/PanelContainer/Hert2.visible = false
	
	attacking = true
	
	if player_hp <= 0:
		get_tree().reload_current_scene()

func attack(damage : float):
	area_damage.Take_damage(damage)


func _on_inbrecable_timeout():
	inbrecable = false
