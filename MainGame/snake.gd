extends Sprite2D

@onready var snakeHead = $Head
@onready var snakeBody = $Body

var direction_in = Vector2.ZERO
var direction_cur = Vector2.ZERO
var is_move


func body_orientation(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_A || event.keycode == KEY_LEFT:
			snakeBody.position = Vector2(snakeHead.position.x + 100, snakeHead.position.y)
		if event.pressed and event.keycode == KEY_D || event.keycode == KEY_RIGHT:
			snakeBody.position = Vector2(snakeHead.position.x - 100, snakeHead.position.y)
		if event.pressed and event.keycode == KEY_W || event.keycode == KEY_UP:
			snakeBody.position = Vector2(snakeHead.position.x, snakeHead.position.y + 100)
		if event.pressed and event.keycode == KEY_S || event.keycode == KEY_DOWN:
			snakeBody.position = Vector2(snakeHead.position.x, snakeHead.position.y - 100)


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
			direction_cur = direction_in
			position += direction_cur * 100 * delta
		else:
			position += direction_cur * 100 * delta
