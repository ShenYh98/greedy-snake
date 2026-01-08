extends CharacterBody2D

@onready var snakeBody = $SnakeBody
@onready var snakeCtrlCamera2D: Camera2D = $SnakeBody/SnakeCtrlCamera2D
@onready var gameOverAudio: AudioStreamPlayer2D = $SnakeBody/GameOverAudio
@onready var eatAudio: AudioStreamPlayer2D =  $SnakeBody/EatAudio

var direction_in = Vector2.ZERO						# 控制器下发移动方向
var body_direction = Vector2.ZERO					# 蛇身节点移动方向
@export var is_move : bool							# 是否移动标志位
@export var speed : float = 150.0					# 移动速度
@export var body_distance : float = 40.0				# 蛇身跟随距离
var body_parts: Array								# 蛇身队列


func create_debug_marker(position: Vector2, direction: Vector2):
	var NewMarker = preload("res://MainGame/snake/marker.tscn")
	var marker = NewMarker.instantiate()
	marker.position = position
	marker.set_direction(direction)  # 如果Marker有这个方法

	get_parent().add_child(marker)


# 蛇前后左右移动
func body_orientation(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_D || event.keycode == KEY_RIGHT:
			pass
		if event.pressed and event.keycode == KEY_S || event.keycode == KEY_DOWN:
			pass
		if event.pressed and event.keycode == KEY_A || event.keycode == KEY_LEFT:
			pass
		if event.pressed and event.keycode == KEY_W || event.keycode == KEY_UP:
			pass


# 新增蛇身
func _add_body() -> void:
	if body_parts.is_empty():
		body_parts.push_back(snakeBody)
	else:
		eatAudio.play() # 新增蛇身播放音效
		var NewBody = preload("res://MainGame/snake/SnakeBody.tscn")
		var newBody = NewBody.instantiate()

		var new_direction = -body_direction
		newBody.position = body_parts[-1].position + new_direction * body_distance
		get_parent().add_child(newBody)
		body_parts.push_back(newBody)


# 清空蛇身
func _clear_body() -> void:
	for i in range(1, body_parts.size()):
		if body_parts[i] and body_parts[i] != snakeBody:
			body_parts[i].queue_free()  # 从场景中删除节点

	body_parts.clear()


func _move(value) -> void:
	is_move = value


# 游戏结束信号
func _game_over() -> void:
	print("游戏结束")
	gameOverAudio.play()
	body_parts[0].animatedSnake.play("AnimatedSnakeOver")


# 游戏开始信号
func _game_start() -> void:
	print("游戏开始")
	body_parts[0].animatedSnake.play("AnimatedSnake")


# 获取键盘信息
func _input(event: InputEvent) -> void:
	if is_move:
		body_orientation(event)


func _ready() -> void:
	print("snake sprite is ready")
	snakeCtrlCamera2D.zoom = Vector2(0.5, 0.5)
	is_move = true


func _process(delta: float) -> void:
	# 增加一个视觉缩放效果
	if snakeCtrlCamera2D.zoom < Vector2(1, 1):
		snakeCtrlCamera2D.zoom += Vector2(0.008, 0.008)

	if is_move:
		if direction_in != Vector2.ZERO:
			body_direction = direction_in

		if !body_parts.is_empty():
			body_parts[0].position += body_direction * speed * delta

		for i in range(1, body_parts.size()):
			var move_direction = (body_parts[i-1].position - body_parts[i].position).normalized()
			if body_parts[i-1].position.distance_to(body_parts[i].position) < body_distance:
				pass
			else:
				body_parts[i].position += move_direction * speed * delta
