extends CharacterBody2D

@onready var snakeBody = $SnakeBody

var direction_in = Vector2.ZERO						# 控制器下发移动方向
@export var is_move : bool							# 是否移动标志位
@export var speed : float = 100.0					# 移动速度
var body_parts: Array								# 蛇身队列
var body_direction: Array							# 每个蛇身节点移动方向
var body_direction_point: Dictionary[int, Array]		# 将拐点变化记录到这个字典中

# 蛇前后左右移动
func body_orientation(event: InputEvent) -> void:
	if event is InputEventKey:
		var pos
		if event.pressed and event.keycode == KEY_D || event.keycode == KEY_RIGHT:
			pos = {
				"directionFlag" : Vector2.RIGHT,
				"position" : snakeBody.position
			}
		if event.pressed and event.keycode == KEY_S || event.keycode == KEY_DOWN:
			pos = {
				"directionFlag" : Vector2.DOWN,
				"position" : snakeBody.position
			}
		if event.pressed and event.keycode == KEY_A || event.keycode == KEY_LEFT:
			pos = {
				"directionFlag" : Vector2.LEFT,
				"position" : snakeBody.position
			}
		if event.pressed and event.keycode == KEY_W || event.keycode == KEY_UP:
			pos = {
				"directionFlag" : Vector2.UP,
				"position" : snakeBody.position
			}
		if event.pressed:
			for i in range(1, body_parts.size()):
				if body_direction_point.has(i):
					body_direction_point[i].push_back(pos)
				else:
					body_direction_point[i] = []
					body_direction_point[i].push_back(pos)


func turn_direction(num, size, curPos, pos, direction) -> bool:
	if curPos.distance_to(pos) < 1:
		print("蛇身第", num, "段", " 拐点队列大小：", size, " 当前坐标:", curPos, " 到达坐标：", pos, " 方向：", direction)
		print("误差：", curPos - pos)
		if direction == Vector2.RIGHT:
			return true
		elif direction == Vector2.LEFT:
			return true
		elif direction == Vector2.DOWN:
			return true
		elif direction == Vector2.UP:
			return true

	return false


# 新增蛇身
func _add_body() -> void:
	if body_parts.is_empty():
		body_parts.push_back(snakeBody)
		body_direction.push_back(Vector2.UP);
	else:
		var NewBody = preload("res://MainGame/snake/SnakeBody.tscn")
		var newBody = NewBody.instantiate()

		if body_direction[-1] == Vector2.UP:
			newBody.position = body_parts[-1].position + Vector2(0, 80)
		if body_direction[-1] == Vector2.DOWN:
			newBody.position = body_parts[-1].position + Vector2(0, -80)
		if body_direction[-1] == Vector2.LEFT:
			newBody.position = body_parts[-1].position + Vector2(80, 0)
		if body_direction[-1] == Vector2.RIGHT:
			newBody.position = body_parts[-1].position + Vector2(-80, 0)

		add_child(newBody)
		body_parts.push_back(newBody)
		body_direction.push_back(body_direction[-1]);
		
		# 复制上一个蛇身拐点数据到现在蛇身
		if body_parts.size() > 2:
			if body_direction_point.has(body_parts.size()-2):
				body_direction_point[body_parts.size()-1] = []
				body_direction_point[body_parts.size()-1] = body_direction_point[body_parts.size()-2]


# 清空蛇身
func _clear_body() -> void:
	for i in range(1, body_parts.size()):
		if body_parts[i] and body_parts[i] != snakeBody:
			body_parts[i].queue_free()  # 从场景中删除节点

	body_parts.clear()
	body_direction.clear()
	body_direction_point.clear()


func _move(value) -> void:
	is_move = value


# 获取键盘信息
func _input(event: InputEvent) -> void:
	if is_move:
		body_orientation(event)


func _ready() -> void:
	print("snake sprite is ready")
	is_move = true


func _process(delta: float) -> void:
	if is_move:
		if direction_in != Vector2.ZERO:
			body_direction[0] = direction_in

		if !body_parts.is_empty():
			body_parts[0].position += body_direction[0] * speed * delta

		for i in range(1, body_parts.size()):
			body_parts[i].position += body_direction[i] * speed * delta
			if !body_direction_point.is_empty():
				if body_direction_point.has(i):
					if !body_direction_point[i].is_empty():
						if turn_direction(i, body_direction_point[i].size(), body_parts[i].position, body_direction_point[i][0].position, body_direction_point[i][0].directionFlag):
							body_direction[i] = body_direction_point[i][0].directionFlag
							body_direction_point[i].pop_front()
