extends Control

@onready var snake = $Snake

signal signal_move(value: bool)	# 是否移动信号
signal signal_add_body()			# 增加蛇身信号
signal signal_clear_body()		# 清空蛇身长度信号
signal signal_game_over()		# 游戏结束
signal signal_game_start()		# 游戏开始

func _ready() -> void:
	print("snake ctrl is ready")
	signal_move.connect(snake._move)
	signal_add_body.connect(snake._add_body)
	signal_clear_body.connect(snake._clear_body)
	signal_game_over.connect(snake._game_over)
	signal_game_start.connect(snake._game_start)


func _process(_delta: float) -> void:
	snake.direction_in = Input.get_vector("left", "right", "up", "down")
