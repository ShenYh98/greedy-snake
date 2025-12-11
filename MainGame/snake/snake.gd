extends CharacterBody2D

@onready var snakeBody = $SnakeBody

var direction_in = Vector2.ZERO
var direction_cur = Vector2.ZERO
@export var is_move : bool
enum DFLAG {LEFT, RIGHT, UP, DOWN}
@export var directionFlag : DFLAG
@export var speed : float = 100.0
var body_parts: Array
var body_direction: Array

# 蛇前后左右移动
func body_orientation(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_D || event.keycode == KEY_RIGHT:
			directionFlag = DFLAG.RIGHT
		if event.pressed and event.keycode == KEY_S || event.keycode == KEY_DOWN:
			directionFlag = DFLAG.DOWN
		if event.pressed and event.keycode == KEY_A || event.keycode == KEY_LEFT:
			directionFlag = DFLAG.LEFT
		if event.pressed and event.keycode == KEY_W || event.keycode == KEY_UP:
			directionFlag = DFLAG.UP


func turn_direction(curPos: Vector2, pos: Vector2, direction: DFLAG) -> bool:
	if curPos.distance_to(pos) < 1.0:
		print("到达： ", pos, " 方向： ", direction)
		if direction == DFLAG.RIGHT:
			return true
		elif direction == DFLAG.LEFT:
			return true
		elif direction == DFLAG.DOWN:
			return true
		elif direction == DFLAG.UP:
			return true

	return false


# 新增蛇身
func _add_body() -> void:
	if body_parts.is_empty():
		body_parts.push_back(snakeBody)
		body_direction.push_back(Vector2.DOWN);
	else:
		var NewBody = preload("res://MainGame/snake/SnakeBody.tscn")
		var newBody = NewBody.instantiate()

		var last_part_pos = body_parts[-1].position
		newBody.position = last_part_pos + Vector2(0, 80)

		add_child(newBody)
		body_parts.push_back(newBody)
		body_direction.push_back(Vector2.DOWN);


func _move(value) -> void:
	is_move = value


# 获取键盘信息
func _input(event: InputEvent) -> void:
	if is_move:
		body_orientation(event)


func _ready() -> void:
	print("snake sprite is ready")
	is_move = true

	for i in range(4):
		_add_body()


func _process(delta: float) -> void:
	if is_move:
		if direction_in != Vector2.ZERO:
			direction_cur = direction_in

		for i in range(body_parts.size()):
			body_parts[i].position += direction_cur * speed * delta
			#body_parts[i].position += body_direction[i] * speed * delta
			
			#if turn_direction(body_parts[i].position, Vector2(0, 300), DFLAG.RIGHT):
				#body_direction[i] = Vector2.RIGHT
			#if turn_direction(body_parts[i].position, Vector2(100, 300), DFLAG.UP):
				#body_direction[i] = Vector2.UP
			#if turn_direction(body_parts[i].position, Vector2(100, 0), DFLAG.LEFT):
				#body_direction[i] = Vector2.LEFT
			#if turn_direction(body_parts[i].position, Vector2(0, 0), DFLAG.DOWN):
				#body_direction[i] = Vector2.DOWN

		#velocity = direction_cur * 100 * delta # 碰撞体参数
		#move_and_slide()
