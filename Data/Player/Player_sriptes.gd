extends BaseState

export (float) var jump_buffer_time = 0.1
export (float) var move_speed = 60
export (NodePath) var run_node
export (NodePath) var idle_node
export (NodePath) var jump_node

onready var run_state: BaseState = get_node(run_node)
onready var idle_state: BaseState = get_node(idle_node)
onready var jump_state: BaseState = get_node(jump_node)

var jump_buffer_timer: float = 0.0

func enter() -> void:
	.enter()
	jump_buffer_timer = 0

func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed('jump'):
		jump_buffer_timer = jump_buffer_time

	return null

func physics_process(delta: float) -> BaseState:
	jump_buffer_timer -= delta

	var move = 0
	if Input.is_action_pressed("move_left"):
		move = -1
		player.animations.flip_h = true
	elif Input.is_action_pressed("move_right"):
		move = 1
		player.animations.flip_h = false

	player.velocity.x = move * move_speed
	player.velocity.y += player.gravity
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

	if player.is_on_floor():
		if jump_buffer_timer > 0:
			return jump_state
		if move != 0:
			return run_state
		else:
			return idle_state
	return null
